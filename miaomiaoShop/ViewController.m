//
//  ViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame = CGRectMake(100, 100, 50, 60);
    bt.backgroundColor = [UIColor redColor];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    
//    UITabBarController
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
//    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)photo:(id)sender
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.allowsEditing=NO;
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.delegate=self;
    //    picker.UIImagePickerControllerQualityTypeLow
    
    
    [self.navigationController presentViewController:picker animated:YES completion:^{}];
    
    
}
@end
