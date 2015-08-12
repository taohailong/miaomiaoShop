//
//  OrderConfirmSummerHeadView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/6.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderConfirmSummerHeadView.h"

@interface OrderConfirmSummerHeadView()
{
    UILabel* _firstL;
    UILabel* _secondL;
    UILabel* _thirdL;
}

@end
@implementation OrderConfirmSummerHeadView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = FUNCTCOLOR(237, 237, 237);
    _firstL = [[UILabel alloc]init];
    _firstL.font = DEFAULTFONT(14);
    _firstL.textColor = FUNCTCOLOR(180, 180, 180);
    _firstL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_firstL];
    
    _secondL = [[UILabel alloc]init];
    _secondL.font = _firstL.font;
    _secondL.textColor = _firstL.textColor;
    _secondL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_secondL];
    
    _thirdL = [[UILabel alloc]init];
    _thirdL.font = _firstL.font;
    _thirdL.textColor = _firstL.textColor;
    _thirdL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_thirdL];
    
    [self setLayout];
    return self;
}


-(void)setLayout
{
    UIView* backView = self.contentView;
    
    [backView addConstraint:[NSLayoutConstraint constraintWithItem:_firstL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstL)]];

    
    
    [backView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_thirdL]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdL)]];

    
    
    [backView addConstraint:[NSLayoutConstraint constraintWithItem:_secondL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_secondL]-15-[_thirdL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL,_thirdL)]];
}


-(void)setFirstLabelText:(NSString*)text
{
    _firstL.text = text;
}

-(void)setSecondLabelText:(NSString*)text
{
    _secondL.text = text;
}


-(void)setThirdLabelText:(NSString*)text
{
    _thirdL.text = text;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
