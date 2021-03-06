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
#import "RootDetailCell.h"
#import "UserManager.h"
#import "LogViewController.h"
#import "ShopObjectController.h"
#import "THActivityView.h"
#import "NetWorkRequest.h"
#import "OrderListViewController.h"
#import "ShopInfoViewController.h"
#import "ShopBusinessController.h"
#import "NavigationTitleView.h"
#import "ShopSelectController.h"
#import "SuggestViewController.h"
#import "AboutController.h"
#import "CommonWebController.h"
#import "RootIndicateCell.h"
#import "ManageCategoryController.h"
@interface RootViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PosterProtocol,FloatProtocol,NavigationTieleViewProtocol>
{
    UICollectionView* _collectionView;
    FloatView* _floatView;
    ShopInfoData* _shop;
    NSArray* _picDataArr;
    NSMutableArray* _picUrls;
}
@property(nonatomic,weak)THActivityView* errView;
@end
@implementation RootViewController
@synthesize errView;

#pragma mark- check login

-(void)checkUserLogState
{
    UserManager* manage = [UserManager shareUserManager];
    
    if ([manage isLogin]) {
        return;
    }
    
    __weak RootViewController* wSelf = self;
    if ([manage verifyTokenOnNet:^(BOOL success, NSError *error) {
        
        if (success==NO)
        {
            THActivityView* alter = [[THActivityView alloc]initWithString:@"登录验证失效"];
            [alter show];
            [wSelf  showLogView];
        }
        
    }]==NO)
        
    {
        [self showLogView];
    }
}


-(void)setNavigationBarAttribute:(BOOL)flag
{
    UIColor * color = nil;
    if (flag)
    {
        color = [UIColor whiteColor];
        [self.navigationController.navigationBar setTintColor:color];
        [self.navigationController.navigationBar setBarTintColor:FUNCTCOLOR(254, 87, 84)];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
//        if (self.navigationController.viewControllers.count == 1) {
//            return;
//        }
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        color =  FUNCTCOLOR(102.0,102.0,102.0);
        [self.navigationController.navigationBar setTintColor:color];
        color = FUNCTCOLOR(64, 64, 64);
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
    NSDictionary * dict = @{NSForegroundColorAttributeName:color,NSFontAttributeName:DEFAULTFONT(18)};
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self checkUserLogState];
    [self netShopInfoFromNet];
    [self setNavigationBarAttribute:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
   [self setNavigationBarAttribute:NO];
}


-(void)showLogView
{
    LogViewController* log = [self.storyboard instantiateViewControllerWithIdentifier:@"LogViewController"];
    [self presentViewController:log animated:YES completion:^{}];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    _collectionView.backgroundColor = FUNCTCOLOR(237, 237, 237);
    [_collectionView registerClass:[PCollectionCell class] forCellWithReuseIdentifier:@"PCollectionCell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_collectionView registerClass:[AdvertiseCollectionCell class] forCellWithReuseIdentifier:@"AdvertiseCollectionCell"];
    
    [_collectionView registerClass:[RootDetailCell class] forCellWithReuseIdentifier:@"RootDetailCell"];
    [_collectionView registerClass:[RootIndicateCell class] forCellWithReuseIdentifier:@"RootIndicateCell"];
    
    //[_collectionView registerClass:[PCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PCollectionHeadView"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_collectionView];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_collectionView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    
    
    
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"root_leftIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(showFloatView)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    
    UIView* titleView = [self  navgationTitleView];
    self.navigationItem.titleView = titleView;
    
//    [self setAttributeOfNavigationBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogView) name:TOKENINVALID object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiShowLogView) name:PNEEDLOG object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarNuChanged) name:PSHOPCARCHANGE object:nil];
}

-(void)setAttributeOfNavigationBar
{
    NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:DEFAULTFONT(18)};
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    if (IOS_VERSION(7.0)) {
        //        [self.navigationController.navigationBar setBarTintColor:FUNCTCOLOR(254, 87, 84)];
    }

}

#pragma mark-navigationTitleView

-(UIView*)navgationTitleView
{
    NavigationTitleView* titleView = [[NavigationTitleView alloc]initWithFrame:CGRectMake(0, 0, 250, 44)];
    titleView.delegate = self;
    return titleView;
}


-(void)updateNavigationView
{
    NavigationTitleView* title = (NavigationTitleView*)self.navigationItem.titleView;
    
    UserManager* manager = [UserManager shareUserManager];
    if ([manager onlyOneShop]==YES) {
        [title setImageHidden:YES];
    }
    else
    {
        [title setImageHidden:NO];
    }
    UILabel* textLabel = [title getTextLabel];

    textLabel.text = _shop.shopName;
}

-(void)navigationTitleViewDidTouchWithView:(NavigationTitleView *)titleView
{
    UserManager* manager = [UserManager shareUserManager];
    if ([manager onlyOneShop]==YES) {
        return;
    }
    ShopSelectController* shopSelect = [[ShopSelectController alloc]init];
    [self.navigationController pushViewController:shopSelect animated:YES];
}

#pragma mark-floatView

-(void)showFloatView
{
    if (_floatView==nil) {
        
        _floatView = [[FloatView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _floatView.delegate = self;
    }
   
    [self.navigationController.view addSubview:_floatView];
    [_floatView showFloatView];
}


-(void)floatViewSelectStyle:(FloatActionStyle)action
{
    if (action == FloatActionAbout ) {
        AboutController* aboutView = [[AboutController alloc]init];
        [self.navigationController pushViewController:aboutView animated:YES];
    }
    else if (action == FloatActionLogOut)
    {
        __weak RootViewController* wself = self;
        UserManager* manager = [UserManager shareUserManager];
        [manager removeUserAccountWithBk:^(BOOL success, id respond) {
            
            if (success==NO) {
                return ;
            }
            [wself showLogView];
        }];
        
    }
    else if (action == FloatActionSuggestion)
    {
        SuggestViewController* sController = [[SuggestViewController alloc]init];
        [self.navigationController pushViewController:sController animated:YES];
    }
    [_floatView hidFloatView];
}


#pragma mark-----------collectionView ---------------

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
            return CGSizeMake((SCREENWIDTH-1)/2, 62);
        }
        
        return CGSizeMake(SCREENWIDTH, SCREENWIDTH*0.4);
    }
    return CGSizeMake((SCREENWIDTH-2)/3, (SCREENWIDTH-2)/3);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{//水平间隙
    return 1;
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
            [cell setImageDataArr:_picUrls];
            return cell;
        }
        
        RootDetailCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootDetailCell" forIndexPath:indexPath];
        if (_shop == nil) {
            return cell;
        }
        if (indexPath.row ==1) {
            
            [cell setTitleLabelStr:[NSString stringWithFormat:@"%@单",_shop.countOrder]];
            [cell setContentLabelStr:@"在线支付订单总数"];
        }
        else
        {
            [cell setTitleLabelStr:[NSString stringWithFormat:@"%@", _shop.totalMoney]];
            [cell setContentLabelStr:@"在线支付订单总金额"];
        }
        
        return cell;
    }
    
//    __weak RootViewController* wSelf = self;
    
    if (indexPath.row == 0) {
        RootIndicateCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootIndicateCell" forIndexPath:indexPath];
        
        if (_shop.shopStatue == ShopStatusClose) {
            [cell setIndicateImage:@"root_indicate_close"];
        }
        else
        {
            [cell setIndicateImage:@"root_indicate_open"];
        }
        
        [cell setPicUrl:@"root_shopManage"];
        [cell setTitleStr:@"营业管理"];
        return cell;
    }
    
    
    
    PCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PCollectionCell" forIndexPath:indexPath];
    
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
{
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            [self showShopManageController];
        }
        else if (indexPath.row == 1)
        {
            [self showOrderManageController];
        }
        else if (indexPath.row == 2)
        {
            [self showMoneyManageController];
        }
        else if (indexPath.row == 3)
        {
            [self showProductManageController];
        }
        else if (indexPath.row == 4)
        {
            [self showCategoryManageController];
        }
        else
        {
            [self showMoreController];
        }
        
    }

}

#pragma mark-netApi


-(void)netShopInfoFromNet
{
    __weak RootViewController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getShopInfoWitbBk:^(NSDictionary* backDic, NetWorkStatus status) {
        //        防止多次错误 时errView重叠
        [wSelf.errView removeFromSuperview];
        if (status == NetWorkStatusSuccess) {
            [wSelf getShopInfo:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
            
        }

        else if (status == NetWorkStatusErrorCanntConnect)
        {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            wSelf.errView = loadView;
            [loadView setErrorBk:^{
                [wSelf netShopInfoFromNet];
            }];
        }
    }];
    [request startAsynchronous];
    
}

-(void)getShopInfo:(NSDictionary*)sourceDic
{
    _shop = sourceDic[@"shop"];
    _picDataArr = sourceDic[@"pic_data"];
    _picUrls = sourceDic[@"pics"];
    [_collectionView reloadData];
    [self updateNavigationView];
}


#pragma mark-action

-(void)showShopManageController
{
    if (_shop == nil) {
        return;
    }
    
    
    ShopInfoViewController * shopInfo = [[ShopInfoViewController alloc]initWithShopInfoData:_shop];
    shopInfo.title = @"营业管理";
    shopInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopInfo animated:YES];
}

-(void)showOrderManageController
{
//    OrderListViewController* order = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderListViewController"];
    
    OrderListViewController* order = [[OrderListViewController alloc]init];
    order.title = @"订单管理";
    [self.navigationController pushViewController:order animated:YES];
}

-(void)showMoneyManageController
{
    ShopBusinessController* moneyController = [[ShopBusinessController alloc]init];
     moneyController.title = @"钱包";
    [self.navigationController pushViewController:moneyController animated:YES];
    
}

-(void)showProductManageController
{
    ShopObjectController* object = [[ShopObjectController alloc]init];
    object.title = @"商品管理";
    [self.navigationController pushViewController:object animated:YES];
}

-(void)showCategoryManageController
{
    ManageCategoryController* manager = [[ManageCategoryController alloc]init];
    manager.title = @"分类管理";
    [self.navigationController pushViewController:manager animated:YES];
}

-(void)showMoreController
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark-delegate

-(void)posterViewDidSelectAtIndex:(NSInteger)index WithData:(id)data
{
    NSDictionary* dic = _picDataArr[index];
    NSString* url = dic[@"redirect"];
    if (url.length >0) {
        
        CommonWebController* web = [[CommonWebController alloc]initWithUrl:url];
        [self.navigationController pushViewController:web animated:YES];
    }
}



@end
