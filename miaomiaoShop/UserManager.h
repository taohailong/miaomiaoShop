//
//  UserManager.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UTOKEN @"userToken"
#define USHOPID @"shop_id"
#define UACCOUNT @"user_account"
#define PUSHTOKEN @"push_token"
#define PWMD5 @"password_md5"

@interface UserManager : NSObject
typedef void (^logCallBack)(BOOL success,id respond) ;
+(UserManager*)shareUserManager;
@property(nonatomic,strong)NSString* shopName;
@property(nonatomic,strong)NSString* phoneNumber;
@property(nonatomic,strong)NSString* token;
@property(nonatomic,strong)NSString* shopID;
@property(nonatomic,strong)NSString* shopAddress;
@property(nonatomic,strong)NSString* shopSpread;


-(void)savePushToken:(NSString*)push;
-(void)registePushKey;
-(void)removeUserAccountWithBk:(logCallBack)complete;


-(NSString*)getUserAccount;
-(BOOL)isLogin;
//@property(nonatomic,assign)
//-(void)logInWithPhone:(NSString*)phone Pass:(NSString*)ps;
-(void)logInWithPhone:(NSString *)phone Pass:(NSString *)ps logBack:(logCallBack) blockBack;
-(BOOL)verifyTokenOnNet:(void(^)(BOOL success, id error))completeBlock;
@end
