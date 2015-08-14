//
//  CategorySelectViewController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageCategoryController.h"
#import "ShopCategoryData.h"
typedef void (^CategorySelectBk)(ShopProductData* product);
@interface CategorySelectController : ManageCategoryController
{
    ShopProductData* _product;
    CategorySelectBk _completeBk;
}
-(id)initWithCompleteBk:(CategorySelectBk)bk
;
@end
