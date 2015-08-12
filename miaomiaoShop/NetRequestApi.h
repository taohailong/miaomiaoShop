//
//  NetRequestApi.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef enum _NetApiErrType{
    NetApiErrMess,
    NetApiTokenInvalid=300
}NetApiErrType;

typedef void (^NetApiReturnBlock)(id returnValue);
typedef void(^NetApiErrorBlock)(NetApiErrType errCode ,id errMes);
typedef void(^NetApiFailureBlock)(NSString* mes);

@interface NetRequestApi : NSObject
-(void)startAsynchronous;
-(void)cancel;
-(void)getMethodRequestStrUrl:(NSString*)url returnBlock:(NetApiReturnBlock)reBlock  errorBlock:(NetApiErrorBlock)errBlock  failureBlock:(NetApiFailureBlock)fBlock;

@end
