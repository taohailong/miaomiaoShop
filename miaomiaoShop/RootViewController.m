//
//  RootViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "RootViewController.h"
#import "NetWorkRequest.h"
#import "ShopInfoData.h"
#import "ShopInfoViewController.h"
#import "UserManager.h"
#import "LogViewController.h"
#import "THActivityView.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView* _table;
    ShopInfoData* _shopData;
}
@property(nonatomic,weak)THActivityView* errView;
@end

@implementation RootViewController
@synthesize errView;
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


-(void)viewDidAppear:(BOOL)animated
{
    [self checkUserLogState];
    [self netShopInfoFromNet];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //    _table
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];

    
    
//    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(registeUserAccount)];
//    self.navigationItem.rightBarButtonItem = rightBar;
//    
    
    // Do any additional setup after loading the view.
}


-(void)registeUserAccount
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex==buttonIndex) {
        return;
    }
    __weak RootViewController* wSelf = self;
    THActivityView* loadView = [[THActivityView alloc]initViewOnWindow];
    [loadView loadViewAddOnWindow];
    UserManager* manager = [UserManager shareUserManager];
    [manager removeUserAccountWithBk:^(BOOL success, NSError *err) {
        if (success) {
            [wSelf showLogView];
        }
        else
        {
           THActivityView* alert = [[THActivityView alloc]initWithString:@"退出失败!"];
            [alert show];
        }
        [loadView removeFromSuperview];
    }];
}


-(void)showLogView
{
    LogViewController* log = [self.storyboard instantiateViewControllerWithIdentifier:@"LogViewController"];
    [self presentViewController:log animated:YES completion:^{}];
}


-(void)netShopInfoFromNet
{
    __weak RootViewController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getShopInfoWitbBk:^(ShopInfoData* backDic, NSError *error) {
        
//        防止多次错误 时errView重叠
        [wSelf.errView removeFromSuperview];
        if (backDic) {
            _shopData =backDic;
            [_table reloadData];
        }
        else{
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            wSelf.errView = loadView;
            [loadView setErrorBk:^{
                [wSelf netShopInfoFromNet];
            }];
        }
    }];
    [request startAsynchronous];

}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
      return @"店铺";
    }
    else if (section==1)
    {
      return @"商品";
    } else if (section==2)
    {
      return @"订单";
    }
    else
    {
        return  nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 1;
    }
    return 2;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString* str = @"ids";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        UILabel* label = [[UILabel alloc]init];
        cell.accessoryView = label;
        
        cell.textLabel.font  = [UIFont systemFontOfSize:15];
    }
    
    UILabel* accessLabel = (UILabel*)cell.accessoryView;
    UIImage* titleImage = nil;
    NSString* titleStr = nil;
    if (indexPath.section==0)
    {
    
        if (indexPath.row==0)
        {
            titleImage = [UIImage imageNamed:@"shopInfoIcon"];
            titleStr = [NSString stringWithFormat:@"%@(%@)",_shopData.shopName?_shopData.shopName:@"",_shopData.shopStatue?@"营业中":@"打烊"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            accessLabel.text = [NSString stringWithFormat:@"版本号:%@",VERSION];
            accessLabel.font = [UIFont systemFontOfSize:15];
            accessLabel.textColor = [UIColor lightGrayColor];
        }
        else
        {
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            titleImage = [UIImage imageNamed:@"shopInfo"];
            titleStr = _shopData.shopAddress;
        }
    }
    else if (indexPath.section==1)
    {
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row)
        {
             titleImage = [UIImage imageNamed:@"shopCountProduct"];
            titleStr = @"商品总数";
            accessLabel.text = _shopData.countProducts;
        }
        else
        {
             titleImage = [UIImage imageNamed:@"shopCountCategory"];
            titleStr = @"商品分类总数";
            accessLabel.text = _shopData.countCategory;
        }

    }
    else if(indexPath.section==2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row)
        {
             titleImage = [UIImage imageNamed:@"shopCountOrder"];
            titleStr = @"订单总数";
            accessLabel.text = _shopData.countOrder;
        }
        else
        {
             titleImage = [UIImage imageNamed:@"shopTotalMoney"];
            titleStr = @"订单总收入";
            accessLabel.text = _shopData.totalMoney;

        }

    }
    else
    {
    
        titleStr = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    
    cell.imageView.image = titleImage;
    cell.textLabel.text = titleStr;
    [accessLabel sizeToFit];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1&&indexPath.section==0) {
        ShopInfoViewController * shopInfo = [[ShopInfoViewController alloc]initWithShopInfoData:_shopData];
        shopInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopInfo animated:YES]; 
    }
    else if (indexPath.section==3)
    {
        [self registeUserAccount];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
