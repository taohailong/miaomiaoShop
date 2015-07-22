//
//  UserManager.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "UserManager.h"
#import "NetWorkRequest.h"
#import "NSString+Md5.h"
//#define PUSHOK @"isPush"
@interface UserManager()
{
    NSString* _token;
    BOOL _isLog;
}
@end

@implementation UserManager
@synthesize shopName,phoneNumber,token,shopID,shopAddress;
@synthesize shopSpread;

+(UserManager*)shareUserManager
{
    static UserManager* shareUser = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
    
        shareUser = [[self alloc]init];
    });
    return shareUser;
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

-(NSString*)getUserAccount
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:UACCOUNT];
}





-(void)removeUserAccountWithBk:(logCallBack)complete
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* account = [def objectForKey:UACCOUNT];
    NSString* pushKey = [def objectForKey:PUSHTOKEN];
    __weak UserManager* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request requestRemoveUserAccount:account WithPushKey:pushKey WithToken:self.token Bk:^(id backDic, NetWorkStatus status) {
    
        if (status == NetWorkStatusSuccess) {
            complete(YES,nil);
            [wSelf removeUserData];
        }
        else
        {
            complete(NO,backDic);
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
    [request registePushToken:pushKey WithAccount:account WithBk:^(id backDic, NetWorkStatus status) {
        
        if (backDic) {
            
//            [def setObject:@"YES" forKey:PUSHOK];
        }
        else
        {
          
        }
    }];
    [request startAsynchronous];
}

#pragma mark----------------log function--------

-(BOOL)isLogin
{
    return self.shopName!=nil;
}
-(void)logInWithPhone:(NSString *)phone Pass:(NSString *)ps logBack:(logCallBack) blockBack
{
    __weak UserManager* bSelf = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
     [req shopLoginWithPhone:phone password:ps withCallBack:^(id backDic, NetWorkStatus status) {
         
         if (status != NetWorkStatusSuccess) {
            blockBack(NO,backDic);
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
            
            NSString*pwMd5 = [NSString md5:ps];
            
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            [def setObject:pwMd5  forKey:PWMD5];
            
             blockBack(YES,nil);
            [bSelf registePushKey];
        }
               
    }];

    [req startAsynchronous];
}


-(BOOL)verifyTokenOnNet:(void(^)(BOOL success, id error))completeBlock
{
    NSString* t = [self checkTokenExsit];
    if (t==nil) {
        return NO;
    }
    
    __weak UserManager* bSelf = self;
    
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req verifyTokenToServer:t WithCallBack:^(NSDictionary* backDic, NetWorkStatus status) {
        
        if (status==NetWorkStatusSuccess) {
            
            NSArray* shopArr = backDic[@"data"][@"shop"];
            [self saveAllShopArr:shopArr];
            
            bSelf.token = backDic[@"token"];
            bSelf.shopName = backDic[@"data"][@"shop"][0][@"name"];
            bSelf.shopID = backDic[@"data"][@"shop"][0][@"id"];
            bSelf.shopAddress = backDic[@"data"][@"shop"][0][@"shop_address"];
            bSelf.phoneNumber = backDic[@"data"][@"shop"][0][@"tel"];
            
            completeBlock(YES,nil);
        }
        else
        {
            completeBlock(NO,backDic);
        }
    }];
    [req startAsynchronous];
    return t !=nil;
}



-(void)saveAllShopArr:(NSArray*)arr
{
    NSString* shopDirectory = [NSHomeDirectory()
                               stringByAppendingFormat:@"/Documents/%@",@"shopArr"];
    
    [arr writeToFile:shopDirectory atomically:YES];
}

@end
