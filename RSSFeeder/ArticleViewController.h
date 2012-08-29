//
//  ArticleViewController.h
//  RSSFeeder
//
//  Created by Kris Fields on 8/28/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong) NSURL *someLink;

@end
