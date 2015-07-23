//
//  SuggestViewController.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-21.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "SuggestViewController.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"

@interface SuggestViewController()
{
   UITextView* _textView;

}
@end
@implementation SuggestViewController

-(void)viewDidAppear:(BOOL)animated
{
    [_textView becomeFirstResponder];
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = FUNCTCOLOR(243, 243, 243);
    self.title = @"意见反馈";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 84, 200, 80) textContainer:nil];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 4;

//    _textView.layer.borderWidth = 1;
//    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.view addSubview:_textView];
    _textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_textView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    if (IOS_VERSION(7.0)) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[_textView(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    }
    else
    {
      [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_textView(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    }
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(saveSuggestion)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(void)saveSuggestion
{
    if (_textView.text.length==0) {
        return;
    }
    [_textView resignFirstResponder];
//    __weak SuggestViewController* wself = self;
//    THActivityView* loading = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
//    
//    NetWorkRequest* req = [[NetWorkRequest alloc]init];
//    [req commitSuggestionString:_textView.text WithBk:^(id respond, NetWorkStatus status) {
//        
//        [loading removeFromSuperview];
//        if (NetWorkSuccess == status) {
//            
//            THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功"];
//            [showStr show];
//            [wself.navigationController popToRootViewControllerAnimated:YES];
//        }
//        else
//        {
//            THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败"];
//            [showStr show];
//        }
//    }];
//    [req startAsynchronous];
//
}


@end
