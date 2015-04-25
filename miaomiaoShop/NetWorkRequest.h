//
//  NetWorkRequest.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NetCallback)(id backDic,NSError* error);
@interface NetWorkRequest : NSObject
-(void)shopGetCategoryWith:(NSString*)shopID WithCallBack:(NetCallback)back
;
-(void)shopGetProductWithShopID:(NSString*)shopID withCategory:(NSString*)category fromIndex:(int)nu WithCallBack:(NetCallback)back;

-(void)shopLoginWithPhone:(NSString*)phone password:(NSString*)pw withCallBack:(NetCallback)back;

-(void)verifyTokenToServer:(NSString*)token WithCallBack:(NetCallback)back;



-(void)startAsynchronous;
-(void)cancel;
@end
