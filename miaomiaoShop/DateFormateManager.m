//
//  DateFormateManager.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "DateFormateManager.h"
@interface DateFormateManager()
{
    NSDateFormatter* _formate;
}
@end
@implementation DateFormateManager
+(id)shareDateFormateManager
{
    static DateFormateManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        
        manager = [[self alloc]init];
    });
    return manager;
}

-(id)init
{
    self = [super init];
    _formate = [[NSDateFormatter alloc] init];
    
    return self;
}

-(NSString*)formateDateToString:(NSDate*)date
{
   return  [_formate stringFromDate:date];
}

-(void)setDateStyleString:(NSString*)style
{
    [_formate setDateFormat:style];
}

-(NSString*)formateFloatTimeValueToString:(double)time
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return  [_formate stringFromDate:date];
}

-(NSDate*)getDateFromString:(NSString *)string
{
    NSDate* inputDate = [_formate dateFromString:string];
    return inputDate;
}


//-(NSString*)formateTimeToDate:(NSString*)timeString
//{
//    double time = [timeString doubleValue];
//    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
//    return  [_formate stringFromDate:date];
//}


-(BOOL)isTodayWithTimeFloatValue:(double)time
{
//    double time = [timeStr doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    return  [self isToday:date];
    
}


-(BOOL)isToday:(NSDate*)date
{
    NSCalendar
    *calendar = [NSCalendar currentCalendar];//日历
    NSDateComponents
    *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date toDate:[NSDate date] options:0];
    int year = (int)[components year];
    int month = (int)[components month];
    int day = (int)[components day];
    //三天以内更改显示格式
    if (year == 0 && month == 0 && day == 0)
    {
        return YES;
//        if (day == 0) {
//            return YES;
////             (@"今天",nil);
//        }
//        else if (day == 1) {
//            return NO;
////             NSLocalizedString(@"昨天",nil);
//        }
//        else if (day
//                 == 2) {
//            title
////            = NSLocalizedString(@"前天",nil);
//        }
    }
    return NO;
}

- (TodayType)weekDay
{
    TodayType weekDayStr ;
    
    [self setDateStyleString:@"yyyy-MM-dd"];
    NSString* str =  [self formateDateToString:[NSDate date]];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];

    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            int year = [[array objectAtIndex:0] integerValue];
            int month = [[array objectAtIndex:1] integerValue];
            int day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int week = [weekdayComponents weekday];

    switch (week) {
        case 1:
            weekDayStr = Sunday;
            break;
        case 2:
            weekDayStr = Monday;
            break;
        case 3:
            weekDayStr = Tuesday;
            break;
        case 4:
            weekDayStr = Wednesday;
            break;
        case 5:
            weekDayStr = Thursday;
            break;
        case 6:
            weekDayStr = Friday;
            break;
        case 7:
            weekDayStr = Saturday;
            break;
        default:
            weekDayStr = Monday;
            break;  
    }  
    return weekDayStr;  
}
@end
