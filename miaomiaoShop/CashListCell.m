//
//  CashListCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/7.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CashListCell.h"

@implementation CashListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setLayout];
    return self;
}

-(void)setLayout
{
    if (_thirdLabel == nil) {
        return;
    }
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];

    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_firstLabel]-5-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel,_secondLabel)]];
    
    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_firstLabel]-5-[_thirdLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel,_thirdLabel)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_secondLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_thirdLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdLabel)]];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
