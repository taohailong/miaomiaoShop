//
//  ShopInfoViewController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopInfoData.h"
@interface ShopInfoViewController : UIViewController
{
    ShopInfoData* _shopData;
}
-(id)initWithShopInfoData:(ShopInfoData*)data;
@end
