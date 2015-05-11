//
//  OrderInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderInfoController.h"
#import "OrderInfoSecondCell.h"
#import "OrderInfoFirstCell.h"
#import "ShopProductData.h"
#import "THActivityView.h"
#import "NetWorkRequest.h"
@interface OrderInfoController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    OrderData* _orderData;
}

@end

@implementation OrderInfoController


-(id)initWithOrderData:(OrderData *)data
{
    self = [super init];
    _orderData = data;
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    _table
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];

    if ([_orderData.orderStatue isEqualToString:@"订单确认"]) {
        [self setTableViewFootWithConfirmDeliver:YES];
    }
    else
    {
      [self setTableViewFootWithConfirmDeliver:NO];
    }
    // Do any additional setup after loading the view.
}

-(void)setTableViewFootWithConfirmDeliver:(BOOL)flag
{
    if(flag)
    {
        _table.tableFooterView = [self creatOrderConfirmFootView];
    }
    else
    {
        _table.tableFooterView = [self setExtraCellLineHidden];
    }
   
}

-(UIView*)creatOrderConfirmFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    
    UIButton* cancelBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBt.tag = 0;
    cancelBt.layer.borderWidth = 1;
    cancelBt.layer.borderColor= DEFAULTNAVCOLOR.CGColor;
    cancelBt.layer.masksToBounds = YES;
    cancelBt.layer.cornerRadius = 6;
    
    
    [cancelBt setTitle:@"取消配送" forState:UIControlStateNormal];
    cancelBt.translatesAutoresizingMaskIntoConstraints = NO;
    [footView addSubview:cancelBt];
    [cancelBt addTarget:self action:@selector(performOrderConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cancelBt(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cancelBt)]];
    
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelBt(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cancelBt)]];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:cancelBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:cancelBt attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    
    UIButton * confirmBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBt.tag = 1;
    confirmBt.translatesAutoresizingMaskIntoConstraints  = NO;
    confirmBt.layer.borderWidth = 1;
    confirmBt.layer.borderColor= DEFAULTNAVCOLOR.CGColor;
    confirmBt.layer.masksToBounds = YES;
    confirmBt.layer.cornerRadius = 6;
    
    [confirmBt setTitle:@"确认配送" forState:UIControlStateNormal];
    [footView addSubview:confirmBt];
    [confirmBt addTarget:self action:@selector(performOrderConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[confirmBt(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(confirmBt)]];
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[confirmBt(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(confirmBt)]];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:confirmBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:confirmBt attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterX multiplier:.5 constant:0]];
    
    return footView;
    
}


-(void)performOrderConfirmAction:(UIButton*)bu
{
    if (bu.tag) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认要配送吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = bu.tag;
        [alert show];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认无法配送吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = bu.tag;
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex==buttonIndex) {
        return;
    }
    
    THActivityView* fullView = [[THActivityView alloc]initViewOnWindow];
    [fullView loadViewAddOnWindow];
    
    __weak OrderInfoController* wself = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    if (alertView.tag) {
        
        [request shopOrderConfirmDeliverWithOrderID:_orderData.orderNu WithBk:^(id backDic, NSError *error) {
            
            [fullView removeFromSuperview];
            if (backDic) {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功！"];
                [showStr show];
                [wself manualBack];
            }
            else
            {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败！"];
                [showStr show];
            }
            
        }];
        [request startAsynchronous];
    }
    else
    {
        [request shopOrderCancelDeliverWithOrderID:_orderData.orderNu WithBk:^(id backDic, NSError *error) {
            [fullView removeFromSuperview];
            
            if (backDic) {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功！"];
                [showStr show];
                [wself manualBack];
            }
            else
            {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败！"];
                [showStr show];
            }
            
        }];
        [request startAsynchronous];
        
    }
}



- (UIView*)setExtraCellLineHidden
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return  view;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"订单时间：%@",_orderData.orderTime];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+_orderData.productArr.count;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
          return 110;
    }
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        OrderInfoFirstCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell==nil) {
            cell = [[OrderInfoFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        [cell setTelPhoneText:_orderData.telPhone];
        [cell setAddressText:_orderData.orderAddress];
        [cell setPayWayText:[_orderData getPayMethod]];
        [cell setOrderMessage:_orderData.messageStr];
        return cell;

    }
    else if (indexPath.row == 1+_orderData.productArr.count)
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"共%d件 ¥ %@",_orderData.countOfProduct,_orderData.totalMoney];
        return cell;
    }
    else
    {
        
        ShopProductData* product = _orderData.productArr[indexPath.row-1];
        OrderInfoSecondCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell==nil) {
            cell = [[OrderInfoSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        
        [cell setTitleText:product.pName];
        [cell setProductUrl:product.pUrl];
        [cell setTotalMoney:[NSString stringWithFormat:@"%d件 X ¥ %.1f",product.count,product.price]];
        return cell;

        
    }
}



-(void)manualBack
{
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
