//
//  DateFormateManager.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormateManager : NSObject
+(id)shareDateFormateManager;
-(void)setDateStyleString:(NSString*)style;
//-(BOOL)isTodayWithTimeString:(NSString*)time;
//-(NSString*)formateTimeToDate:(NSString*)timeString;
-(NSString*)formateFloatTimeValueToString:(double)time;
-(BOOL)isTodayWithTimeFloatValue:(double)time;
-(NSString*)formateDateToString:(NSDate*)date;
@end
