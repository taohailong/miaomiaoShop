//
//  NSString+ZhengZe.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZhengZe)
+(BOOL)verifyNumber:(NSString*)str;
+(BOOL)verifyIsMobilePhoneNu:(NSString*)phone;
+(BOOL)verifyisTelPhone:(NSString*)phone;
@end
