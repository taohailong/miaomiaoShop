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
    self.title = @"选择分类";
      // Do any additional setup after loading the view.
}




-(void)creatBottomBt
{
    _rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBt setTitle:@"保存" forState:UIControlStateNormal];
    [_rightBt addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_rightBt];
    
    _btSpaceLayout = [NSLayoutConstraint constraintWithItem:_rightBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:CGRectGetWidth(self.view.frame)/2];
    [self.view addConstraint:_btSpaceLayout];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_rightBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_subCate attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightBt)]];
    
    [_rightBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
    

    _leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBt setTitle:@"取消" forState:UIControlStateNormal];
    [_leftBt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    _leftBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_leftBt];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_subCate attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_leftBt]-0-[_rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftBt,_rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftBt)]];
    
    [_leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLighter"] forState:UIControlStateNormal];
}


-(void)saveAction
{
    ShopCategoryData* main = [_mainCate getSelectCategory];
    ShopCategoryData* sub = [_subCate getCurrentCategory];
    _product = [[ShopProductData alloc]init];
    _product.categoryID = main.categoryID;
    _product.categoryName = main.categoryName;
    
    _product.subCateName = sub.categoryName;
    _product.subCateID = sub.categoryID;
    
    if (_completeBk) {
        _completeBk(_product);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)cancelAction
{
   [self.navigationController popViewControllerAnimated:YES];
}


//-(void)didSelectCategoryIndexWith:(NSString *)categoryID WithName:(NSString *)name
//{
//    if (_completeBk) {
//        _completeBk(categoryID,name);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//  }

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
