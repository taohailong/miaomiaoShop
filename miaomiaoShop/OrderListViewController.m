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

@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    IBOutlet UISegmentedControl* _seg;
    IBOutlet UITableView* _table;
    
    NSString* _currentStatue;
    NSMutableArray* _todayArr;
    NSMutableArray* _notTodayArr;
//    BOOL _isLoading;
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
    [self segViewChange:_seg];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _table.dataSource = self;
    _table.delegate = self;
    [self addRefreshTableHead];
   
}

-(IBAction)segViewChange:(UISegmentedControl*)seg
{
    switch (seg.selectedSegmentIndex) {
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


-(void)getDataFromNetWithStatue:(NSString*)statue
{

    THActivityView* loadView = [[THActivityView alloc]initFullViewTransparentWithSuperView:self.view];
    __weak OrderListViewController* wSelf = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req shopGetOrderWithStatue:statue WithIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status == NetWorkStatusErrorCanntConnect) {
            THActivityView* alert = [[THActivityView alloc]initWithString:@"网络连接失败！"];
            [alert show];
            [wSelf refreshTableOver];
            return ;
        }

        if (backDic) {
            _notTodayArr = backDic[1];
            _todayArr = backDic[0];
            [_table reloadData];
            [wSelf addLoadMoreViewWithCount:_todayArr.count+_notTodayArr.count];
        }
        if ([statue isEqualToString:@"0"]) {
            [wSelf setTabBarBadge:nil];
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
//        UIView *view =[ [UIView alloc]init];
//        view.backgroundColor = [UIColor clearColor];
//        _table.tableFooterView = view;
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
    return 215;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    headView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:205.0/255.0 blue:95.0/255.0 alpha:1.0];
    UILabel* label = [[UILabel alloc]init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [headView addSubview:label];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    
    [headView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

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
    
    label.text = title;
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
    
    OrderListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"orderList"];
//    if (cell==nil) {
//        cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    NSLog(@"data.orderTime %@",data);
    [cell setTitleText:[NSString stringWithFormat:@"%@        共%d个 ¥%@",data.orderTime,data.countOfProduct ,data.totalMoney]];
    [cell setAddress:data.orderAddress];
    [cell setTephone:data.telPhone];
    [cell setPayWay:[data getPayMethod]];
    [cell setPayNu:data.orderNu];
    [cell setOrderStatue:data.orderStatue];
    [cell setOrderMessage:data.messageStr];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
