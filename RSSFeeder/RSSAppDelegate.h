//
//  RSSAppDelegate.h
//  RSSFeeder
//
//  Created by Kris Fields on 8/28/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSViewController;

@interface RSSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RSSViewController *viewController;

@end
