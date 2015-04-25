//
//  UserManager.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "UserManager.h"
#import "NetWorkRequest.h"
#define UTOKEN @"userToken"
@interface UserManager()
{
    NSString* _token;
    BOOL _isLog;
}
@end

@implementation UserManager
@synthesize shopName,phoneNumber,token,shopID,shopAddress;


+(UserManager*)shareUserManager
{
    static UserManager* shareUser = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
    
        shareUser = [[self alloc]init];
    });
    return shareUser;
}

-(BOOL)verifyTokenOnNet:(void(^)(BOOL success, NSError *error))completeBlock
{
    NSString* t = [self checkTokenExsit];
    if (t==nil) {
        return NO;
    }
    
    __weak UserManager* bSelf = self;

    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req verifyTokenToServer:t WithCallBack:^(NSDictionary *backDic, NSError *error) {
       
        if ([backDic[@"code"] intValue] ==0&&backDic) {
            bSelf.token = backDic[@"token"];
            bSelf.shopName = backDic[@"data"][@"shop"][0][@"name"];
            bSelf.shopID = backDic[@"data"][@"shop"][0][@"id"];
            bSelf.shopAddress = backDic[@"data"][@"shop"][0][@"shop_address"];
            bSelf.phoneNumber = backDic[@"data"][@"shop"][0][@"tel"];
            
            completeBlock(YES,nil);
        }
        else if(error)
        {
            completeBlock(NO,error);
        }
        else
        {
           completeBlock(NO,nil);//token失效
        }

    }];
    [req startAsynchronous];
    return t !=nil;
}


-(NSString*)checkTokenExsit
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    self.token= [def objectForKey:UTOKEN];
    NSLog(@"self.token %@",self.token);
    return self.token ;
}

-(void)setTokenToDish:(NSString*)t
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:t  forKey:UTOKEN];
     NSLog(@"self.token %@",self.token);
    [def synchronize];

}
-(BOOL)isLogin
{
    return self.token!=nil;
}
-(void)logInWithPhone:(NSString *)phone Pass:(NSString *)ps logBack:(logCallBack) blockBack
{
    __weak UserManager* bSelf = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
     [req shopLoginWithPhone:phone password:ps withCallBack:^(NSDictionary *backDic, NSError *error) {
        
        if (backDic) {
            bSelf.token = backDic[@"data"][@"token"];
            bSelf.shopName = backDic[@"data"][@"shop"][0][@"name"];
            bSelf.shopID = backDic[@"data"][@"shop"][0][@"id"];
            bSelf.shopAddress = backDic[@"data"][@"shop"][0][@"shop_address"];
            bSelf.phoneNumber = backDic[@"data"][@"shop"][0][@"tel"];
            [bSelf setTokenToDish:bSelf.token];
             blockBack(YES,nil);
        }
        else if(error)
        {
            blockBack(NO,error);
        }
        
    }];

    [req startAsynchronous];

}
@end
