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
#define USHOPID @"shop_id"
#define UACCOUNT @"user_account"
#define PUSHTOKEN @"push_token"
//#define PUSHOK @"isPush"
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
            
            NSArray* shopArr = backDic[@"data"][@"shop"];
            [self saveAllShopArr:shopArr];

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
    self.shopID = [def objectForKey:USHOPID];
    NSLog(@"self.token %@",self.token);
    return self.token ;
}

-(void)setTokenToDish:(NSString*)t WithShopID:(NSString*)shopId WithAccount:(NSString*)account
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:t  forKey:UTOKEN];
    [def setObject:shopId forKey:USHOPID];
    [def setObject:account forKey:UACCOUNT];
     NSLog(@"self.token %@",self.token);
    [def synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOPIDCHANGED object:nil];
}

-(void)removeUserAccountWithBk:(logCallBack)complete
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* account = [def objectForKey:UACCOUNT];
    NSString* pushKey = [def objectForKey:PUSHTOKEN];
    __weak UserManager* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request requestRemoveUserAccount:account WithPushKey:pushKey WithToken:self.token Bk:^(id backDic, NSError *error) {
        if (backDic) {
            complete(YES,nil);
            [wSelf removeUserData];
        }
        else
        {
            complete(NO,nil);
        }
        
    }];
    [request startAsynchronous];
}


-(void)savePushToken:(NSString*)push
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def  setObject:push forKey:PUSHTOKEN];
    [def synchronize];
    [self registePushKey];
}


-(void)removeUserData
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey: UTOKEN];
    [def removeObjectForKey:USHOPID];
//    [def removeObjectForKey:PUSHOK];
    [def removeObjectForKey:UACCOUNT];
    [def synchronize];
    self.token = nil;
    self.shopID = nil;
}

-(void)registePushKey
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
//    if ([def objectForKey:PUSHOK]) {
//        return;
//    }
    
    NSString* account = [def objectForKey:UACCOUNT];
    NSString * pushKey = [def objectForKey:PUSHTOKEN];

    if (account==nil||pushKey==nil) {
        return;
    }

    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request registePushToken:pushKey WithAccount:account WithBk:^(id backDic, NSError *error) {
        
        if (backDic) {
            
//            [def setObject:@"YES" forKey:PUSHOK];
        }
        else
        {
          
        }
    }];
    [request startAsynchronous];
}



-(BOOL)isLogin
{
    return self.shopName!=nil;
}
-(void)logInWithPhone:(NSString *)phone Pass:(NSString *)ps logBack:(logCallBack) blockBack
{
    __weak UserManager* bSelf = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
     [req shopLoginWithPhone:phone password:ps withCallBack:^(NSDictionary *backDic, NSError *error) {
        
         
         if (backDic==nil||[backDic[@"code"] intValue]!=0) {
            blockBack(NO,error);
             return ;
         }
         
         
        if (backDic) {
            
            NSArray* shopArr = backDic[@"data"][@"shop"];
            [self saveAllShopArr:shopArr];
            
            bSelf.token = backDic[@"data"][@"token"];
            bSelf.shopName = backDic[@"data"][@"shop"][0][@"name"];
            bSelf.shopID = backDic[@"data"][@"shop"][0][@"id"];
            bSelf.shopAddress = backDic[@"data"][@"shop"][0][@"shop_address"];
            bSelf.phoneNumber = backDic[@"data"][@"shop"][0][@"tel"];
            [bSelf setTokenToDish:bSelf.token WithShopID:bSelf.shopID WithAccount:phone];
             blockBack(YES,nil);
            [bSelf registePushKey];
        }
        else if(error)
        {
            blockBack(NO,error);
        }
        
    }];

    [req startAsynchronous];

}


-(void)saveAllShopArr:(NSArray*)arr
{
    NSString* shopDirectory = [NSHomeDirectory()
                               stringByAppendingFormat:@"/Documents/%@",@"shopArr"];
    
    [arr writeToFile:shopDirectory atomically:YES];
}

@end
