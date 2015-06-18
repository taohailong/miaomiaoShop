//
//  ShopInfoData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _ShopStatus
{
   ShopStatusOpen,
   ShopStatusClose
}ShopStatus;

@interface ShopInfoData : NSObject
@property(nonatomic,strong)NSString* shopName;
@property(nonatomic,strong)NSString* shopAddress;
@property(nonatomic,strong)NSString* countProducts;
@property(nonatomic,strong)NSString* countCategory;
@property(nonatomic,strong)NSString* countOrder;
@property(nonatomic,strong)NSString* totalMoney;
@property(nonatomic,strong)NSString* serveArea;
@property(nonatomic,strong)NSString* telPhoneNu;
@property(nonatomic,strong)NSString* mobilePhoneNu;
@property(nonatomic,assign)ShopStatus shopStatue;
@property(nonatomic,strong)NSString* openTime;
@property(nonatomic,strong)NSString* closeTime;
@property(nonatomic,assign)float minPrice;
@property(nonatomic,strong)NSString* shopSpread;
-(NSString*)getShopStatusStr;
@end
