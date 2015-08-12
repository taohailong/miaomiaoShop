//
//  SpreadListCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//
//@implementation SpreadTableHeadView
//
//-(id)ini
//
//@end


#import "SpreadListCell.h"
@implementation SpreadListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _bottomSeparate = [[UIView alloc]init];
    _bottomSeparate.backgroundColor = FUNCTCOLOR(221, 221, 221);
    _bottomSeparate.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_bottomSeparate];
    
    [self setLayout];
    return self;
}


-(void)setLayout
{
    if (_bottomSeparate == nil) {
        return;
    }
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_headSeparateV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headSeparateV)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_headSeparateV(10)]"  options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headSeparateV)]];
    
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_imageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageV)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_headSeparateV]-10-[_imageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headSeparateV,_imageV)]];
    
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageV]-5-[_firstL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageV,_firstL)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageV attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_separateV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_separateV)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageV]-7-[_separateV(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageV,_separateV)]];
    
    
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_secondL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_separateV]-10-[_secondL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL,_separateV)]];
    

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_thirdL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdL)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_secondL]-10-[_thirdL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL,_thirdL)]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bottomSeparate]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bottomSeparate)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_thirdL]-10-[_bottomSeparate(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdL,_bottomSeparate)]];

    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_fourthL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fourthL)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomSeparate]-9-[_fourthL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fourthL,_bottomSeparate)]];
}

-(UILabel*)getFourthLabel
{
    return _fourthL;
}

-(UILabel*)getSecondLabel
{
    return _secondL;
}

-(UILabel*)getThirdLabel
{
    return _thirdL;
}


@end
