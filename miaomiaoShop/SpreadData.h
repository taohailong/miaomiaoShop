//
//  SpreadData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpreadData : NSObject
@property(nonatomic,strong)NSString* month;
@property(nonatomic,strong)NSString* date;
@property(nonatomic,assign)int wxUserNu;
@property(nonatomic,assign)int appUserNu;
@property(nonatomic,assign)int totalUserNu;

@property(nonatomic,strong)NSString* shopID;
@property(nonatomic,strong)NSString* userID;
@property(nonatomic,strong)NSString* platform;
@property(nonatomic,strong)NSString* codeTime;
@property(nonatomic,strong)NSString* confirmTime;
//-(void)setSpreadMonth:(float)months;
@end
