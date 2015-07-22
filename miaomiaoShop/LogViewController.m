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
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.font = DEFAULTFONT(18);
    titleLabel.textColor = FUNCTCOLOR(64, 64, 64);
    titleLabel.text = @"使用账号和密码登录";
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    
    
    phoneField = [[UITextField alloc]init];
    phoneField.placeholder = @"喵喵商家专用账号";
    phoneField.keyboardType = UIKeyboardTypeASCIICapable;
    phoneField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:phoneField];
    phoneField.leftViewMode =UITextFieldViewModeAlways;
    UILabel* phoneLeftV = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
    phoneLeftV.text = @"密码";
    phoneLeftV.font = DEFAULTFONT(16);
    phoneLeftV.textColor = FUNCTCOLOR(64, 64, 64);
//    phoneLeftV.contentMode = UIViewContentModeScaleAspectFit;
//    phoneLeftV.image = [UIImage imageNamed:@"login_photo"];
    phoneField.leftView = phoneLeftV;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[phoneField]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(phoneField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-20-[phoneField(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel,phoneField)]];
    
    
  
    
    UIView* separate1 = [[UIView alloc]init];
    separate1.backgroundColor = FUNCTCOLOR(221, 221, 221);
    separate1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:separate1];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[phoneField]-3-[separate1(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(phoneField,separate1)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:separate1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:phoneField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:separate1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:phoneField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    
    
    
    pwField = [[UITextField alloc]init];
    pwField.placeholder = @"请填写密码";
    pwField.secureTextEntry = YES;
    pwField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pwField];
    
    pwField.leftViewMode =UITextFieldViewModeAlways;
    UILabel* pwLeftV = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
    pwLeftV.text = @"账号";
    pwLeftV.font = DEFAULTFONT(16);
    pwLeftV.textColor = FUNCTCOLOR(64, 64, 64);
    pwField.leftView = pwLeftV;

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separate1]-20-[pwField(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separate1,pwField)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pwField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:phoneField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pwField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:phoneField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    
    
    
    UIView* separate2 = [[UIView alloc]init];
    separate2.backgroundColor = FUNCTCOLOR(221, 221, 221);
    separate2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:separate2];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pwField]-3-[separate2(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pwField,separate2)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:separate2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pwField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:separate2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pwField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];

    
    _logBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _logBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_logBt];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separate2]-25-[_logBt(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separate2,_logBt)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_logBt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:pwField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_logBt attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:pwField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [_logBt setTitle:@"登录" forState:UIControlStateNormal];
    [_logBt addTarget:self action:@selector(logAction:) forControlEvents:UIControlEventTouchUpInside];
    _logBt.layer.masksToBounds = YES;
    _logBt.layer.cornerRadius = 6;
//    _logBt.layer.borderWidth = 1;
    _logBt.backgroundColor = DEFAULTNAVCOLOR;
    
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
    [user logInWithPhone:phoneField.text Pass:pwField.text logBack:^(BOOL success, id respond) {
        
         [loading removeFromSuperview];
        if (success) {
            [wSelf dismissViewControllerAnimated:YES completion:^{}];
        }
        else
        {
            
            THActivityView* alter = [[THActivityView alloc]initWithString:respond];
            [alter show];
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
