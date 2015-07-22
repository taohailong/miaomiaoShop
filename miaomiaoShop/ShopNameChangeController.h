//
//  ShopNameChangeController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopNameChangeController;
@protocol ShopNameChangeProtocol <NSObject>

-(void)shopNameChanged:(NSString*)shopName;

@end
@interface ShopNameChangeController : UIViewController
{
    UITextField* _contentField;
    
}
@property(nonatomic,weak)id<ShopNameChangeProtocol>delegate;
@end
