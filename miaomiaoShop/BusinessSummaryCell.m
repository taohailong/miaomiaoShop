//
//  BusinessSummaryCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "BusinessSummaryCell.h"
@interface BusinessSummaryCell()
{
    UILabel* _countOrder;
    UILabel* _totalMoney;
    
    UILabel* orderTitleL;
    UILabel* moneyTitleL;
}
@end
@implementation BusinessSummaryCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
     self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView* orderNuImage = [[UIImageView alloc]init];
    orderNuImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:orderNuImage];
    orderNuImage.image = [UIImage imageNamed:@"order_statue"];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[orderNuImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(orderNuImage)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[orderNuImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(orderNuImage)]];
    
    orderTitleL = [[UILabel alloc]init];
    orderTitleL.translatesAutoresizingMaskIntoConstraints = NO;
    orderTitleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:orderTitleL];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:orderTitleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:orderNuImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[orderNuImage]-5-[orderTitleL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(orderNuImage,orderTitleL)]];
    
    
    
//    _countOrder = [[UILabel alloc]init];
//    _countOrder.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_countOrder];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_countOrder attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:orderNuImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_countOrder]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_countOrder)]];
    

    UIImageView* moneyImage = [[UIImageView alloc]init];
    moneyImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:moneyImage];
    moneyImage.image = [UIImage imageNamed:@"dollar"];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[orderNuImage]-10-[moneyImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(orderNuImage,moneyImage)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moneyImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:orderNuImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    moneyTitleL = [[UILabel alloc]init];
    moneyTitleL.translatesAutoresizingMaskIntoConstraints = NO;

    moneyTitleL.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:moneyTitleL];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:moneyImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitleL attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:orderTitleL attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    
//    _totalMoney = [[UILabel alloc]init];
//    _totalMoney.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_totalMoney];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_totalMoney attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:moneyImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_totalMoney]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_totalMoney)]];
    
    return self;
}

-(void)setCountOrderStr:(NSString*)str
{
    orderTitleL.text = [NSString stringWithFormat:@"在线支付订单数：%@",str];
//    _countOrder.text = str;
}


-(void)setTotalMoney:(NSString*)str
{
    moneyTitleL.text = [NSString stringWithFormat:@"在线支付总金额：%@",str];
//    _totalMoney.text = str;
}

@end
