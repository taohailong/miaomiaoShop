//
//  ShopDailyDataController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderConfirmSummerControl.h"
#import "LastViewOnTable.h"
#import "BusinessCell.h"
#import "OrderConfirmOrNotListController.h"
#import "THActivityView.h"
#import "NetWorkRequest.h"
#import "OrderConfirmCell.h"
#import "OrderConfirmSeparateCell.h"
#import "OrderConfirmSummerHeadView.h"
@interface OrderConfirmSummerControl()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    BOOL _isLoading;
    NSMutableArray* _titleArr;
    NSInteger _currentIndex;
    NSMutableDictionary* _orderDic;
}
@end
@implementation OrderConfirmSummerControl

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"已结算订单";
    _titleArr = [[NSMutableArray alloc]init];
    _orderDic = [[NSMutableDictionary alloc]init];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.backgroundColor = FUNCTCOLOR(237, 237, 237);;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_table registerClass:[OrderConfirmSummerHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderConfirmSummerHeadView"];
    
    [_table registerClass:[OrderConfirmCell class] forCellReuseIdentifier:@"OrderConfirmCell"];
    [_table registerClass:[OrderConfirmSeparateCell class] forCellReuseIdentifier:@"OrderConfirmSeparateCell"];
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    _table.delegate = self;
    _table.dataSource = self;
    
    
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
    
    __weak OrderConfirmSummerControl* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderFromIndex:0 WithBk:^(NSDictionary* backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status == NetWorkStatusErrorCanntConnect) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            
            [loadView setErrorBk:^{
                [wSelf getOrderSummary];
            }];
            return ;
        }
        
        if (status == NetWorkStatusSuccess) {
            [wSelf fillDataToViewWith:backDic];
        }
        
    }];
    [request startAsynchronous];
}

-(void)fillDataToViewWith:(NSDictionary*)souceDic
{
    NSArray* arr = souceDic[@"data"][@"settlemets"];
    [self parseData:arr];
}


-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    
    __weak OrderConfirmSummerControl* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderFromIndex:_currentIndex  WithBk:^(NSDictionary* backDic, NetWorkStatus status) {
        
        if (status==NetWorkStatusSuccess) {
            [wSelf loadMoreDataAnalysis:backDic];
        }
    }];
    [request startAsynchronous];
}


-(void)loadMoreDataAnalysis:(NSDictionary*)souceDic
{
    _isLoading = NO;
    NSArray* arr = souceDic[@"data"][@"settlemets"];
    [self parseData:arr];
}


-(void)parseData:(NSArray*)arr
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (NSDictionary * dic in arr)
        {
            _currentIndex++;
            NSString* month = dic[@"month"];
            
            if (_orderDic[month] == nil)
            {
                NSMutableArray* arr = [[NSMutableArray alloc]init];
                [arr addObject:dic];
                
                NSString* totalMoney = [NSString stringWithFormat:@"%.1f",[dic[@"monthTotalPrice"] floatValue]/100];
                
                [_orderDic setObject:arr forKey:month];
                [_titleArr addObject:@{@"month":dic[@"month"],@"totalNu":dic[@"monthTotalOrder"],@"totalMoney":totalMoney}];
            }
            else
            {
                NSMutableArray* arr = _orderDic[month];
                [arr addObject:dic];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addLoadMoreViewWithCount:arr.count];
            [_table reloadData];
        });
    });
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderConfirmSummerHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderConfirmSummerHeadView"];
    NSDictionary* dic = _titleArr[section];
    
    [head  setFirstLabelText:[NSString stringWithFormat:@"%@月明细",dic[@"month"]]];
    [head setSecondLabelText:[NSString stringWithFormat:@"当月共计：%@单",dic[@"totalNu"]]];
    [head setThirdLabelText:[NSString stringWithFormat:@"¥%@",dic[@"totalMoney"]]];
    return head;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 95;
    }
    else
    {
       return 105;
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary* monthDic = _titleArr[section];
    NSArray* arr = _orderDic[monthDic[@"month"]];
    return arr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderConfirmCell* cell ;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OrderConfirmSeparateCell"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OrderConfirmCell"];
    }
    [cell setImageViewImageName:@"order_time"];
//    cell.separatorInset = UIEdgeInsetsZero;
    NSDictionary* monthDic = _titleArr[indexPath.section];
    NSArray* arr = _orderDic[monthDic[@"month"]];
    NSDictionary* temp = arr[indexPath.row];
    
    [cell setTitleLabelText:temp[@"date"]];
    
    NSString* secondStr = [NSString stringWithFormat:@"%@单",[temp[@"orderCount"] stringValue]];
    NSAttributedString* secondAtt = [self setFormateStrHead:@"在线支付订单数量：" withEndStr:secondStr withColor:FUNCTCOLOR(153, 153, 153)];
    [cell setSecondLAttribute:secondAtt];
    
    
    float money = [temp[@"orderPrice"] floatValue]/100;
    NSAttributedString* third = [self setFormateStrHead:@"在线支付订单金额：" withEndStr:[NSString stringWithFormat:@"¥%.2f",money] withColor:FUNCTCOLOR(153, 153, 153)];
    [cell setThirdLAttribute :third];
    
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
    if(h - offset.y-y <50 && _table.tableFooterView.frame.size.height>10)
    {
        [self loadMoreData];
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* monthDic = _titleArr[indexPath.section];
    NSArray* arr = _orderDic[monthDic[@"month"]];
    NSDictionary* temp = arr[indexPath.row];
    [self showDetailInfoViewWithDate:temp[@"date"] Type:@"settled"];
}

-(void)showDetailInfoViewWithDate:(NSString*)date Type:(NSString*)type
{
    OrderConfirmOrNotListController* buiness = [[OrderConfirmOrNotListController alloc]init];
    buiness.title = date;
    [buiness setOrdeDate:date];
    [buiness setOrderType:type];
    [self.navigationController pushViewController:buiness animated:YES];
}




-(NSAttributedString*)setFormateStrHead:(NSString*)head withEndStr:(NSString*)endStr withColor:(UIColor*)color
{
    NSMutableAttributedString* status = [[NSMutableAttributedString alloc]initWithString:head attributes:@{NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102),NSFontAttributeName:DEFAULTFONT(14)}];
    NSAttributedString* statusStr = [[NSAttributedString alloc]initWithString:endStr attributes:@{NSForegroundColorAttributeName:color}];
    [status appendAttributedString:statusStr];
    
    return status;
}


@end
