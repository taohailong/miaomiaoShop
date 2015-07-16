//
//  RootDetailCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/16.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "RootDetailCell.h"

@implementation RootDetailCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = DEFAULTFONT(15);
    [self.contentView addSubview:_titleLabel];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];

    
    
    _conentLabel = [[UILabel alloc]init];
    _conentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _conentLabel.font = DEFAULTFONT(15);
    [self.contentView addSubview:_conentLabel];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_conentLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_conentLabel]-6-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_conentLabel)]];

    return self;
}

-(void)setTitleLabelStr:(NSString*)str
{
    if (str==nil) {
        return;
    }
    _titleLabel.text = str;
}

-(void)setContentLabelStr:(NSString*)str
{
    if (str==nil) {
        return;
    }

    _conentLabel.text = str;
}

@end
