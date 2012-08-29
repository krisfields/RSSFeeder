//
//  Article.m
//  RSSFeeder
//
//  Created by Kris Fields on 8/28/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "Article.h"

@implementation Article



-(NSString *)getFirstImageLinkFromXML:(NSString *)description {
    
    if([description rangeOfString:@"<img src="].location != NSNotFound){
        NSUInteger startingRangeLocation = [description rangeOfString:@"<img src="].location + [description rangeOfString:@"<img src="].length + 1;
        NSUInteger endingRangeLocation = [description rangeOfString:@".jpg"].location + [description rangeOfString:@".jpg"].length ;
        NSRange range;
        range.location = startingRangeLocation;
        range.length = endingRangeLocation - startingRangeLocation;
        
        
        return [description substringWithRange:range];
        
    } else {
        return @"";
    }
}

-(void)getThumbnailImageFromArticle:(void(^)(void))block
{
    if ([self.imageLink isEqualToString:@""]) {
        return;
    }
    if (self.image) {
        //perform block
        block();
        NSLog(@"image already exists.  Returning it");

    }else{
        //perform block asynchonously.  NO MORE DEADLOCK
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSLog(@"image link = %@", self.imageLink);
            NSLog(@"image doesn't exist yet.  Getting it");
            NSURL *urlOfImage = [NSURL URLWithString:self.imageLink];
            self.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:urlOfImage]];
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
//                [self.rssVC.articlesTable setNeedsLayout];
                [self.rssVC.articlesTable reloadData];
            });
        });
        
    }
}

@end
