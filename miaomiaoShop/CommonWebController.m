//
//  CommonWebController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-27.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CommonWebController.h"

@implementation CommonWebController

-(id)initWithUrl:(NSString*)url
{
    self = [super init];
    _url = url;
    return self;
}

-(void)viewDidLoad
{
    web = [[UIWebView alloc]init];
    web.delegate = self;
    [self.view addSubview:web];
    web.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[web]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(web)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[web]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(web)]];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    _warnView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_warnView removeFromSuperview];
    
}



//-(void)viewDidLoad
//{
//    UIWebView* web = [[UIWebView alloc]init];
//    [self.view addSubview:web];
//    web.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[web]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(web)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[web]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(web)]];
//    
//    UserManager* manager = [UserManager shareUserManager];
//    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/wallet/cashPrompt?shop_id=%@", @"www.mbianli.com",manager.shopID];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//}
@end
