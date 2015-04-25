//
//  ShopCategoryData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCategoryData : NSObject
@property(nonatomic,strong)NSString* categoryID;
@property(nonatomic,strong)NSString* categoryName;
@property(nonatomic,strong)NSArray* products;
@end
