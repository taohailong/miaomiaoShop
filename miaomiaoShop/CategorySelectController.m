//
//  CategorySelectViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CategorySelectController.h"
#import "ShopCategoryListView.h"
@interface CategorySelectController ()<ShopCategoryProtocol>
{
    ShopCategoryListView* _listView;
}
@end

@implementation CategorySelectController

-(id)initWithCompleteBk:(CategorySelectBk)bk
{
    self= [super init];
    _completeBk = bk;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _listView = [[ShopCategoryListView alloc]init];
    _listView.translatesAutoresizingMaskIntoConstraints =  NO;
    [self.view addSubview:_listView];
    _listView.delegate = self;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_listView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_listView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_listView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_listView)]];
   
    [_listView initNetData];
    // Do any additional setup after loading the view.
}

-(void)didSelectCategoryIndexWith:(NSString *)categoryID WithName:(NSString *)name
{
    if (_completeBk) {
        _completeBk(categoryID,name);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
