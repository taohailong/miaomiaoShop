//
//  ShopNameChangeController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopNameChangeController.h"

@implementation ShopNameChangeController
@synthesize delegate;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"更改商铺名称";
    self.view.backgroundColor = FUNCTCOLOR(232, 232, 232);
    _contentField = [[UITextField alloc]init];
    _contentField.layer.cornerRadius = 4;
    _contentField.layer.masksToBounds = YES;
    _contentField.backgroundColor = [UIColor whiteColor];
    _contentField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_contentField];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_contentField]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentField)]];
    
    
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-74-[_contentField(35)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentField)]];
    
    
    UIButton* confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBt.backgroundColor = DEFAULTNAVCOLOR;
    [confirmBt addTarget:self action:@selector(confirmBtAction) forControlEvents:UIControlEventTouchUpInside];
    confirmBt.layer.cornerRadius = 4;
    confirmBt.layer.masksToBounds = YES;
    [confirmBt setTitle:@"确认" forState:UIControlStateNormal];
    confirmBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:confirmBt];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[confirmBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(confirmBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_contentField]-15-[confirmBt(35)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentField,confirmBt)]];

    
}

-(void)confirmBtAction
{
    if (_contentField.text.length==0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(shopNameChanged:)]) {
        [self.delegate shopNameChanged:_contentField.text];
    }
}


@end
