//
//  OrderFootCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-18.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderListBtCell.h"
@interface OrderListBtCell()
{
 }
@end
@implementation OrderListBtCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIView* separate2V = [[UIView alloc]init];
    separate2V.backgroundColor = FUNCTCOLOR(243, 243, 243);
    separate2V.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:separate2V];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separate2V]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separate2V)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nuLabel]-8-[separate2V(1)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nuLabel,separate2V)]];

    
    
    
    _firstBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstBt.tag = 0;
    [_firstBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
//    [_firstBt setBackgroundImage:[UIImage imageNamed:@"ButtonWhite"] forState:UIControlStateHighlighted];
    _firstBt.layer.masksToBounds = YES;
    _firstBt.layer.borderColor = DEFAULTNAVCOLOR.CGColor;
    _firstBt.layer.borderWidth = 1;
    _firstBt.layer.cornerRadius = 4;
    _firstBt.titleLabel.font = DEFAULTFONT(14);
    [_firstBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_firstBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_firstBt setTitle:@"确认配送" forState:UIControlStateNormal];
    _firstBt.translatesAutoresizingMaskIntoConstraints = NO;
    [_firstBt addTarget:self action:@selector(allBtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_firstBt];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_firstBt(70)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstBt)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separate2V]-8-[_firstBt(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separate2V,_firstBt)]];
    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    

    
    
    _secondBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondBt.tag = 1;
    _secondBt.layer.masksToBounds = YES;
    _secondBt.layer.borderColor = DEFAULTNAVCOLOR.CGColor;
    _secondBt.layer.borderWidth = 1;
    _secondBt.layer.cornerRadius = 4;

     _secondBt.titleLabel.font = DEFAULTFONT(14);
    [_secondBt setTitleColor:DEFAULTNAVCOLOR forState:UIControlStateNormal];
    [_secondBt setTitle:@"无法配送" forState:UIControlStateNormal];
    [_secondBt setBackgroundImage:[UIImage imageNamed:@"ButtonWhite"] forState:UIControlStateNormal];
//    [_secondBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateHighlighted];
    _secondBt.translatesAutoresizingMaskIntoConstraints = NO;
    [_secondBt addTarget:self action:@selector(allBtAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_secondBt];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_secondBt(_firstBt)]-18-[_firstBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstBt,_secondBt)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_secondBt(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondBt)]];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_firstBt attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    

    
    
//    _thirdBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    _thirdBt.tag = 2;
//    _thirdBt.layer.masksToBounds = YES;
//    _thirdBt.layer.borderColor = DEFAULTNAVCOLOR.CGColor;
//    _thirdBt.layer.borderWidth = 1;
//    _thirdBt.layer.cornerRadius = 4;
//
//     _thirdBt.titleLabel.font = DEFAULTFONT(15);
//    [_thirdBt setTitleColor:DEFAULTNAVCOLOR forState:UIControlStateNormal];
//    [_thirdBt setTitle:@" 催单 " forState:UIControlStateNormal];
//    _thirdBt.translatesAutoresizingMaskIntoConstraints = NO;
//    [_thirdBt addTarget:self action:@selector(allBtAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_thirdBt];
//    
//
//    
//    _fourthBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    _fourthBt.tag = 3;
//    _fourthBt.layer.masksToBounds = YES;
//    _fourthBt.layer.borderColor = DEFAULTNAVCOLOR.CGColor;
//    _fourthBt.layer.borderWidth = 1;
//    _fourthBt.layer.cornerRadius = 4;
//
//    _fourthBt.titleLabel.font = DEFAULTFONT(15);
//    
//    [_fourthBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_fourthBt setBackgroundImage:[UIImage imageNamed:@"button_back_red"] forState:UIControlStateNormal];
//    [_fourthBt setTitle:@"确认收货" forState:UIControlStateNormal];
//    _fourthBt.translatesAutoresizingMaskIntoConstraints = NO;
//    [_fourthBt addTarget:self action:@selector(allBtAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:_fourthBt];
    
    
//    [self setSubLayout];
    return self;
}


-(void)setSubLayout
{

    
   
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_secondBt]-8-[_thirdBt(_secondBt)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdBt,_secondBt)]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_thirdBt]-8-[_fourthBt(_thirdBt)]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdBt,_fourthBt)]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_fourthBt(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fourthBt)]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_fourthBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

}


-(void)allBtAction:(UIButton*)bt
{
    if (!_completeBk) {
        return;
    }
    if (bt.tag==0) {
        _completeBk(OrderBtFirst);
    }
    else if (bt.tag==1)
    {
        _completeBk(OrderBtSecond);
    }
    else if (bt.tag==2)
    {
        _completeBk(OrderBtThird);
    }
    else
    {
        _completeBk(OrderBtFourth);
    }
    
}


-(void)setOrderBk:(BtTargetAction)bk
{
    _completeBk = bk;
}


-(void)setHiddenBtWithType:(OrderBtSelect)type
{
    switch (type)
    {
        case OrderBtFirst:
            _firstBt.hidden = YES;
            break;
            
        case OrderBtSecond:
            _secondBt.hidden = YES;
            break;
            
        case OrderBtThird:
            _thirdBt.hidden = YES;
            break;
            
        case OrderBtFourth:
            _fourthBt.hidden = YES;
            break;
        default:
            break;
    }
}



-(UIButton*)getBtWithType:(OrderBtSelect)type
{
    switch (type)
    {
        case OrderBtFirst:
            return _firstBt;
            break;
            
         case OrderBtSecond:
            return  _secondBt;
            break;
           
         case OrderBtThird:
           return  _thirdBt;
            break;
            
         case OrderBtFourth:
            return  _fourthBt;
            break;
        default:
            break;
    }
}

@end
