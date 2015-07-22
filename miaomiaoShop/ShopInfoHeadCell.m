//
//  ShopInfoHeadCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoHeadCell.h"
@interface ShopInfoHeadCell()
{
    UILabel* _headLabel;
    UIImageView* _cellImage;
}
@end

@implementation ShopInfoHeadCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }

    _headLabel = [[UILabel alloc]init];
    _headLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _headLabel.font = DEFAULTFONT(15);
    _headLabel.textColor = FUNCTCOLOR(102, 102, 102);
    [self.contentView addSubview:_headLabel];
    
    
    _cellImage = [[UIImageView alloc]init];
    _cellImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_cellImage];
    
    
    [self setLayout];
    return self;
}

-(void)setLayout
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_headLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_headLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_headLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_cellImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headLabel]-3-[_cellImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headLabel,_cellImage)]];
}


-(void)setHeadLabelStr:(NSString*)str
{
    _headLabel.text = str;
}

-(void)setCellImage:(NSString*)imageName
{
    _cellImage.image = [UIImage imageNamed:imageName];
}

@end
