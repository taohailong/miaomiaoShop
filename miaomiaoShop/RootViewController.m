//
//  RootViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/15.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "RootViewController.h"
#import "AdvertiseCollectionCell.h"
#import "PCollectionCell.h"
#import "FloatView.h"
@interface RootViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PosterProtocol>
{
    UICollectionView* _collectionView;
    FloatView* _floatView;
}
@end
@implementation RootViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    _collectionView.backgroundColor = FUNCTCOLOR(243, 243, 243);
    [_collectionView registerClass:[PCollectionCell class] forCellWithReuseIdentifier:@"PCollectionCell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_collectionView registerClass:[AdvertiseCollectionCell class] forCellWithReuseIdentifier:@"AdvertiseCollectionCell"];
    
//    [_collectionView registerClass:[PCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PCollectionHeadView"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_collectionView];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_collectionView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    
    
    
//    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"root_right"] style:UIBarButtonItemStylePlain target:self action:@selector(showShopInfoViewController)];
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithTitle:@"float" style:UIBarButtonItemStyleDone target:self action:@selector(showFloatView)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShopInfo) name:SHOPROOTCHANGE object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiShowLogView) name:PNEEDLOG object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarNuChanged) name:PSHOPCARCHANGE object:nil];
    
    
//    UserManager* manager = [UserManager shareUserManager];
//    
//    if (manager.shopID!=nil) {
//        [self checkLocation];
//        [self updateNavigationView];
//    }
//    [self getShopInfo];
}
#pragma mark-floatView

-(void)showFloatView
{
    if (_floatView==nil) {
        _floatView = [[FloatView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    }
   
    [self.navigationController.view addSubview:_floatView];
    [_floatView showFloatView];
}


#pragma mark-----------collectionView ---------------

//|error| Could not find <PCollectionCell: 0x7beb0990; baseClass = UICollectionViewCell; frame = (0 129; 159.5 44); layer = <CALayer: 0x7beb0b50>> in a list of sorted view [parent: <UIApplication: 0x7be08130>] siblings ("<UICollectionView: 0x7d247a00; frame = (0 0; 320 480); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x7bea25f0>; layer = <CALayer: 0x7bea31a0>; contentOffset: {0, -64}; contentSize: {320, 474}> collection view layout: <UICollectionViewFlowLayout: 0x7bea3f00>").  If this happened right around a screen change, it might be okay, but otherwise this is probably a bug.

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    return 6;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREENWIDTH, 10);
    
}
//
//-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    PCollectionHeadView* head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PCollectionHeadView" forIndexPath:indexPath];
//    ShopCategoryData* category = _categoryArr[indexPath.section -1];
//    [head setTitleLabelStr:category.categoryName];
//    [head setDetailStr:@"查看更多"];
//    __weak RootViewController* wSelf = self;
//    __weak ShopCategoryData* wCategory = category;
//    [head setHeadBk:^{
//        [wSelf collectionViewDidSelectHeadViewWithData:wCategory];
//    }];
//    return head;
//}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row !=0) {
            return CGSizeMake((SCREENWIDTH-1)/2, 44);
        }
        
        return CGSizeMake(SCREENWIDTH, SCREENWIDTH*0.4);
    }
    return CGSizeMake((SCREENWIDTH-2)/3, (SCREENWIDTH-2)/3);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{//水平间隙
    return 0.5;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{//垂直间隙
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            AdvertiseCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdvertiseCollectionCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.backgroundColor = [UIColor redColor];
            //        [cell setImageDataArr:_picUrls];
            return cell;
        }
        
        __weak RootViewController* wSelf = self;
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
    
        return cell;
    }
    
    __weak RootViewController* wSelf = self;
    PCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PCollectionCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    NSString* imageName = nil;
    NSString* title = nil;
    switch (indexPath.row) {
        case 0:
            imageName = @"root_shopManage";
            title = @"营业管理";
            break;
        case 1:
            imageName = @"root_orderManage";
            title = @"订单管理";
            break;
        case 2:
            imageName = @"root_moneyManage";
            title = @"钱包";
            break;
        case 3:
            imageName = @"root_productManage";
            title = @"商品管理";
            break;
        case 4:
            
            imageName = @"root_categoryManage";
            title = @"分类管理";
            break;
        case 5:
            imageName = @"root_more";
            title = @"更多";
            break;
        default:
            break;
    }
    [cell setPicUrl:imageName];
    [cell setTitleStr:title];
    
    return cell;
}

//headView 点击方法
//-(void)collectionViewDidSelectHeadViewWithData:(ShopCategoryData*)data
//{}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{}


@end
