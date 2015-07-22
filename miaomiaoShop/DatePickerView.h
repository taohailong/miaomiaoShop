//
//  DatePickerView.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-3.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DatePickerComplete)(NSString*startT,NSString*endT);
@interface DatePickerView : UIView
{
    DatePickerComplete _completeBk;
}
-(id)initWithDateSelectComplete:(DatePickerComplete)bk;
@end
