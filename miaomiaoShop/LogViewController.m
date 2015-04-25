//
//  LogViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "LogViewController.h"
#import "THActivityView.h"
#import "UserManager.h"
@interface LogViewController ()
{
    IBOutlet UITextField* phoneField;
    IBOutlet UITextField* pwField;
}
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)logAction:(id)sender
{
    if (phoneField.text.length==0||pwField.text.length==0) {
        THActivityView* alter = [[THActivityView alloc]initWithString:@"账号或密码无效！"];
        [alter show];
        return;
    }
    
    THActivityView* loading = [[THActivityView alloc]initActivityView];
    loading.center = self.view.center;
    [self.view addSubview:loading];
    
    __weak LogViewController* wSelf = self;
    
    UserManager* user = [UserManager shareUserManager];
    [user logInWithPhone:phoneField.text Pass:pwField.text logBack:^(BOOL success, NSError *err) {
        if (success) {
            [wSelf dismissViewControllerAnimated:YES completion:^{}];
        }
        else
        {
            
            THActivityView* alter = [[THActivityView alloc]initWithString:@"登录失败！"];
            [alter show];
            [loading removeFromSuperview];
        }
        
    }];
   
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
