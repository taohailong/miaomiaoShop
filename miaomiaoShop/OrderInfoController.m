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

    [self setExtraCellLineHidden:_table];
    // Do any additional setup after loading the view.
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
