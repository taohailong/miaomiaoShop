//
//  OrderInfoSecondCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderInfoFirstCell.h"
@interface OrderInfoFirstCell()<UIAlertViewDelegate>
{
    UILabel* _addressLabel;
    UILabel* _payWayLabel;
    UILabel* _messageLabel;
    UIButton* _telBt;
}
@end
@implementation OrderInfoFirstCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.numberOfLines = 0;
    _addressLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _addressLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_addressLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_addressLabel]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_addressLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_addressLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_addressLabel)]];

    _payWayLabel = [[UILabel alloc]init];
    _payWayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _payWayLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_payWayLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_payWayLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_payWayLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_addressLabel]-8-[_payWayLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_payWayLabel,_addressLabel)]];

    

    
    UILabel* textBtL = [[UILabel alloc]init];
    textBtL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:textBtL];
    textBtL.text = @"送货电话:";
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[textBtL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textBtL)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_payWayLabel]-8-[textBtL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_payWayLabel,textBtL)]];
    textBtL.font = [UIFont systemFontOfSize:15];
    
    
    _telBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _telBt.translatesAutoresizingMaskIntoConstraints = NO;
//    _telBt.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_telBt];
    [_telBt addTarget:self action:@selector(makeTelphone) forControlEvents:UIControlEventTouchUpInside];
    _telBt.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[textBtL]-5-[_telBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textBtL,_telBt)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_telBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:textBtL attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    _messageLabel = [[UILabel alloc]init];
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _messageLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_messageLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_messageLabel]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_messageLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textBtL]-8-[_messageLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textBtL,_messageLabel)]];

    
    
    return self;
}


-(void)setTelPhoneText:(NSString*)text
{
    [_telBt setTitle:text forState:UIControlStateNormal];
}


-(void)setAddressText:(NSString*)str
{
    _addressLabel.text = [NSString stringWithFormat:@"送货地址: %@",str];
}


-(void)setPayWayText:(NSString*)str
{
    _payWayLabel.text = [NSString stringWithFormat:@"支付方式: %@",str] ;
}


-(void)setOrderMessage:(NSString*)str
{
    _messageLabel.text = [NSString stringWithFormat:@"买家留言: %@",str] ;
}


-(void)makeTelphone
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要拨打电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex==buttonIndex) {
        return;
    }
    NSString* url = [NSString stringWithFormat:@"tel://%@",_telBt.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
