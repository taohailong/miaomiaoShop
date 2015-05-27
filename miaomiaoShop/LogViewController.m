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
    IBOutlet UIButton* _logBt;
    IBOutlet UIView* _backView;
}
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    phoneField.leftViewMode =UITextFieldViewModeAlways;
    UIImageView* phoneLeftV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    phoneLeftV.contentMode = UIViewContentModeScaleAspectFit;
    phoneLeftV.image = [UIImage imageNamed:@"login_photo"];
    phoneField.leftView = phoneLeftV;
    
    
    pwField.leftViewMode =UITextFieldViewModeAlways;
    UIImageView* pwLeftV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    pwLeftV.image = [UIImage imageNamed:@"login_pw"];
    pwLeftV.contentMode = UIViewContentModeScaleAspectFit;
    pwField.leftView = pwLeftV;

    
    _logBt.layer.masksToBounds = YES;
    _logBt.layer.cornerRadius = 6;
    _logBt.layer.borderWidth = 1;
    _logBt.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self registeNotificationCenter];
    // Do any additional setup after loading the view.
}


-(void)registeNotificationCenter
{
    /*注册成功后  重新链接服务器*/
    
    NSNotificationCenter *def = [NSNotificationCenter defaultCenter];
    
    /* 注册键盘的显示/隐藏事件 */
    [def addObserver:self selector:@selector(keyboardShown:)
                name:UIKeyboardWillShowNotification
											   object:nil];
    
    
    [def addObserver:self selector:@selector(keyboardHidden:)name:UIKeyboardWillHideNotification
											   object:nil];
    
}


- (void)keyboardShown:(NSNotification *)aNotification
{
    [self accessViewAnimate:80];
    
}


- (void)keyboardHidden:(NSNotification *)aNotification
{
    [self accessViewAnimate:0.0];
}

-(void)accessViewAnimate:(float)height
{
    
    [UIView animateWithDuration:.2 delay:0 options:0 animations:^{
        
        
        for (NSLayoutConstraint * constranint in self.view.constraints) {
            
            
            if (constranint.secondItem==_backView&&constranint.firstAttribute==NSLayoutAttributeCenterY) {
                NSLog(@"%@ ",constranint);
//                [self.view removeConstraint:constranint];
                constranint.constant = height;
//                [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:height]];
            }
            
        }
        
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
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
    
    [phoneField resignFirstResponder];
    [pwField resignFirstResponder];
    
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
