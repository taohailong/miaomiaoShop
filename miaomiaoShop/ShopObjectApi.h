//
//  ShopObjectApi.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ViewModel.h"
#import "ShopCategoryData.h"
#import "ShopProductData.h"

@interface ShopObjectApi : ViewModel
{
    NetRequestApi* _api;
}
-(void)getMainCategroyWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;

//-(void)getSubCategoryWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;


-(void)getShopAllCategorysWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;





-(void)getAllMainCategoryCompareToShopWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;


-(void)getAllSubCategoryCompareToShopWithFatherID:(NSString*)fatherID  returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;



-(void)updateShopAllMainCategory:(NSArray*)categorys returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;

-(void)updateShopAllSubCategory:(NSArray *)categorys fatherID:(NSString*)fatherID returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;




@end
