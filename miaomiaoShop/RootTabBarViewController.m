//
//  RootTabBarViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "UserManager.h"
#import "LogViewController.h"
#import "THActivityView.h"
@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController
-(void)viewDidAppear:(BOOL)animated
{
    //[self checkUserLogState];
}

-(void)checkUserLogState
{
    UserManager* manage = [UserManager shareUserManager];

    if ([manage isLogin]) {
        return;
    }
    
    __weak RootTabBarViewController* wSelf = self;
    if ([manage verifyTokenOnNet:^(BOOL success, NSError *error) {
        
        if (success==NO)
        {
            THActivityView* alter = [[THActivityView alloc]initWithString:@"登录验证失效"];
            [alter show];
            LogViewController* log = [wSelf.storyboard instantiateViewControllerWithIdentifier:@"LogViewController"];
            [wSelf presentViewController:log animated:YES completion:^{}];
        }
        
    }]==NO)
    
    {
        
        LogViewController* log = [self.storyboard instantiateViewControllerWithIdentifier:@"LogViewController"];
        [self presentViewController:log animated:YES completion:^{}];
    }
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
