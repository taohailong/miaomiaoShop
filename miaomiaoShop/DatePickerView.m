//
//  DatePickerView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-3.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "DatePickerView.h"
//#import "DateFormateManager.h"
@interface DatePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView* _picker;
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

    UILabel* startL = [[UILabel alloc]init];
    startL.text =@"开始时间";
    startL.font = DEFAULTFONT(15);
    startL.textColor = FUNCTCOLOR(102, 102, 102);
    startL.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:startL];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-5-[startL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView,startL)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:startL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0]];
    
    
    
    
    
    UILabel* endL = [[UILabel alloc]init];
    endL.text =@"结束时间";
    endL.font = DEFAULTFONT(15);
    endL.textColor = FUNCTCOLOR(102, 102, 102);
    endL.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:endL];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-5-[endL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView,endL)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:endL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    
//    UIPickerView
    
     _picker = [[UIPickerView alloc]init];
    _picker.delegate = self;
    _picker.dataSource = self;

    _picker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_picker];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picker)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-25-[_picker]-45-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView,_picker)]];

    
    
    UIButton* selectBt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBt.layer.cornerRadius = 4;
    selectBt.layer.masksToBounds = YES;
    selectBt.backgroundColor = DEFAULTNAVCOLOR;
    selectBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:selectBt];
    [selectBt addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[selectBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectBt)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectBt(35)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectBt)]];
    
    [selectBt setTitle:@"确定" forState:UIControlStateNormal];
    
    [selectBt addTarget:self action:@selector(dateSelectComplete) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)dateSelectComplete
{
//    DateFormateManager* formate = [DateFormateManager shareDateFormateManager];
//    [formate setDateStyleString:@"HH:mm"];
//    NSString* formateStr = [formate formateDateToString:_picker.date];
    
    NSInteger sH = [_picker selectedRowInComponent:0];
    NSInteger sM = [_picker selectedRowInComponent:1];
    
    NSString* startT = [NSString stringWithFormat:@"%@:%@",[self formatStr:sH],[self formatStr:sM]];
    
   
    NSInteger eH = [_picker selectedRowInComponent:2];
    NSInteger eM = [_picker selectedRowInComponent:3];
    NSString* endT = [NSString stringWithFormat:@"%@:%@",[self formatStr:eH],[self formatStr:eM]];;
    if (_completeBk) {
        
        _completeBk(startT,endT);
    }

}

-(void)removeView
{
    [self removeFromSuperview];
}


#pragma mark-PickerView

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 1||component ==2) {
        return 100;
    }
    return 35;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0||component==2) {
        return 24;
    }
    return 60;
}



-(NSString*)formatStr:(NSInteger)it
{
    if (it>9) {
        return [NSString stringWithFormat:@"%d",it];
    }
    else
    {
        return [NSString stringWithFormat:@"0%d",it];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
