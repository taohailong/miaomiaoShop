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
    UILabel* _firstLabel;
    UILabel* _secondLabel;
    UILabel* _thirdLabel;
//    UIButton* _telBt;
}
@end
@implementation OrderInfoFirstCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _firstLabel = [[UILabel alloc]init];
//    _firstLabel.numberOfLines = 0;
    _firstLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _firstLabel.font = DEFAULTFONT(14);
    _firstLabel.textColor = FUNCTCOLOR(102, 102, 102);
    [self.contentView addSubview:_firstLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_firstLabel]-1-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
    
    

    _secondLabel = [[UILabel alloc]init];
    _secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _secondLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_secondLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_firstLabel]-10-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel,_firstLabel)]];

    

    
//    UILabel* textBtL = [[UILabel alloc]init];
//    textBtL.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:textBtL];
//    textBtL.text = @"送货电话:";
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[textBtL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textBtL)]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_payWayLabel]-8-[textBtL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_payWayLabel,textBtL)]];
//    textBtL.font = [UIFont systemFontOfSize:15];
    
    
//    _telBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _telBt.translatesAutoresizingMaskIntoConstraints = NO;
////    _telBt.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:_telBt];
//    [_telBt addTarget:self action:@selector(makeTelphone) forControlEvents:UIControlEventTouchUpInside];
//    _telBt.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[textBtL]-5-[_telBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textBtL,_telBt)]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_telBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:textBtL attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    _thirdLabel = [[UILabel alloc]init];
    _thirdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _thirdLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_thirdLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_thirdLabel]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_secondLabel]-10-[_thirdLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel,_thirdLabel)]];

    
    
    return self;
}


-(void)setTelPhoneText:(NSString*)text
{
    NSAttributedString* att = [self setFormateStrHead:@"联系电话：" withEndStr:text withColor:FUNCTCOLOR(153, 153, 153)];
    _firstLabel.attributedText = att;
}


-(void)setAddressText:(NSString*)str
{
    NSAttributedString* att = [self setFormateStrHead:@"收货地址：" withEndStr:str withColor:FUNCTCOLOR(153, 153, 153)];
    _secondLabel.attributedText = att;
}


-(void)setOrderMessage:(NSString*)str
{
    NSAttributedString* att = [self setFormateStrHead:@"买家留言：" withEndStr:str withColor:FUNCTCOLOR(153, 153, 153)];
    _thirdLabel.attributedText = att;
}

-(void)setFirstLabelAtt:(NSAttributedString*)att
{
    _firstLabel.attributedText = att;
}


-(void)setSecondLabelAtt:(NSAttributedString*)att
{
    _secondLabel.attributedText = att;
}


-(void)setThirdLabelAtt:(NSAttributedString*)att
{
    _thirdLabel.attributedText = att;
}


-(NSAttributedString*)setFormateStrHead:(NSString*)head withEndStr:(NSString*)endStr withColor:(UIColor*)color
{
    NSMutableAttributedString* status = [[NSMutableAttributedString alloc]initWithString:head attributes:@{NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102),NSFontAttributeName:DEFAULTFONT(14)}];
    NSAttributedString* statusStr = [[NSAttributedString alloc]initWithString:endStr attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:DEFAULTFONT(14)}];
    [status appendAttributedString:statusStr];
    
    return status;
}




//-(void)makeTelphone
//{
//    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要拨打电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
//    
//}
//
//
//
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.cancelButtonIndex==buttonIndex) {
//        return;
//    }
//    NSString* url = [NSString stringWithFormat:@"tel://%@",_telBt.titleLabel.text];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//
//}
//

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
