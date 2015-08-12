//
//  ShopBusinHeadCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/6.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopBusinHeadCell.h"

@implementation ShopBusinHeadCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _firstLabel.textColor = [UIColor whiteColor];
    _firstLabel.font = DEFAULTFONT(13);
    _firstLabel.text = @"可提现金额";
    _secondLabel.textColor = [UIColor whiteColor];
    _secondLabel.font = DEFAULTFONT(28);
    
    self.contentView.backgroundColor = DEFAULTNAVCOLOR;
    return self;
}

-(void)setLayout
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-19-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
    
    
    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_firstLabel]-6-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel,_secondLabel)]];


}

-(void)setFirstLabelText:(NSString*)str
{
    _firstLabel.text =str;
}

-(void)setSecondLabelText:(NSString*)text
{
    _secondLabel.text = text;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
