//
//  UserManager.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
typedef void (^logCallBack)(BOOL success,NSError* err) ;
+(UserManager*)shareUserManager;
@property(nonatomic,strong)NSString* shopName;
@property(nonatomic,strong)NSString* phoneNumber;
@property(nonatomic,strong)NSString* token;
@property(nonatomic,strong)NSString* shopID;
@property(nonatomic,strong)NSString* shopAddress;

-(BOOL)isLogin;
//@property(nonatomic,assign)
//-(void)logInWithPhone:(NSString*)phone Pass:(NSString*)ps;
-(void)logInWithPhone:(NSString *)phone Pass:(NSString *)ps logBack:(logCallBack) blockBack;
-(BOOL)verifyTokenOnNet:(void(^)(BOOL success, NSError *error))completeBlock;
@end
