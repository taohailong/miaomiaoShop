//
//  DatePickerView.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-3.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSwitch.h"
typedef void (^DatePickerComplete)(NSString*startT,NSString*endT);
@interface DatePickerView : UIView
{
    DatePickerComplete _completeBk;
    UIView* headView;
    TSwitch* _sw;
}
-(id)initWithDateSelectComplete:(DatePickerComplete)bk ;
-(void)setSwithStatus:(BOOL)status;
//-(void)setSwithStatus:(BOOL)status Block:(void (^)(BOOL))swBlock;
//(void(^)( id sourceDic,NetWorkStatus status))block
-(void)setStartTime:(NSString*)startTime;
-(void)setEndTime:(NSString*)endTime;
@end
