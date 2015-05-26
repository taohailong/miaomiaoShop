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
@property(nonatomic,assign)float price;
@property(nonatomic,assign)int count;
@property(nonatomic,assign)int status;
@property(nonatomic,strong)NSString* pID;
@property(nonatomic,strong)NSString* categoryName;
@property(nonatomic,strong)NSString* categoryID;
@property(nonatomic,strong)NSString* scanNu;
@property(nonatomic,strong)NSString* score;
@end
