//
//  ProductCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ProductCell.h"
#import "UIImageView+WebCache.h"
@interface ProductCell()
{
    UIImageView* _productImageView;
    UILabel* _titleL;
    UILabel* _priceL;
}

@end
@implementation ProductCell
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self creatSubViews];
    return self;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self creatSubViews];
    return self;
}

-(void)creatSubViews
{
    _productImageView = [[UIImageView alloc]init];
//    _productImageView.backgroundColor = [UIColor redColor];
    _productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_productImageView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[_productImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_productImageView]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_productImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_productImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    _titleL = [[UILabel alloc]init];
    _titleL.font = [UIFont systemFontOfSize:15];
    _titleL.translatesAutoresizingMaskIntoConstraints = NO;

    _titleL.numberOfLines = 0;
    _titleL.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_titleL];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_productImageView]-5-[_titleL]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView,_titleL)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_titleL(<=50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleL)]];
    _priceL = [[UILabel alloc]init];
    _priceL.font = [UIFont systemFontOfSize:14];
    _priceL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_priceL];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_productImageView]-5-[_priceL]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView,_priceL)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_priceL]-3-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceL)]];
}



-(void)setPicUrl:(NSString *)url
{
    [_productImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFAULTIMAGE];
}

-(void)setTitleStr:(NSString *)title
{
    _titleL.text = title;
}

-(void)setPriceStr:(NSString *)price
{
    _priceL.text = [NSString stringWithFormat:@"¥%@",price];
}


@end
