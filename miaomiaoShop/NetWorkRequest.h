//
//  NetWorkRequest.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopProductData,ShopCategoryData,ShopInfoData;
typedef void (^NetCallback)(id backDic,NSError* error);
@interface NetWorkRequest : NSObject



-(void)getShopInfoWitbBk:(NetCallback)completeBk;

-(void)shopGetOrderWithStatue:(NSString *)statue WithIndex:(int)index WithBk:(NetCallback)completeBk;
-(void)shopInfoUpdateWithShopInfoData:(ShopInfoData*)data WithBk:(NetCallback)completeBk;



-(void)shopProductDeleteProductWithProductID:(NSString*)pID WithBk:(NetCallback)completeBk;
-(void)shopCategoryAddWithName:(NSString*)name WithBk:(NetCallback)completeBk;
-(void)shopCateDeleteWithCategoryID:(NSString*)cateID WithBk:(NetCallback)completeBk;

-(void)shopProductUpdateWithProduct:(ShopProductData*)data WithBk:(NetCallback)completeBk;
-(void)shopScanProductWithSerial:(NSString*)serialNu WithBk:(NetCallback)completeBk;
-(void)shopProductImagePostWithImage:(NSData*)data WithScanNu:(NSString*)nu WithBk:(NetCallback)completeBk;
-(void)shopAddProductInfoToServeWith:(ShopProductData*)data WithBk:(NetCallback)completeBk;



-(void)shopGetCategoryWithCallBack:(NetCallback)back
;
-(void)shopGetProductWithShopID:(NSString*)shopID withCategory:(NSString*)category fromIndex:(int)nu WithCallBack:(NetCallback)back;

-(void)shopLoginWithPhone:(NSString*)phone password:(NSString*)pw withCallBack:(NetCallback)back;

-(void)verifyTokenToServer:(NSString*)token WithCallBack:(NetCallback)back;



-(void)startAsynchronous;
-(void)cancel;
@end
