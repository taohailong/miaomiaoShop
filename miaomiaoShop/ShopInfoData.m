//
//  ShopInfoData.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoData.h"

@implementation ShopInfoData
@synthesize countCategory,countOrder,closeTime,countProducts,shopAddress,serveArea,shopName,shopStatue,minPrice;
@synthesize openTime,telPhoneNu,mobilePhoneNu,totalMoney;
@synthesize shopSpread;

-(NSString*)getShopStatusStr
{
   return  self.shopStatue == ShopStatusOpen?@"营业中":@"打烊";
}

@end
