//
//  OrderListViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderListViewController.h"
#import "NetWorkRequest.h"
#import "OrderData.h"
#import "THActivityView.h"
#import "OrderListCell.h"
#import "LastViewOnTable.h"
#import "EGORefreshTableHeaderView.h"
#import "OrderInfoController.h"
#import "TSegmentedControl.h"
#import "OrderListHeadView.h"
//#import "OrderHeadCell.h"
#import "OrderListBtCell.h"

@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,UIAlertViewDelegate>
{
    TSegmentedControl* _seg;
    UITableView* _table;
    __weak OrderData* _selectData;
    __weak THActivityView* _emptyWarnView;
    NSString* _currentStatue;
    NSMutableArray* _todayArr;
    NSMutableArray* _notTodayArr;
    
    EGORefreshTableHeaderView* refreshView;
}
@end

@implementation OrderListViewController

-(void)setTabBarBadge:(NSString*)str
{
    UITabBarItem* item = self.tabBarController.tabBar.items[2];
    item.badgeValue = str;

//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

-(void)viewDidAppear:(BOOL)animated
{
   }

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _seg = [[TSegmentedControl alloc]initWithSectionTitles:@[@"新订单",@"配送中",@"已完成",@"已取消"]];
    [_seg setFont:DEFAULTFONT(15)];
    _seg.frame = CGRectMake(0, 64, SCREENWIDTH, 40);
    [self.view addSubview:_seg];
    _seg.selectionIndicatorColor = DEFAULTNAVCOLOR;
    [_seg addTarget:self action:@selector(segViewChange:) forControlEvents:UIControlEventValueChanged];
    
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_seg.frame), SCREENWIDTH, self.view.frame.size.height - CGRectGetMaxY(_seg.frame)) style:UITableViewStylePlain];
    [_table registerClass:[OrderListHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderListHeadView"];
    [_table registerClass:[OrderListCell class] forCellReuseIdentifier:@"OrderListCell"];
    [_table registerClass:[OrderListBtCell class] forCellReuseIdentifier:@"OrderListBtCell"];
    _table.dataSource = self;
    _table.delegate = self;
    [self.view addSubview:_table];
    [self addRefreshTableHead];
    [self segViewChange:_seg];
}

-(IBAction)segViewChange:(TSegmentedControl*)seg
{
    switch (seg.selectedIndex) {
        case 0:
            _currentStatue = @"0";
            break;
        case 1:
            _currentStatue = @"1";
            break;
        case 2:
            _currentStatue = @"4";
            break;
        case 3:
            _currentStatue = @"2";
            break;
        default:
            break;
    }
    [refreshView  egoRefreshScrollViewDataSourceDidBeginLoading:_table];
   [self getDataFromNetWithStatue:_currentStatue];
}

#pragma mark-NetApi

-(void)cannotDeliverOrder:(OrderData*)data
{
    THActivityView* fullView = [[THActivityView alloc]initViewOnWindow];
    [fullView loadViewAddOnWindow];
    
    __weak OrderListViewController* wself = self;
    __weak TSegmentedControl* wsegment = _seg;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];

     [request shopOrderCancelDeliverWithOrderID:data.orderNu WithBk:^(id backDic, NetWorkStatus status) {
            
        [fullView removeFromSuperview];
            
        if (status == NetWorkStatusSuccess) {
            THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功！"];
            [showStr show];
            [wself segViewChange:wsegment];
        }
        else
        {
            THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败！"];
            [showStr show];
        }
            
    }];
    [request startAsynchronous];
    
}


-(void)comfirmDeliverOrder:(OrderData*)data
{
    THActivityView* fullView = [[THActivityView alloc]initViewOnWindow];
    [fullView loadViewAddOnWindow];
    
    __weak OrderListViewController* wself = self;
     __weak TSegmentedControl* wsegment = _seg;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopOrderConfirmDeliverWithOrderID:data.orderNu WithBk:^(id backDic, NetWorkStatus status) {
            
        [fullView removeFromSuperview];
        
        if (status==NetWorkStatusSuccess) {
            
            THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功！"];
            [showStr show];
            [wself segViewChange:wsegment];
        }
        else
        {
            THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败！"];
            [showStr show];
        }
            
    }];
    [request startAsynchronous];

}


-(void)getDataFromNetWithStatue:(NSString*)statue
{

    THActivityView* loadView = [[THActivityView alloc]initFullViewTransparentWithSuperView:self.view];
    __weak OrderListViewController* wSelf = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req shopGetOrderWithStatue:@"2" WithIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status == NetWorkStatusErrorCanntConnect) {
            THActivityView* alert = [[THActivityView alloc]initWithString:@"网络连接失败！"];
            [alert show];
            [wSelf refreshTableOver];
            return ;
        }

        if (status == NetWorkStatusSuccess) {
            _notTodayArr = backDic[1];
            _todayArr = backDic[0];
//            _todayArr = [_notTodayArr mutableCopy];
            [_table reloadData];
            [wSelf addLoadMoreViewWithCount:_todayArr.count+_notTodayArr.count];
        }
         [wSelf refreshTableOver];
    }];
    [req startAsynchronous];
}

-(void)loadMoreData
{
    __weak OrderListViewController* wSelf = self;
    THActivityView* loadView = [[THActivityView alloc]initFullViewTransparentWithSuperView:self.view];
    
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req shopGetOrderWithStatue:_currentStatue WithIndex:_todayArr.count+ _notTodayArr.count+1 WithBk:^(id backDic, NetWorkStatus status) {
    
         [loadView removeFromSuperview];
        if (status == NetWorkStatusSuccess) {
            
            NSArray* notTodayArr = backDic[1];
            NSArray* todayArr = backDic[0];
            [_todayArr addObjectsFromArray:todayArr];
            [_notTodayArr addObjectsFromArray:notTodayArr];
            [_table reloadData];
            [wSelf addLoadMoreViewWithCount: todayArr.count+ notTodayArr.count];
        }
        
    }];
    [req startAsynchronous];

}

-(void)addLoadMoreViewWithCount:(int)count
{

    if (count<20) {
        _table.tableFooterView = nil;
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }
}

-(void)refreshTableOver
{
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_table];
}

-(void)performOrderConfirmAction:(OrderBtSelect)type
{
    if (type == OrderBtFirst) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认要配送吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认无法配送吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 0;
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex==buttonIndex) {
        return;
    }
    if (alertView.tag == 1) {
        [self comfirmDeliverOrder:_selectData];
    }
    else
    {
        [self cannotDeliverOrder:_selectData];
    }
}



#pragma mark---------------Refresh------------------

-(void)addRefreshTableHead
{
    
    // 加入refreshView;
    CGRect refreshRect = CGRectMake(0.0f,
                                    0.0f-_table.bounds.size.height,
                                    _table.bounds.size.width,
                                    _table.bounds.size.height);
    
    refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:refreshRect];
    refreshView.delegate = self;
    [_table addSubview:refreshView];
    /* 刷新一次数据 */
    [refreshView refreshLastUpdatedDate];
    
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
//    if (isLoading) {
//        return;
//    }
    /* 开始更新代码放在这里 */
    [self getDataFromNetWithStatue:_currentStatue];
    
    /* 实现更新代码 */
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshView egoRefreshScrollViewDidScroll:scrollView];
}

//-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
//{
//    return _isLoading;
//}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_todayArr.count&&_notTodayArr.count) {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        if (_todayArr.count) {
            return _todayArr.count;
        }
        return _notTodayArr.count;
    }
    else
    {
        return _notTodayArr.count;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderData* data ;
    if (indexPath.section==0)
    {
        if (_todayArr.count) {
            data = _todayArr[indexPath.row] ;
        }
        else
        {
            data =  _notTodayArr[indexPath.row];
        }
    }
    else
    {
        data =  _notTodayArr[indexPath.row];
    }
    
    CGSize size = [data calculateAddressHeightWithFont:DEFAULTFONT(14) WithSize:CGSizeMake(1000, 1000)];
    
    if ([_currentStatue isEqualToString:@"0"]&&indexPath.section == 0)
    {
        if (size.width>SCREENWIDTH-80) {
            return 202;
        }
        return 185 ;
    }
    
    if (size.width>SCREENWIDTH-80) {
        return 150;
    }
    return 130;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView* headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderListHeadView"];
    headView.contentView.backgroundColor = FUNCTCOLOR(243, 243, 243);
   
    NSString* title = nil;
    if (section==0)
    {
        if (_todayArr.count) {
            title = @"今日订单" ;
        }
        else
        {
            title =  @"往日订单";
        }
        
    }
    else
    {
        title =  @"往日订单";
    }
    
    headView.textLabel.text = title;
    return headView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderData* data ;
    if (indexPath.section==0)
    {
        if (_todayArr.count) {
             data = _todayArr[indexPath.row] ;
        }
        else
        {
           data =  _notTodayArr[indexPath.row];
        }
    }
    else
    {
        data =  _notTodayArr[indexPath.row];
    }
    
    if (indexPath.section == 0&& [_currentStatue isEqualToString:@"0"])
    {
        __weak OrderListViewController* wself = self;
        _selectData = data;
        OrderListBtCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListBtCell"];
        [cell setOrderBk:^(OrderBtSelect status) {
            [wself performOrderConfirmAction:status];
        }];
        [cell setAddress:data.orderAddress];
        [cell setTephone:data.telPhone];
        [cell setOrderTime:data.orderTime];
        [cell setOrderStatus:data.orderStatue];
        [cell setTotalNu:[NSString stringWithFormat:@"%d",data.countOfProduct]];
        [cell setTotalMoney:data.totalMoney];

        return cell;
    }
    
    else
    {
        OrderListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
        [cell setAddress:data.orderAddress];
        [cell setTephone:data.telPhone];
        [cell setOrderTime:data.orderTime];
        [cell setOrderStatus:data.orderStatue];
        [cell setTotalNu:[NSString stringWithFormat:@"%d",data.countOfProduct]];
        [cell setTotalMoney:data.totalMoney];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderData* data ;
    if (indexPath.section==0)
    {
        if (_todayArr.count) {
            data = _todayArr[indexPath.row] ;
        }
        else
        {
            data =  _notTodayArr[indexPath.row];
        }
    }
    else
    {
        data =  _notTodayArr[indexPath.row];
    }

    OrderInfoController* orderInfo = [[OrderInfoController alloc]initWithOrderData: data];
    orderInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderInfo animated:YES];
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
