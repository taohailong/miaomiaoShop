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
 //   UILabel* _payWayLabel;
//   UILabel*_payNuLabel;
//   UILabel* _messageLabel;

}

@end
@implementation OrderListCell


-(void)setOrderStatus:(NSString *)status
{
    _statusLabel.text = status;
}

-(void)setOrderTime:(NSString *)time
{
    _titleLabel.text = time;
}

-(void)setAddress:(NSString*)address
{
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc]initWithString:@"收货地址:" attributes:@{NSFontAttributeName:DEFAULTFONT(14),NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102)}];
    
    
    NSMutableAttributedString* addAtt = [[NSMutableAttributedString alloc]initWithString:address attributes:@{NSFontAttributeName:DEFAULTFONT(14),NSForegroundColorAttributeName:FUNCTCOLOR(153  , 153, 153)}];
    [att appendAttributedString:addAtt];
    
    _addressLabel.attributedText = att;
//    _addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",address];
}

-(void)setTephone:(NSString*)tel
{
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc]initWithString:@"联系电话:" attributes:@{NSFontAttributeName:DEFAULTFONT(14),NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102)}];
    
    NSMutableAttributedString* addAtt = [[NSMutableAttributedString alloc]initWithString:tel attributes:@{NSFontAttributeName:DEFAULTFONT(14),NSForegroundColorAttributeName:FUNCTCOLOR(153  , 153, 153)}];
    [att appendAttributedString:addAtt];
    
    _telLabel.attributedText = att;
}

-(void)setTotalNu:(NSString*)nu
{
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc]initWithString:@"总   计:" attributes:@{NSFontAttributeName:DEFAULTFONT(14),NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102)}];
    
    NSMutableAttributedString* addAtt = [[NSMutableAttributedString alloc]initWithString:nu attributes:@{NSFontAttributeName:DEFAULTFONT(14),NSForegroundColorAttributeName:FUNCTCOLOR(153  , 153, 153)}];
    [att appendAttributedString:addAtt];

    _nuLabel.attributedText = att;
}

-(void)setTotalMoney:(NSString*)money
{
    _moneyLabel.text = [NSString stringWithFormat:@"总价:¥%@",money];
}

//-(void)setTitleText:(NSString*)text
//{
//    _timeLabel.text = text;
//}

//-(void)setPayWay:(NSString*)payWay
//{
//    _payWayLabel.text = [NSString stringWithFormat:@"支付方式:%@",payWay];
//}
//
//-(void)setPayNu:(NSString*)nu
//{
//    _payNuLabel.text = [NSString stringWithFormat:@"订单编号:%@",nu];
//}
//-(void)setOrderStatue:(NSString*)statue
//{
//    _statueLabel.text = [NSString stringWithFormat:@"订单状态:%@",statue];
//
//}
//
//-(void)setOrderMessage:(NSString*)message
//{
//
//    _messageLabel.text = [NSString stringWithFormat:@"卖家留言:%@",message];
//}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIView* back = [[UIView alloc]init];
    back.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:back];
    back.backgroundColor = FUNCTCOLOR(243, 243, 243);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[back]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(back)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[back(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(back)]];
    
    
    _titleImage = [[UIImageView alloc]init];
    _titleImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleImage];
    _titleImage.image = [UIImage imageNamed:@"order_time"];
    
//    [_titleImage setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleImage)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-10-[_titleImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(back,_titleImage)]];
    
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = DEFAULTFONT(16);
    _titleLabel.textColor = FUNCTCOLOR(153, 153, 153);
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_titleImage]-6-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleImage,_titleLabel)]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_titleImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    _statusLabel = [[UILabel alloc]init];
    _statusLabel.font = DEFAULTFONT(16);
    _statusLabel.textColor = DEFAULTNAVCOLOR;
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_statusLabel];
    
    
//    [_statusLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_statusLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    UIView* separate1V = [[UIView alloc]init];
    separate1V.backgroundColor = FUNCTCOLOR(243, 243, 243);
    separate1V.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:separate1V];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separate1V]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separate1V)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-7-[separate1V(1)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,separate1V)]];
    
    
    
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.numberOfLines = 0;
    _addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_addressLabel];
    
    [_addressLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_addressLabel]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_addressLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separate1V]-10-[_addressLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separate1V,_addressLabel)]];

    
    
    
    _telLabel = [[UILabel alloc]init];
    _telLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_telLabel];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_telLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_addressLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_addressLabel]-10-[_telLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_addressLabel,_telLabel)]];
    
    
    
    
    
    _nuLabel = [[UILabel alloc]init];
    _nuLabel.font = DEFAULTFONT(14);
//    _nuLabel.backgroundColor = [UIColor redColor];
    _nuLabel.translatesAutoresizingMaskIntoConstraints= NO;
    [self.contentView addSubview:_nuLabel];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_nuLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_addressLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_telLabel]-10-[_nuLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_telLabel,_nuLabel)]];

    
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.textColor = DEFAULTNAVCOLOR;
    _moneyLabel.font = DEFAULTFONT(14);
    _moneyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_moneyLabel];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moneyLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_nuLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_moneyLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_moneyLabel)]];

//    [self setLayout];
    
    return self;
}


-(void)setLayout
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
