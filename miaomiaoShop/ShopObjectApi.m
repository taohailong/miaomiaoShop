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





@end
