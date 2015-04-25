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

#define HTTPHOST @"www.mbianli.com"
@interface NetWorkRequest()
{
    ASIHTTPRequest* _asi;
}
@end;
@implementation NetWorkRequest
//-(id)initWithAsi:(ASIHTTPRequest*)req
//{
//    self = [super init];
//    _asi = req;
//    return self;
//}


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
                product.price = [dic[@"price"] stringValue];
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
//    ASIHTTPRequest* asi = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:logUrl]];
//    __weak ASIHTTPRequest* bAsi = asi;
//    [asi setCompletionBlock:^{
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: bAsi.responseData options:NSJSONReadingAllowFragments error:nil];
//        back(dict,nil);
//       
//    }];
//    [asi setFailedBlock:^{
//        back(nil,bAsi.error);
//    }];
//    
//    return  [[self  alloc]initWithAsi:asi];
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
