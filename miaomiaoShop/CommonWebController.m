//
//  CommonWebController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-27.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CommonWebController.h"
#import "UserManager.h"
@implementation CommonWebController
-(void)viewDidLoad
{
    UIWebView* web = [[UIWebView alloc]init];
    [self.view addSubview:web];
    web.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[web]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(web)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[web]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(web)]];
    
    UserManager* manager = [UserManager shareUserManager];
#if DEBUG
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/wallet/cashPrompt?shop_id=%@",@"www.mbianli.com:8088",manager.shopID];
#else
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/wallet/cashPrompt?shop_id=%@", @"www.mbianli.com",manager.shopID];
#endif
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
@end
