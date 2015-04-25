//
//  ShopProductData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopProductData : NSObject
@property(nonatomic,strong)NSString* pName;
@property(nonatomic,strong)NSString* pUrl;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,assign)int count;
@property(nonatomic,assign)int status;
@property(nonatomic,strong)NSString* pID;

@end
