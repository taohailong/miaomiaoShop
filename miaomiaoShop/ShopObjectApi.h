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

//获取本店的一二级分类
-(void)getMainCategroyWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;

//-(void)getSubCategoryWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;


-(void)getShopAllCategorysWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;



//获取有所 一 二级 分类（包含跟本地的对比）

-(void)getAllMainCategoryCompareToShopWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;


-(void)getAllSubCategoryCompareToShopWithFatherID:(NSString*)fatherID  returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;


//添加删除 一 二级 分类
-(void)updateShopAllMainCategory:(NSArray*)categorys returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;

-(void)updateShopAllSubCategory:(NSArray *)categorys fatherID:(NSString*)fatherID returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;


//排序
-(void)sortProductIndex:(ShopProductData*)product toIndex:(NSString*)destinationIndex returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;

-(void)sortProductToTop:(ShopProductData*)product returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk;;

@end
