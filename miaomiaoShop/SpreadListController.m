//
//  SpreadListController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "SpreadListController.h"
#import "SpreadData.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "LastViewOnTable.h"
#import "SpreadListCell.h"
#import "SpreadInfoController.h"

@interface SpreadListController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    NSMutableDictionary* _dataDic;
    NSArray* _monthArr;
    int _dataCount;
    BOOL _isLoading;
}
@end
@implementation SpreadListController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"推广信息";
    
    _dataDic = [[NSMutableDictionary alloc]init];
    _monthArr = [[NSMutableArray alloc]init];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[SpreadListCell class] forCellReuseIdentifier:@"SpreadListCell"];
    [_table registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"table_headView"];
    
    [self getSpreadSummary];
}


-(void)getSpreadSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak SpreadListController* wSelf = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getSpreadSummaryDataWithIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status!=NetWorkStatusSuccess) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            
            [loadView setErrorBk:^{
                [wSelf getSpreadSummary];
            }];
            return ;
        }
    
        [wSelf fillDataToViewWith:backDic];
    }];
    [request startAsynchronous];
}


-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    
    __weak SpreadListController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getSpreadSummaryDataWithIndex:_dataCount+1 WithBk:^(id backDic, NetWorkStatus status) {
        
        if (status==NetWorkStatusSuccess) {
            [wSelf fillDataToViewWith:backDic];
        }
        else
        {
            [wSelf dataFetchError];
        }
    }];
    [request startAsynchronous];
}

-(void)dataFetchError
{
    _isLoading = NO;
}

-(void)fillDataToViewWith:(NSDictionary*)souceDic
{
    int count = 0;
    for (NSString* key in souceDic.allKeys) {
        
        NSArray* arr = souceDic[key];
        _dataCount += arr.count;
        count += arr.count;
        NSMutableArray* keyArr = _dataDic[key];
        if (keyArr==nil) {
            [_dataDic setObject:arr forKey:key];
        }
        else
        {
            [keyArr addObjectsFromArray:arr];
        }
    }

    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
    _monthArr = [_dataDic.allKeys sortedArrayUsingDescriptors:@[sd1]];
    
    [self addLoadMoreViewWithCount:count];
    [_table reloadData];
}




//-(void)loadMoreDataAnalysis:(NSDictionary*)souceDic
//{
//    _isLoading = NO;
//    NSArray* arr = souceDic[@"data"][@"summary"][@"settlemets"];
//    [self addLoadMoreViewWithCount:arr.count];
//    if (arr)
//    {
//        [_settleOrderS addObjectsFromArray:arr];
//    }
//    [_table reloadData];
//}


-(void)addLoadMoreViewWithCount:(int)count
{
    if (count<30) {
        _table.tableFooterView = [[UIView alloc]init];
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }
}


#pragma mark----tableviewDelegate----------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView* headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"table_headView"];
    headView.backgroundColor = [UIColor lightGrayColor];
    headView.textLabel.text = _monthArr[section];
    return headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _monthArr.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = _monthArr[section];
    NSArray* arr = _dataDic[key];
    return arr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpreadListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SpreadListCell"];
    [cell setLayout];
    
    NSString*key = _monthArr[indexPath.section];
    SpreadData* temp = _dataDic[key][indexPath.row];
    
    UILabel* first = [cell getFirstLabel];
    first.text = temp.date;
    first.textColor = DEFAULTNAVCOLOR;
    UILabel* second = [cell getSecondLabel];
    second.text = [NSString stringWithFormat:@"微信用户推广数量：%d",temp.wxUserNu];
    
    UILabel* third = [cell getThirdLabel];
    third.text = [NSString stringWithFormat:@"app用户推广数量：%d",temp.appUserNu];
    
    UILabel* fourth = [cell getFourthLabel];
    fourth.text = [NSString stringWithFormat:@"用户推广总数量：%d",temp.totalUserNu];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString*key = _monthArr[indexPath.section];
    SpreadData* temp = _dataDic[key][indexPath.row];

    SpreadInfoController* infoController = [[SpreadInfoController alloc]initWithDate:temp.date];
    [self.navigationController pushViewController:infoController animated:YES];
//    NSDictionary* temp = _settleOrderS[indexPath.row];
//    [self showDetailInfoViewWithDate:temp[@"date"] Type:@"settled"];
}

@end
