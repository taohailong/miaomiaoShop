//
//  AddProductTwoLabelCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductTwoLabelCell.h"

@implementation AddProductTwoLabelCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _firstLabel.textColor = FUNCTCOLOR(102, 102, 102);
    _firstLabel.font = DEFAULTFONT(16);
    
    _secondLabel.textColor = FUNCTCOLOR(180, 180, 180);
    _secondLabel.font = DEFAULTFONT(15);
    
    return self;
}

-(void)setLayout
{
   [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
   [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_secondLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

}
@end
