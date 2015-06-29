//
//  BusinessCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "BusinessCell.h"
@interface BusinessCell()
{
    UILabel* _titleLabel;
    UILabel* _countOrder;
    UILabel* _totalMoney;
    
//    IBOutlet UIImageView* _payStatueImageV;
//    IBOutlet UILabel* _payStatueLabel;
}

@end
@implementation BusinessCell
//@synthesize payStatueLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIImageView* timeImage = [[UIImageView alloc]init];
    timeImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:timeImage];
    timeImage.image = [UIImage imageNamed:@"order_time"];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[timeImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(timeImage)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[timeImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(timeImage)]];
  
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:timeImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[timeImage]-15-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(timeImage,_titleLabel)]];
    
    
    
    
    UIImageView* orderNuImage = [[UIImageView alloc]init];
    orderNuImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:orderNuImage];
    orderNuImage.image = [UIImage imageNamed:@"order_statue"];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[timeImage]-10-[orderNuImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(timeImage,orderNuImage)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:orderNuImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:timeImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    UILabel* orderTitleL = [[UILabel alloc]init];
    orderTitleL.translatesAutoresizingMaskIntoConstraints = NO;
    orderTitleL.text = @"在线支付订单数：";
    orderTitleL.font = _titleLabel.font;
    [self.contentView addSubview:orderTitleL];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:orderTitleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:orderNuImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:orderTitleL attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];

    
    _countOrder = [[UILabel alloc]init];
    _countOrder.font = _titleLabel.font;
    _countOrder.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_countOrder];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_countOrder attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:orderNuImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_countOrder]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_countOrder)]];
    
    
    
    
    UIImageView* moneyImage = [[UIImageView alloc]init];
    moneyImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:moneyImage];
    moneyImage.image = [UIImage imageNamed:@"dollar"];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[orderNuImage]-10-[moneyImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(orderNuImage,moneyImage)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moneyImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:timeImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    
    
    UILabel* moneyTitleL = [[UILabel alloc]init];
    moneyTitleL.translatesAutoresizingMaskIntoConstraints = NO;
    moneyTitleL.text = @"在线支付总金额：";
    moneyTitleL.font = _titleLabel.font;
    [self.contentView addSubview:moneyTitleL];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:moneyImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitleL attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    
    _totalMoney = [[UILabel alloc]init];
    _totalMoney.font = _titleLabel.font;
    _totalMoney.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_totalMoney];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_totalMoney attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:moneyImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_totalMoney]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_totalMoney)]];

    return self;

}

-(void)setTitleLabelText:(NSString*)str
{
    _titleLabel.text = str;
}


-(void)setCountOrderStr:(NSString*)str
{
    _countOrder.text = str;
}


-(void)setTotalMoney:(NSString*)str
{
    _totalMoney.text = str;
}

//-(void)setPayStatueStr:(NSString*)str
//{
//    _payStatueLabel.text = str;
//}

//-(void)setPayStatueImage:(UIImage*)image
//{
//    _payStatueImageV.image = image;
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
