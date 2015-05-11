//
//  ProductEditViewController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductController.h"
#import "ShopProductData.h"
@interface ProductEditController : AddProductController
-(id)initWithProductData:(ShopProductData*)data;
@end
