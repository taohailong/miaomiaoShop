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
    UILabel* _indicateLabel;
    UIPickerView* _picker;
}
@end
@implementation DatePickerView


-(id)initWithDateSelectComplete:(DatePickerComplete)bk
{
    self= [super init] ;
    self.backgroundColor =[UIColor whiteColor];
    _completeBk = bk;
    
    
    headView = [[UIView alloc]init];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headView(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView)]];

    UILabel* titleL = [[UILabel alloc]init];
    titleL.text = @"选择营业时间";
    titleL.textColor = FUNCTCOLOR(102, 102, 102);
    titleL.font = DEFAULTFONT(15);
    titleL.translatesAutoresizingMaskIntoConstraints = NO;
    [headView addSubview:titleL];
    [headView addConstraint:[NSLayoutConstraint constraintWithItem:titleL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [headView addConstraint:[NSLayoutConstraint constraintWithItem:titleL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:headView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    
    
    
    
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
//    [endL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
//    [endL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    
//    UIPickerView
    
     _picker = [[UIPickerView alloc]init];
//    _picker.backgroundColor = [UIColor redColor];
    _picker.delegate = self;
    _picker.dataSource = self;

    _picker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_picker];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picker)]];
//     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[endL]-[_picker]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(endL,_picker)]];
//    [_picker setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [_picker setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-25-[_picker]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView,_picker)]];

    
    _indicateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH -93, 10, 45, 25)];
    _indicateLabel.font = DEFAULTFONT(13);
    _indicateLabel.textColor = FUNCTCOLOR(102, 102, 102);
    _indicateLabel.text = @"24小时";
    [headView addSubview:_indicateLabel];
    
    __weak UIPickerView*  wpicker  = _picker;
    __weak DatePickerView* wself = self;
    _sw = [[TSwitch alloc]initWithFrame:CGRectMake( SCREENWIDTH -50, 8, 45  , 25) didChangeHandler:^(BOOL isOn) {
        if (isOn) {
            
            [wself setStartTime:@"00:00"];
            [wself setEndTime:@"23:59"];
            wpicker.userInteractionEnabled = NO;
        }
        else
        {
            wpicker.userInteractionEnabled = YES;
        }
    }];
    _sw.onTintColor = DEFAULTNAVCOLOR;
    [headView addSubview:_sw];
    
    
    
    UIButton* selectBt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBt.layer.cornerRadius = 4;
    selectBt.layer.masksToBounds = YES;
    selectBt.backgroundColor = DEFAULTNAVCOLOR;
    selectBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:selectBt];
    [selectBt addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[selectBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectBt)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectBt(35)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picker,selectBt)]];
    
    [selectBt setTitle:@"确定" forState:UIControlStateNormal];
    
    [selectBt addTarget:self action:@selector(dateSelectComplete) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}


-(void)setSwithStatus:(BOOL)status
{
   [_sw setOn:status];
    if (status)
    {
        [self setStartTime:@"00:00"];
        [self setEndTime:@"23:59"];
    }
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

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",(int)row];
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



#pragma mark-DataParse

-(void)setStartTime:(NSString *)startTime
{
    NSArray* arr = [startTime componentsSeparatedByString:@":"];
    [self setPickerTimeInComponent:0 SelectRow:[arr[0] integerValue]];
    [self setPickerTimeInComponent:1 SelectRow:[arr[1] integerValue]];
}

-(void)setEndTime:(NSString *)endTime
{
    NSArray* arr = [endTime componentsSeparatedByString:@":"];
    [self setPickerTimeInComponent:2 SelectRow:[arr[0] integerValue]];
    [self setPickerTimeInComponent:3 SelectRow:[arr[1] integerValue]];

}


-(void)setPickerTimeInComponent:(NSInteger)component SelectRow:(NSInteger)row
{
    [_picker selectRow:row inComponent:component animated:NO];
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
