//
//  NetWorkRequest.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "NetWorkRequest.h"
#import "ASIHTTPRequest.h"
#import "ShopCategoryData.h"
#import "ShopProductData.h"
#import "UserManager.h"
#import "ASIFormDataRequest.h"

#define HTTPHOST @"www.mbianli.com"
@interface NetWorkRequest()
{
    ASIHTTPRequest* _asi;
    ASIFormDataRequest* _postAsi;
}
@end;
@implementation NetWorkRequest
//-(id)initWithAsi:(ASIHTTPRequest*)req
//{
//    self = [super init];
//    _asi = req;
//    return self;
//}

-(void)shopCateDeleteWithCategoryID:(NSString *)cateID WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/cate/del?category_id=%@&shop_id=%@&ver=%@",HTTPHOST,cateID,manager.shopID,VERSION];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            completeBk(sourceDic,nil);
            
        }
        else
        {
            completeBk(nil,err);
        }
        
    }];
}

-(void)shopCategoryAddWithName:(NSString *)name WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/cate/add?categoryId=0&shopId=%@&scorce=0&categoryName=%@&ver=%@",HTTPHOST,name,manager.shopID,VERSION];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            completeBk(sourceDic,nil);
            
        }
        else
        {
            completeBk(nil,err);
        }
        
    }];
}






-(void)shopProductDeleteProductWithProductID:(NSString *)pID WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/del?itemId=%@&shop_id=%@&ver=%@",HTTPHOST,pID,manager.shopID,VERSION];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            completeBk(sourceDic,nil);
            
        }
        else
        {
            completeBk(nil,err);
        }
        
    }];
}



-(void)shopProductUpdateWithProduct:(ShopProductData *)data WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/update?itemId=%@&itemName=%@&serialNo=%@&category_id=%@&count=1000&score=0&price=%d&saleStatus=%d&shop_id=%@&ver=%@",HTTPHOST,data.pID,data.pName,data.scanNu,data.categoryID,(int)data.price*100,data.status,manager.shopID,VERSION];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            completeBk(sourceDic,nil);
            
        }
        else
        {
            completeBk(nil,err);
        }
        
    }];


}


-(void)shopProductImagePostWithImage:(NSData *)data WithScanNu:(NSString *)nu WithBk:(NetCallback)completeBk
{
   NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/ul_pic",HTTPHOST];
   UserManager* manager = [UserManager shareUserManager];
    _postAsi = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    _postAsi.delegate = self;
    __weak ASIFormDataRequest* wPost = _postAsi;
    [_postAsi setPostValue:manager.shopID forKey:@"shop_id"];
    [_postAsi setPostValue:nu forKey:@"serialNo"];
    [_postAsi addData:data withFileName:@"text.jpg" andContentType:@"image/jpeg" forKey:@"pic"];
    [_postAsi setFailedBlock:^{
        completeBk(nil,wPost.error);
    }];
    [_postAsi setCompletionBlock:^{
        
           NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:wPost.responseData options:NSJSONReadingMutableContainers error:NULL];
        completeBk(dataDic,nil);
       
    }];
    [_postAsi startAsynchronous];
}

-(void)shopAddProductInfoToServeWith:(ShopProductData*)data WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/addItem?serialNo=%@&name=%@&categoryId=%@&count=100&score=0&price=%f&saleStatus=%d&shop_id=%@&ver=%@",HTTPHOST,data.scanNu,data.pName,data.categoryID,data.price*100,data.status,manager.shopID,VERSION];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            completeBk(sourceDic,nil);
            
        }
        else
        {
            completeBk(nil,err);
        }
        
    }];

}







-(void)shopScanProductWithSerial:(NSString*)serialNu WithBk:(NetCallback)completeBk
{

    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/product/get?serialNo=%@&ver=%@",HTTPHOST,serialNu,VERSION];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            NSDictionary* pDic = sourceDic[@"data"][@"product"];
            ShopProductData* product = [[ShopProductData alloc]init];
            product.pID = pDic[@"id"];
            product.pName = pDic[@"name"];
            product.pUrl = pDic[@"pic_url"];
            product.price = [pDic[@"price"] intValue]/100.0;
            product.scanNu =pDic[@"serialNo"];
            completeBk(product,nil);
            
        }
        else
        {
            completeBk(nil,err);
        }
        
    }];

}


-(void)shopGetCategoryWith:(NSString*)shopID WithCallBack:(NetCallback)back
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/category/get?shop_id=%@&ver=%@",HTTPHOST,shopID,VERSION];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err){
        
        if ([sourceDic[@"code"] intValue] ==0)
        {
            NSMutableArray* arr = [NSMutableArray array];
            NSArray* cateArr = sourceDic[@"data"][@"categoryls"];
            for (NSDictionary* dic in cateArr)
            {
                ShopCategoryData* ca = [[ShopCategoryData alloc]init];
                ca.categoryID = dic[@"category_id"];
                ca.categoryName = dic[@"name"];
                [arr addObject:ca];
            }
             back(arr,err);
        }
        else
        {
           back(nil,err);
        }
        
    }];

}




-(void)shopGetProductWithShopID:(NSString*)shopID withCategory:(NSString*)category fromIndex:(int)nu WithCallBack:(NetCallback)back
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/getitems?shop_id=%@&category_id=%@&from=%d&offset=%d&ver=%@",HTTPHOST,shopID,category,nu,nu+20,VERSION];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err) {
        if ([sourceDic[@"code"] intValue]==0)
        {
            NSMutableArray* arr = [NSMutableArray array];
            NSArray* products = sourceDic[@"data"][@"itemls"];
            for (NSDictionary* dic in products)
            {
                ShopProductData* product = [[ShopProductData alloc]init];
                product.pUrl = dic[@"pic_url"];
                product.categoryID = dic[@"category_id"];
                product.price = [dic[@"price"] floatValue]/100;
                product.pName = dic[@"name"];
                product.status = [dic[@"status"] intValue];
                product.pID = dic[@"id"];
                product.count = [dic[@"count"] intValue];
                [arr addObject:product];
            }
             back(arr,err);
        }
        else
        {
           back(sourceDic,err);
        }
       
    }];

}


-(void)verifyTokenToServer:(NSString *)token WithCallBack:(NetCallback)back
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/login/islogin?token=%@&ver=%@",HTTPHOST,token,VERSION];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NSError *err) {
       
        back(sourceDic,err);
    }];
  
}

-(void)shopLoginWithPhone:(NSString *)phone password:(NSString *)pw withCallBack:(NetCallback)back
{
    NSString* logUrl = [NSString stringWithFormat:@"http://%@/console/api/login/valid?phone=%@&pwd=%@",HTTPHOST,phone,pw];
    
    [self getMethodRequestStrUrl:logUrl complete:^(NSDictionary *sourceDic, NSError *err) {
       
                back(sourceDic,err);
    }];
}


-(void)getMethodRequestStrUrl:(NSString*)url complete:(void(^)( NSDictionary* sourceDic,NSError* err))block
{
    
    _asi = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    __weak ASIHTTPRequest* bkAsi = _asi;
    
    [_asi setCompletionBlock:^{
        
        NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:bkAsi.responseData options:NSJSONReadingMutableContainers error:NULL];
        block(dataDic,nil);
        
    }];
    
    [_asi setFailedBlock:^{
        NSLog(@"error is %@",bkAsi.error);
        block(nil,bkAsi.error);
    }];
    
}


-(void)startAsynchronous
{
    [_asi startAsynchronous];
}

-(void)cancel
{
    [_asi cancel];
    _asi = nil;
}

-(void)dealloc
{
//    [self cancel];
}

@end
