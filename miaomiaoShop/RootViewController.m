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

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    ShopInfoData* _shopData;
}
@end

@implementation RootViewController

-(void)viewDidAppear:(BOOL)animated
{
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

    // Do any additional setup after loading the view.
}

-(void)netShopInfoFromNet
{
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getShopInfoWitbBk:^(ShopInfoData* backDic, NSError *error) {
        if (backDic) {
            _shopData =backDic;
            [_table reloadData];
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
    }
    else
    {
      return @"订单";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
            titleStr = _shopData.shopName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    else
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
    cell.imageView.image = titleImage;
    cell.textLabel.text = titleStr;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopInfoViewController * shopInfo = [[ShopInfoViewController alloc]initWithShopInfoData:_shopData];
    shopInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopInfo animated:YES];
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
