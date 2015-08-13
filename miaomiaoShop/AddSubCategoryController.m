//
//  AddSubCategoryController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddSubCategoryController.h"

@implementation AddSubCategoryController
-(void)getNetData
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak AddSubCategoryController* wself = self;
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req getAllSubCategoryCompareToShopWithFatherID:_currentCate returnBk:^(NSArray* returnValue) {
        [loadView removeFromSuperview];
        [wself receiveData:returnValue];
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

-(void)saveAction
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];

    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req updateShopAllSubCategory:_dataArr fatherID:_currentCate returnBk:^(id returnValue) {
        [loadView removeFromSuperview];
        THActivityView* showStr = [[THActivityView alloc]initWithString:@"修改完成"];
        [showStr show];
        
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
