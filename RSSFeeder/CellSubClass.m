//
//  CellSubClass.m
//  RSSFeeder
//
//  Created by Kris Fields on 8/29/12.
//  Copyright (c) 2012 Kris Fields. All rights reserved.
//

#import "CellSubClass.h"

@implementation CellSubClass

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
