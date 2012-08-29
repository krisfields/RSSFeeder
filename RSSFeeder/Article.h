//
//  Article.h
//  RSSFeeder
//
//  Created by Kris Fields on 8/28/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSViewController.h"

@interface Article : NSObject

typedef void(^Callback)(void);

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *imageLink;
@property (strong, nonatomic) RSSViewController *rssVC;

-(NSString *)getFirstImageLinkFromXML:(NSString *)description;
-(void)getThumbnailImageFromArticle:(void(^)(void))block;
@end
