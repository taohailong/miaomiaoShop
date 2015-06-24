//
//  ShopDailyDataController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopDailyDataController.h"
#import "LastViewOnTable.h"
#import "BusinessCell.h"
#import "ShopBusinessInfoController.h"
#import "THActivityView.h"
#import "NetWorkRequest.h"

@interface ShopDailyDataController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    BOOL _isLoading;
    NSMutableArray* _settleOrderS;
}
@end
@implementation ShopDailyDataController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"已结算在线订单";
    _settleOrderS = [[NSMutableArray alloc]init];
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[BusinessCell class] forCellReuseIdentifier:@"BusinessCell"];
    
    
    if ([_table respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_table setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_table setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self getOrderSummary];
}


-(void)getOrderSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak ShopDailyDataController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderFromIndex:0 WithBk:^(NSDictionary* backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status!=NetWorkStatusSuccess) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            
            [loadView setErrorBk:^{
                [wSelf getOrderSummary];
            }];
            return ;
        }
        
        if (backDic) {
            [wSelf fillDataToViewWith:backDic];
        }
        
    }];
    [request startAsynchronous];
}

-(void)fillDataToViewWith:(NSDictionary*)souceDic
{
    [_settleOrderS removeAllObjects];
    
    NSArray* arr = souceDic[@"data"][@"settlemets"];
    [_settleOrderS addObjectsFromArray:arr];
    [self addLoadMoreViewWithCount:arr.count];
    [_table reloadData];
}


-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    
    __weak ShopDailyDataController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderFromIndex:_settleOrderS.count  WithBk:^(NSDictionary* backDic, NetWorkStatus status) {
        
        if (status==NetWorkStatusSuccess) {
            [wSelf loadMoreDataAnalysis:backDic];
        }
    }];
    [request startAsynchronous];
}


-(void)loadMoreDataAnalysis:(NSDictionary*)souceDic
{
    _isLoading = NO;
    NSArray* arr = souceDic[@"data"][@"summary"][@"settlemets"];
    [self addLoadMoreViewWithCount:arr.count];
    if (arr)
    {
        [_settleOrderS addObjectsFromArray:arr];
    }
    [_table reloadData];
}


-(void)addLoadMoreViewWithCount:(int)count
{
    if (count<7) {
        _table.tableFooterView = nil;
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }
}


#pragma mark----tableviewDelegate----------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _settleOrderS.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.separatorInset = UIEdgeInsetsZero;
    NSDictionary* temp = _settleOrderS[indexPath.row];
    [cell setTitleLabelText:temp[@"date"]];
    [cell setCountOrderStr:[NSString stringWithFormat:@"%@单",[temp[@"orderCount"] stringValue]]];
    float money = [temp[@"orderPrice"] floatValue]/100;
    [cell setTotalMoney:[NSString stringWithFormat:@"¥%.2f",money]];
    
    return cell;
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




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* temp = _settleOrderS[indexPath.row];
    [self showDetailInfoViewWithDate:temp[@"date"] Type:@"settled"];
}

-(void)showDetailInfoViewWithDate:(NSString*)date Type:(NSString*)type
{
    ShopBusinessInfoController* buiness = [[ShopBusinessInfoController alloc]init];
        buiness.title = @"已确认收货订单";
    [buiness setOrdeDate:date];
    [buiness setOrderType:type];
    [self.navigationController pushViewController:buiness animated:YES];
}


@end
