//
//  NSString+ZhengZe.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "NSString+ZhengZe.h"

@implementation NSString (ZhengZe)


+(BOOL)verifyNumber:(NSString*)str
{
    NSString * MOBILE =  @"[0-9]+.?[0-9]*";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return  [regextestmobile evaluateWithObject:str];
}




+(BOOL)verifyIsMobilePhoneNu:(NSString*)phone
{
    NSString * MOBILE =  @"^1[0-9]{10}";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return  [regextestmobile evaluateWithObject:phone];
}

+(BOOL)verifyisTelPhone:(NSString*)phone
{
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:phone];
}
@end
