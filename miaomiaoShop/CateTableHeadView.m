//
//  CateTableHeadView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CateTableHeadView.h"

@implementation CateTableHeadView
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithReuseIdentifier:reuseIdentifier];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnTheView)];
    [self.contentView addGestureRecognizer:tap];
    
    _firstLabel.textAlignment = NSTextAlignmentLeft;
    _headAccessView = [[UIView alloc]init];
    _headAccessView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_headAccessView];
    
    
    _accessoryImage = [[UIImageView alloc]init];
    _accessoryImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_accessoryImage];
    
    _horizeSeparate = [[UIView alloc]init];
    _horizeSeparate.translatesAutoresizingMaskIntoConstraints = NO;
    _horizeSeparate.backgroundColor = FUNCTCOLOR(221, 221, 221);
    [self.contentView addSubview:_horizeSeparate];
    
    
    [self setLayout];
    return self;
}
-(void)setLayout
{
    if (_headAccessView == nil) {
        return;
    }
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
   [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
   
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_accessoryImage]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_accessoryImage)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_accessoryImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_headAccessView(5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headAccessView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_headAccessView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headAccessView)]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_horizeSeparate]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_horizeSeparate)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_horizeSeparate(0.5)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_horizeSeparate)]];
    
}



-(void)tapOnTheView
{
    if (_bk) {
        _bk();
    }
}

-(void)setSelectView
{
    _headAccessView.backgroundColor = DEFAULTNAVCOLOR;
    _firstLabel.highlighted = YES;
    [_accessoryImage setImage:[UIImage imageNamed:_selectImage]];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)disSelectView
{
    self.contentView.backgroundColor = FUNCTCOLOR(251, 251, 251);
    _headAccessView.backgroundColor = self.contentView.backgroundColor;
    _firstLabel.highlighted = NO;
    
    [_accessoryImage setImage:[UIImage imageNamed:_normalImage]];
}
-(void)setAccessImage:(NSString *)image selectImage:(NSString *)selectImage
{
    _normalImage = image;
    _selectImage = selectImage;
}

@end
