//
//  ShopCategoryData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _CategoryType{
     CategoryMainClass,
     CategorySubClass,
}CategoryType;
@interface ShopCategoryData : NSObject

@property(nonatomic,strong)NSString* score;//排序权重
@property(nonatomic,assign)CategoryType type;
@property(nonatomic,strong)NSString* fatherID;
@property(nonatomic,strong)NSMutableArray* subClass;
@property(nonatomic,strong)NSString* categoryID;
@property(nonatomic,strong)NSString* categoryName;
@property(nonatomic,strong)NSArray* products;
@property(nonatomic,assign)BOOL select;
@end
