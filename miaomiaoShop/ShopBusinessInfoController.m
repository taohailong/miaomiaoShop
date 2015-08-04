//
//  ShopBusinessInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopBusinessInfoController.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "BusinessInfoCell.h"
#import "OrderData.h"
#import "OrderInfoController.h"
#import "LastViewOnTable.h"
@interface ShopBusinessInfoController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    BOOL _isLoading;
    NSString* _orderDate;
    NSString* _orderType;
    UITableView* _table;
    NSMutableArray*_orderArr;
    
}
@end

@implementation ShopBusinessInfoController

-(void)setOrdeDate:(NSString*)date
{
    _orderDate = date;
}

-(void)setOrderType:(NSString*)type
{
    _orderType = type;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
   
    [self getOrderList];
    // Do any additional setup after loading the view.
}


-(void)getOrderList
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    __weak ShopBusinessInfoController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getBusinessOrderInfoWithDate:_orderDate WithType:_orderType withIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        [loadView removeFromSuperview];
        
        if (status == NetWorkStatusSuccess) {
            [wSelf reloadTableWithData:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
            
        }

        else
        {
            THActivityView* loadView = [[THActivityView alloc]initWithString:backDic];
            [loadView show];
        }
        
    }];
    [request startAsynchronous];
}


-(void)loadMoreData
{
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    __weak ShopBusinessInfoController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getBusinessOrderInfoWithDate:_orderDate WithType:_orderType withIndex:_orderArr.count+1 WithBk:^(id backDic, NetWorkStatus status) {
        
        if (status==NetWorkStatusSuccess) {
            [wSelf addDataArr:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
            
        }

        else
        {
            THActivityView* showStr = [[THActivityView alloc]initWithString:backDic];
            [showStr show];
        }

    }];
    [request startAsynchronous];

}
-(void)reloadTableWithData:(NSMutableArray*)arr
{
    _orderArr = arr;
    [_table reloadData];
    [self setTableViewFootWithDataCount:_orderArr.count];
}

-(void)setTableViewFootWithDataCount:(int)count
{
    if (count<20)
    {
        _table.tableFooterView = [self setExtraCellLineHidden];
    
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }


}

-(void)addDataArr:(NSMutableArray*)da
{
    _isLoading = NO;
    [_orderArr addObjectsFromArray:da];
    [_table reloadData];
    [self setTableViewFootWithDataCount:_orderArr.count];
 }


-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y =  bounds.size.height - inset.bottom;
    float h = size.height;
    
    
    NSLog(@"h-offset is %lf",h-offset.y-y);
    if(h - offset.y-y <50 && _table.tableFooterView)
    {
        [self loadMoreData];
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString* str = @"cell";
    BusinessInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[BusinessInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    OrderData* data = _orderArr[indexPath.row];
    
    [cell setTitleLabelText:[NSString stringWithFormat:@"%@     ¥ %@",data.orderTime,data.totalMoney]];
    [cell setOrderNu:[NSString stringWithFormat:@"订单编号：%@",data.orderNu]];
    [cell setTakeOverTimeText:[NSString stringWithFormat:@"收货时间：%@",data.orderTakeOver]];
    if ([data.orderStatue isEqualToString:@"配送中"])
    {
        [cell setDeadLineTime:[NSString stringWithFormat:@"最晚收货时间：%@",data.deadTime]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   OrderData* data = _orderArr[indexPath.row];
    OrderInfoController* orderInfo = [[OrderInfoController alloc]initWithOrderData: data];
    
    [self.navigationController pushViewController:orderInfo animated:YES];

}

- (UIView*)setExtraCellLineHidden
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
     return  view;
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
