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
    UILabel* _firstL;
    UILabel* _secondL;
    
    UILabel* _thirdL;
    UILabel* _fourthL;
}
@end
@implementation BusinessSummaryCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel* leftTitle = [[UILabel alloc]init];
    leftTitle.text = @"未确认收货";
    leftTitle.textColor = FUNCTCOLOR(153, 153, 153);
    leftTitle.font = DEFAULTFONT(14);
    leftTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:leftTitle];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[leftTitle]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftTitle)]];

    
    
    
    _firstL = [[UILabel alloc]init];
    _firstL.translatesAutoresizingMaskIntoConstraints = NO;
    _firstL.font = DEFAULTFONT(16);
    _firstL.textColor = FUNCTCOLOR(102, 102, 102);
    [self.contentView addSubview:_firstL];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.25 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftTitle]-8-[_firstL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstL,leftTitle)]];
    
    
    UIView* leftSeparate = [[UIView alloc]init];
    leftSeparate.backgroundColor = FUNCTCOLOR(221, 221, 221);
    leftSeparate.translatesAutoresizingMaskIntoConstraints= NO;
    [self.contentView addSubview:leftSeparate];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftTitle]-5-[leftSeparate]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftSeparate,leftTitle)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftSeparate(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftSeparate)]];
    

    
    _secondL = [[UILabel alloc]init];
    _secondL.translatesAutoresizingMaskIntoConstraints = NO;
    _secondL.font = DEFAULTFONT(16);
    _secondL.textColor = FUNCTCOLOR(102, 102, 102);
    [self.contentView addSubview:_secondL];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.75 constant:0]];
    
   [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_firstL attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    
    UIView* middleSeparate = [[UIView alloc]init];
    middleSeparate.backgroundColor = FUNCTCOLOR(221, 221, 221);
    middleSeparate.translatesAutoresizingMaskIntoConstraints= NO;
    [self.contentView addSubview:middleSeparate];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:middleSeparate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[middleSeparate(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(middleSeparate)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[middleSeparate]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(middleSeparate)]];

    
    
    
    

    UILabel* rightTitle = [[UILabel alloc]init];
    rightTitle.text = @"已确认收货";
    rightTitle.textColor = FUNCTCOLOR(153, 153, 153);
    rightTitle.font = DEFAULTFONT(14);
    rightTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:rightTitle];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:leftTitle attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    

    
    _thirdL = [[UILabel alloc]init];
    _thirdL.translatesAutoresizingMaskIntoConstraints = NO;
    _thirdL.font = DEFAULTFONT(16);
    _thirdL.textColor = FUNCTCOLOR(102, 102, 102);
    [self.contentView addSubview:_thirdL];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.25 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_thirdL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_firstL attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    

    
    
    UIView* rightSeparate = [[UIView alloc]init];
    rightSeparate.backgroundColor = FUNCTCOLOR(221, 221, 221);
    rightSeparate.translatesAutoresizingMaskIntoConstraints= NO;
    [self.contentView addSubview:rightSeparate];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightTitle]-5-[rightSeparate]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightTitle,rightSeparate)]];
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightSeparate(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightSeparate)]];

    
    _fourthL = [[UILabel alloc]init];
    _fourthL.translatesAutoresizingMaskIntoConstraints = NO;
    _fourthL.font = DEFAULTFONT(16);
    _fourthL.textColor = FUNCTCOLOR(102, 102, 102);
    [self.contentView addSubview:_fourthL];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_fourthL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.75 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_fourthL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_firstL attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];


    UIView* tapLeftView = [[UIView alloc]init];
    tapLeftView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:tapLeftView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tapLeftView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tapLeftView)]];
    UITapGestureRecognizer* leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [tapLeftView addGestureRecognizer:leftTap];
    
    
    
    UIView* tapRightView = [[UIView alloc]init];
    tapRightView.translatesAutoresizingMaskIntoConstraints = NO;
    tapRightView.tag = 1;
    [self.contentView addSubview:tapRightView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tapRightView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tapRightView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tapLeftView]-0-[tapRightView(tapLeftView)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tapLeftView,tapRightView)]];
    UITapGestureRecognizer* rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [tapRightView addGestureRecognizer:rightTap];

    
    
    return self;
}

-(void)setBk:(BusinessSummaryBk)bk
{
    _bk = bk;
}

-(void)tapView:(UIGestureRecognizer*)gesture
{
    if (_bk) {
        if (gesture.view.tag == 1) {
            _bk(NO);
        }
        else
        {
            _bk(YES);
        }
    }
  
}






-(void)setFirstLStr:(NSString*)str
{
    _firstL.text = str;
}


-(void)setSecondLText:(NSString*)str
{
    _secondL.text = str;
}


-(void)setThirdLText:(NSString*)text
{
    _thirdL.text = text;
}


-(void)setFourthText:(NSString*)text
{
    _fourthL.text = text;
}



@end
