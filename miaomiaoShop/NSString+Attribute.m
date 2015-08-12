//
//  NSString+Attribute.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)
-(NSMutableAttributedString*)attributeColor:(UIColor*)color font:(UIFont*)font
{
    NSMutableAttributedString* stringAttri = [[NSMutableAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    return stringAttri;
}
@end
