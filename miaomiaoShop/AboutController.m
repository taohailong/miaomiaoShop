//
//  AboutController.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-6-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AboutController.h"

@implementation AboutController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于喵喵";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
}

-(void)creatSubView
{
    UIImageView* iconImage = [[UIImageView alloc]init];
    iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iconImage];
    iconImage.layer.masksToBounds = YES;
    iconImage.layer.cornerRadius = 4;
    
    iconImage.image = [UIImage imageNamed:@"about_Icon"];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:iconImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:iconImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:2.0/3.0 constant:0]];
    
    
    
    UIImageView* stringImage = [[UIImageView alloc]init];
    stringImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stringImage];
    
    stringImage.image = [UIImage imageNamed:@"about_subImage"];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:stringImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconImage]-10-[stringImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iconImage,stringImage)]];
    
    
    
    UILabel* version = [[UILabel alloc]init];
    version.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:version];
    version.layer.masksToBounds = YES;
    version.layer.cornerRadius = 7;
    version.layer.borderColor = FUNCTCOLOR(153, 153, 153).CGColor;
    version.layer.borderWidth = 1;
    
    version.text = [NSString stringWithFormat:@"版本V%@",VERSION];
    version.textAlignment = NSTextAlignmentCenter;
    version.textColor = FUNCTCOLOR(153, 153, 153);
    version.font = DEFAULTFONT(12);
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:version attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[stringImage]-10-[version(>=17)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(stringImage,version)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[version(>=65)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(version)]];
    
    
    UILabel* copyRight = [[UILabel alloc]init];
    copyRight.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:copyRight];
    copyRight.text = @"Copyright © 2014-2015 Wuxi Chestnut Co., Ltd.";
    copyRight.textColor = FUNCTCOLOR(153, 153, 153);
    copyRight.font = DEFAULTFONT(12);
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:copyRight attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[copyRight]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(copyRight)]];

    
    
    
    
    UILabel* company = [[UILabel alloc]init];
    company.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:company];
    company.text = @"无锡栗子网络科技有限公司";
    company.textColor = FUNCTCOLOR(153, 153, 153);
    company.font = DEFAULTFONT(12);
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:company attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[company]-5-[copyRight]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(company,copyRight)]];
    
}
@end
