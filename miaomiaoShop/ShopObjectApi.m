//
//  ShopObjectApi.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopObjectApi.h"

@implementation ShopObjectApi
-(void)getMainCategroyWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/category/get/shop?shop_id=%@",user.shopID];
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:^(NSDictionary* returnValue) {
        
        NSMutableArray* backArr = [[NSMutableArray alloc]init];
        NSArray* cateArr = returnValue[@"data"][@"categories"];
        for (NSDictionary* dic in cateArr)
        {
            ShopCategoryData* cateData = [[ShopCategoryData alloc]init];
            cateData.categoryID = dic[@"category_id"];
            cateData.categoryName = dic[@"name"];
            cateData.type = CategoryMainClass;
            [backArr addObject:cateData];
        }
        returnBk(backArr);
        
    } errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];
}



-(void)getShopAllCategorysWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/shop/category/get/v2?shop_id=%@",user.shopID];
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:^(id returnValue) {
        
        NSMutableArray* backArr = [[NSMutableArray alloc]init];
        NSArray* cateArr = returnValue[@"data"][@"categoryls"];
        for (NSDictionary* dic in cateArr)
        {
            ShopCategoryData* cateData = [[ShopCategoryData alloc]init];
            cateData.categoryID = dic[@"category_id"];
            cateData.categoryName = dic[@"name"];
            cateData.type = CategoryMainClass;
            
            [backArr addObject:cateData];

            
            NSMutableArray* back_sub = [[NSMutableArray alloc]init];
            NSArray* subCategory = dic[@"child"];
            for (NSDictionary* subDic in subCategory) {
                
                ShopCategoryData* cateSub = [[ShopCategoryData alloc]init];
                cateSub.categoryID = subDic[@"category_id"];
                cateSub.categoryName = subDic[@"name"];
                cateSub.type = CategorySubClass;
                [back_sub addObject:cateSub];
            }
            cateData.subClass = back_sub;
          }
        returnBk(backArr);

    } errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];
}


-(void)getAllMainCategoryCompareToShopWithReturnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/category/all?shop_id=%@",user.shopID];
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:^(id returnValue) {
        
        NSMutableArray* backArr = [[NSMutableArray alloc]init];
        NSArray* cateArr = returnValue[@"data"][@"categories"];
        for (NSDictionary* dic in cateArr)
        {
            ShopCategoryData* cateData = [[ShopCategoryData alloc]init];
            cateData.categoryID = dic[@"category_id"];
            cateData.categoryName = dic[@"name"];
            cateData.select = [dic[@"checked"] boolValue];
            cateData.type = CategoryMainClass;
            
            [backArr addObject:cateData];
        }
        returnBk(backArr);
        
    } errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];

}

-(void)getAllSubCategoryCompareToShopWithFatherID:(NSString*)fatherID  returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/category/all?shop_id=%@&category_id=%@",user.shopID,fatherID];
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:^(id returnValue) {
        
        NSMutableArray* backArr = [[NSMutableArray alloc]init];
        NSArray* cateArr = returnValue[@"data"][@"categories"];
        for (NSDictionary* dic in cateArr)
        {
            ShopCategoryData* cateData = [[ShopCategoryData alloc]init];
            cateData.categoryID = dic[@"category_id"];
            cateData.categoryName = dic[@"name"];
            cateData.select = [dic[@"checked"] boolValue];
            cateData.fatherID = [dic[@"parent_id"] stringValue];
            cateData.type = CategorySubClass;
            [backArr addObject:cateData];
        }
        returnBk(backArr);
        
    } errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];
}


-(void)updateShopAllMainCategory:(NSArray *)categorys returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/category/update?shop_id=%@&category_ids=",user.shopID];
    
    
    for (int i=0;i<categorys.count;i++) {
        ShopCategoryData* data = categorys[i];
        if (data.select == NO) {
            continue;
        }
        
        url = [NSString stringWithFormat:@"%@%@,",url,data.categoryID];
    }
    
    if ([url hasSuffix:@","]) {
        url = [url substringWithRange:NSMakeRange(0, url.length -1)];
    }
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:returnBk errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];
}



-(void)updateShopAllSubCategory:(NSArray *)categorys fatherID:(NSString*)fatherID returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/category/update?parent_id=%@&shop_id=%@&category_ids=",fatherID,user.shopID];
    
    for (int i=0;i<categorys.count;i++) {
        ShopCategoryData* data = categorys[i];
        if (data.select == NO) {
            continue;
        }
        url = [NSString stringWithFormat:@"%@%@,",url,data.categoryID];
    }
    
    if ([url hasSuffix:@","]) {
        url = [url substringWithRange:NSMakeRange(0, url.length -1)];
    }

    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:returnBk errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];
}



#pragma mark-sort

-(void)sortProductIndex:(ShopProductData *)product toIndex:(NSString *)destinationIndex returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/items/mv?shop_id=%@&item_id=%@&to_score=%@",user.shopID,product.pID,destinationIndex];
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:returnBk errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];
}

-(void)sortProductToTop:(ShopProductData *)product returnBk:(NetApiReturnBlock)returnBk errBk:(NetApiErrorBlock)errBk failureBk:(NetApiFailureBlock)failureBk
{
    UserManager* user = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"console/api/shopItem/sticky?shop_id=%@&itemId=%@&category_id=%@",user.shopID,product.pID,product.categoryID];
    url = [self setUrlFormate:url];
    
    NetRequestApi* req = [[NetRequestApi alloc]init];
    [req getMethodRequestStrUrl:url returnBlock:returnBk errorBlock:errBk failureBlock:failureBk];
    [req startAsynchronous];

}
@end
