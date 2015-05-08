//
//  DatePickerView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-3.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "DatePickerView.h"
#import "DateFormateManager.h"
@interface DatePickerView()
{
    UIDatePicker* _picker;
}
@end
@implementation DatePickerView


-(id)initWithDateSelectComplete:(DatePickerComplete)bk
{
    self= [super init] ;
    self.backgroundColor =[UIColor whiteColor];
    _completeBk = bk;
    UIView* headView = [[UIView alloc]init];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headView(35)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView)]];

    UIButton* selectBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectBt.translatesAutoresizingMaskIntoConstraints = NO;
    [headView addSubview:selectBt];
    [selectBt addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[selectBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectBt)]];
    
     [headView addConstraint:[NSLayoutConstraint constraintWithItem:selectBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [selectBt setTitle:@"完成" forState:UIControlStateNormal];
    
    [selectBt addTarget:self action:@selector(dateSelectComplete) forControlEvents:UIControlEventTouchUpInside];
    
    
    
     _picker = [[UIDatePicker alloc]init];
    _picker.datePickerMode =  UIDatePickerModeTime;
    _picker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_picker];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picker)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectBt]-[_picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectBt,_picker)]];

    
    return self;
}

-(void)dateSelectComplete
{
    DateFormateManager* formate = [DateFormateManager shareDateFormateManager];
    [formate setDateStyleString:@"HH:mm"];
    NSString* formateStr = [formate formateDateToString:_picker.date];
    
    if (_completeBk) {
        
        _completeBk(formateStr);
    }

}

-(void)removeView
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
