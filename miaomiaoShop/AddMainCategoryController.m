//
//  AddMainCategoryController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddMainCategoryController.h"

@implementation AddMainCategoryController
-(void)getNetData
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak AddMainCategoryController* wself = self;
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req getAllMainCategoryCompareToShopWithReturnBk:^(NSArray* returnValue) {
        [loadView removeFromSuperview];
        [wself receiveData:returnValue];
        
    } errBk:^(NetApiErrType errCode, NSString* errMes) {
        [loadView removeFromSuperview];
        THActivityView* showStr = [[THActivityView alloc]initWithString:errMes];
        [showStr show];
    } failureBk:^(NSString *mes) {
        [loadView removeFromSuperview];
        THActivityView* showStr = [[THActivityView alloc]initWithString:mes];
        [showStr show];
    }];
}

-(void)saveAction
{

    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak AddMainCategoryController* wself = self;
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req updateShopAllMainCategory:_dataArr returnBk:^(id returnValue) {
        [loadView removeFromSuperview];
        THActivityView* showStr = [[THActivityView alloc]initWithString:@"修改完成"];
        [showStr show];
        [wself modifyComplete];
        
    } errBk:^(NetApiErrType errCode, NSString* errMes) {
        [loadView removeFromSuperview];
        THActivityView* showStr = [[THActivityView alloc]initWithString:errMes];
        [showStr show];
    } failureBk:^(NSString *mes) {
        [loadView removeFromSuperview];
        THActivityView* showStr = [[THActivityView alloc]initWithString:mes];
        [showStr show];
    }];
}

-(void)modifyComplete
{
    if ([self.delegate respondsToSelector:@selector(modifyCategoryComplete:)]) {
        [self.delegate modifyCategoryComplete:CategoryMainClass];
    }
 
}


@end
