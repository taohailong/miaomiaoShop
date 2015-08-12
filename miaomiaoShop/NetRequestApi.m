//
//  NetRequestApi.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "NetRequestApi.h"
@interface NetRequestApi()
{
    AFHTTPRequestOperation* _afnet;
}
@end
@implementation NetRequestApi

-(void)getMethodRequestStrUrl:(NSString*)url returnBlock:(NetApiReturnBlock)reBlock  errorBlock:(NetApiErrorBlock)errBlock  failureBlock:(NetApiFailureBlock)fBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    _afnet = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [_afnet setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        
        if (dataDic&&[dataDic[@"code"] intValue]==0) {
            reBlock(dataDic);
        }
        else if ([dataDic[@"code"] intValue]==300)
        {
            errBlock(NetApiTokenInvalid,nil);
//            [manager removeUserData];
//            [[NSNotificationCenter defaultCenter] postNotificationName:TOKENINVALID object:nil];
        }
        else
        {
             errBlock(NetApiErrMess,dataDic[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        fBlock(@"网络连接失败！");
    }];
    
    return;
    
}


-(void)startAsynchronous
{
    [_afnet start];
}

-(void)cancel
{
    [_afnet cancel];
    _afnet = nil;
}
@end
