//
//  ManagerCategoryController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ManageCategoryController.h"

@implementation ManageCategoryController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS_VERSION(7.0)) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _subCate = [[ManageSubCateList alloc]init];
    _subCate.backgroundColor = [UIColor greenColor];
    _subCate.translatesAutoresizingMaskIntoConstraints = NO;
//    _subCate.delegate = self;
    [self.view addSubview:_subCate];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_subCate]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_subCate)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_subCate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.7 constant:0]];
    
    
    if (IOS_VERSION(7.0)) {
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_subCate]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_subCate)]];    }
    else
    {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_subCate]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_subCate)]];
    }
    
    
    
    _mainCate = [[ManageMainCateList alloc]init];
    _mainCate.translatesAutoresizingMaskIntoConstraints = NO;
    _mainCate.delegate = self;
    [self.view addSubview:_mainCate];
    [_mainCate  initNetData];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mainCate]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mainCate)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainCate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainCate attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_subCate attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainCate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_subCate attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    
    
    
    _rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBt setTitle:@"编辑二级分类" forState:UIControlStateNormal];
    [_rightBt addTarget:self action:@selector(editSubCategory) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_rightBt];
    
    _btSpaceLayout = [NSLayoutConstraint constraintWithItem:_rightBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:CGRectGetWidth(self.view.frame)/2];
    [self.view addConstraint:_btSpaceLayout];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_rightBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_subCate attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightBt)]];
    
    [_rightBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
    
    
    
    
    
    UIButton* leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setTitle:@"编辑一级分类" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(editMainCategory) forControlEvents:UIControlEventTouchUpInside];
    
    leftBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:leftBt];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_subCate attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBt]-0-[_rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt,_rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt)]];
    
    [leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLight"] forState:UIControlStateNormal];
    
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"排序" style:UIBarButtonItemStyleBordered target:self action:@selector(editOrder:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
}

-(void)editOrder:(UIBarButtonItem*)bt
{
    bt.tag = !bt.tag;
    if (bt.tag == 1) {
        _btSpaceLayout.constant = CGRectGetWidth(self.view.frame);
        [_subCate setProductEditStyle:YES];
        [_mainCate setProductEditStyle:YES];
        [_rightBt setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        [_subCate setProductEditStyle:NO];
        [_mainCate setProductEditStyle:NO];
        [_rightBt setTitle:@"编辑二级分类" forState:UIControlStateNormal];
        _btSpaceLayout.constant = CGRectGetWidth(self.view.frame)/2;
        [self editSubCategory];
    }
    
}

-(void)editMainCategory
{
    
}
-(void)editSubCategory
{

}


#pragma mark-MainCategoryDelegate

-(void)selectMainCateReturnSubClass:(NSMutableArray *)arr
{
    [_subCate setDataArrReloadTable:arr];
}
@end
