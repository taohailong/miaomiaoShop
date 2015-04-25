//
//  ShopInfoController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopProductListView.h"
#import "ShopCategoryListView.h"
@interface ShopInfoController : UIViewController
{
    IBOutlet ShopCategoryListView* _categoryView;
    IBOutlet ShopProductListView* _productView;
    
}
@end
