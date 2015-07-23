//
//  ShopInfoThreeLCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoThreeLCell.h"

@implementation ShopInfoThreeLCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _firstLabel  = [[UILabel alloc]init];
    _firstLabel.textColor = FUNCTCOLOR(153, 153, 153);
    _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _firstLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_firstLabel];
    
    
    _secondLabel  = [[UILabel alloc]init];
    _secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _secondLabel.textColor = _firstLabel.textColor ;
    _secondLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_secondLabel];
    
    
    _thirdLabel  = [[UILabel alloc]init];
    _thirdLabel.textColor = _firstLabel.textColor ;
    _thirdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _thirdLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_thirdLabel];

    [self setLayout];
    
    return self;
}
-(void)setLayout
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:-3]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];

    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_firstLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];

    
    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.5 constant:3]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_firstLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
}

-(void)setFirstLabelStr:(NSString*)str
{
    _firstLabel.text = str;
}


-(void)setSecondLabelStr:(NSString*)str
{
    _secondLabel.text = str;
}


-(void)setThirdLabelStr:(NSString*)str
{
    _thirdLabel.text = str;
}

@end
