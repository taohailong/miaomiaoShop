//
//  ShopInfoSubCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoSubCell.h"

@implementation ShopInfoSubCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _separateView = [[UIView alloc]init];
    _separateView.translatesAutoresizingMaskIntoConstraints = NO;
    _separateView.backgroundColor = FUNCTCOLOR(210, 210, 210);
    [self.contentView addSubview:_separateView];
    
    
    _leftLabel = [[UILabel alloc]init];
    _leftLabel.textColor = FUNCTCOLOR(102, 102, 102);
    _leftLabel.font = DEFAULTFONT(15);
    _leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_leftLabel];

    _rightLabel = [[UILabel alloc]init];
    _rightLabel.textColor = _leftLabel.textColor;
    _rightLabel.font = DEFAULTFONT(15);
    _rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_rightLabel];
    
    
    
    _leftTitle = [[UILabel alloc]init];
    _leftTitle.font = DEFAULTFONT(15);
    _leftTitle.textColor = _leftLabel.textColor;
    _leftTitle.text = @"起送价";
    _leftTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_leftTitle];
    
    _rightTitle = [[UILabel alloc]init];
    _rightTitle.font = DEFAULTFONT(15);
    _rightTitle.textColor = _leftLabel.textColor;
    _rightTitle.text = @"推荐码";
    _rightTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_rightTitle];

    [self setLayout];
    return self;
}


-(void)setLayout
{
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_separateView]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_separateView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_separateView(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_separateView)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separateView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    

    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.5 constant:-3]];
    
    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_leftLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_leftLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.5 constant:-3]];
    
    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_leftTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_leftTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:3]];

    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:3]];
}

-(void)setLeftLabelStr:(NSString*)str
{
    _leftLabel.text = str;
}


-(void)setRightLabelStr:(NSString*)str
{
    _rightLabel.text = str;
}

@end
