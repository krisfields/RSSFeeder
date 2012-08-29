//
//  RSSViewController.m
//  RSSFeeder
//
//  Created by Kris Fields on 8/28/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "RSSViewController.h"
#import <RestKit/RestKit.h>
#import "Article.h"
#import "ArticleViewController.h"

@interface RSSViewController () <UITableViewDataSource, UITableViewDelegate, RKRequestDelegate>
@property (strong, nonatomic) NSMutableArray *articles;
@end

@implementation RSSViewController
@synthesize articlesTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //get rss feed array of articles
    [RKClient clientWithBaseURLString:@"http://www.economist.com/"];
    RKClient* client = [RKClient sharedClient];
    self.articles = [NSMutableArray new];
    
    [client get:@"blogs/americasview/index.xml" queryParameters:nil delegate:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setArticlesTable:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
}


-(void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    id xmlParser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeXML];
    id parsedResponse = [xmlParser objectFromString:[response bodyAsString] error:nil];
    NSArray *parsedArrayOfDictionariesInResponse = [[[parsedResponse objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"item"];
    for (NSDictionary *parsedDictionaryForArticle in parsedArrayOfDictionariesInResponse) {
        Article *newArticle = [[Article alloc]init];
        newArticle.title =  [parsedDictionaryForArticle objectForKey:@"title"];
        newArticle.link = [NSURL URLWithString:[parsedDictionaryForArticle objectForKey:@"link"]];
        NSLog(@"article title: %@", newArticle.title);
        
        newArticle.imageLink = [newArticle getFirstImageLinkFromXML:[parsedDictionaryForArticle objectForKey:@"description"]];
        
        [self.articles addObject:newArticle];
    }
    [self.articlesTable reloadData];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.articles) {
        return [self.articles count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    // Configure the cell...
    Article *article = [self.articles objectAtIndex:[indexPath row]];
    cell.textLabel.text = [article title];
    
    article.rssVC = self;
    [article getThumbnailImageFromArticle:^(void){
        cell.imageView.image = article.image;
        
    }];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleViewController *articleVC = [[ArticleViewController alloc]init];
    articleVC.someLink = [[self.articles objectAtIndex:[indexPath row]] link];
    [self.navigationController pushViewController:articleVC animated:YES];
}



@end
