//
//  OrderListCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderListCell.h"
@interface OrderListCell()
{
    IBOutlet UILabel* _titleLabel;
   IBOutlet UILabel* _statueLabel;
   IBOutlet UILabel* _addressLabel;
   IBOutlet UILabel* _timeLabel;
   IBOutlet UILabel* _telLabel;
   IBOutlet UILabel* _payWayLabel;
   IBOutlet UILabel*_payNuLabel;
   IBOutlet UILabel* _messageLabel;

}

@end
@implementation OrderListCell

-(void)setTitleText:(NSString*)text
{
    _timeLabel.text = text;
}

-(void)setAddress:(NSString*)address
{
    _addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",address];
}

-(void)setTephone:(NSString*)tel
{
    _telLabel.text = [NSString stringWithFormat:@"联系电话:%@",tel];
;
}

-(void)setPayWay:(NSString*)payWay
{
    _payWayLabel.text = [NSString stringWithFormat:@"支付方式:%@",payWay];
}

-(void)setPayNu:(NSString*)nu
{
    _payNuLabel.text = [NSString stringWithFormat:@"订单编号:%@",nu];
}
-(void)setOrderStatue:(NSString*)statue
{
    _statueLabel.text = [NSString stringWithFormat:@"订单状态:%@",statue];

}

-(void)setOrderMessage:(NSString*)message
{

    _messageLabel.text = [NSString stringWithFormat:@"卖家留言:%@",message];
}

//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    UIImageView* _timeImageV = [[UIImageView alloc]init];
//    _timeImageV.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_timeImageV];
//    
//    [self.contentView addConstraints :[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_timeImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeImageV)]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_timeImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeImageV)]];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timeImageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1/7 constant:0]];
//    _timeImageV.image = [UIImage imageNamed:@"order_RedTime"];
//    
//    
//    UIImageView* _telImageV = [[UIImageView alloc]init];
//    _telImageV.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_telImageV];
//    _telImageV.image = [UIImage imageNamed:@"order_tel"];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_telImageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timeImageV]-10-[_telImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeImageV,_telImageV)]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_telImageV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_timeImageV attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0 ]];
//    
//    
//    UIImageView* _payWayImageV=[[UIImageView alloc]init];
//    _payWayImageV.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_payWayImageV];
//    _payWayImageV.image = [UIImage imageNamed:@"order_pawWay"];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_payWayImageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_telImageV]-10-[_payWayImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_telImageV,_payWayImageV)]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_payWayImageV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_timeImageV attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0 ]];
//    
//    UIImageView*_payNuImageV=[[UIImageView alloc]init];
//    _payNuImageV.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_payNuImageV];
//    _payNuImageV.image = [UIImage imageNamed:@"order_Nu"];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_payNuImageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_payWayImageV]-10-[_payNuImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_payNuImageV,_payWayImageV)]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_payNuImageV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_timeImageV attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0 ]];
//    
//    
//    UIImageView* _messageImageV=[[UIImageView alloc]init];
//    _messageImageV.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:_messageImageV];
//    _messageImageV.image = [UIImage imageNamed:@"order_message"];
//    
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_messageImageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_payNuImageV]-10-[_messageImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_payNuImageV,_messageImageV)]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_messageImageV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_timeImageV attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0 ]];
//    return self;
//
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
