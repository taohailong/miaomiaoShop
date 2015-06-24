//
//  SpreadInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "SpreadInfoController.h"
#import "SpreadData.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "LastViewOnTable.h"
#import "BusinessSpreadSummarCell.h"

@interface SpreadInfoController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    NSMutableArray* _dataArr;
    BOOL _isLoading;
    NSString* _currentDate;
}
@end
@implementation SpreadInfoController

-(id)initWithDate:(NSString*)date
{
    self = [super init];
    _currentDate = date;
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"推广订单";
    
    _dataArr = [[NSMutableArray alloc]init];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[BusinessSpreadSummarCell class] forCellReuseIdentifier:@"BusinessSpreadSummarCell"];
    [_table registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"table_headView"];
    
    [self getSpreadSummary];
}


-(void)getSpreadSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak SpreadInfoController* wSelf = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getSpreadInfoWithDate:_currentDate WithIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        
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
    
    __weak SpreadInfoController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getSpreadInfoWithDate:_currentDate WithIndex:_dataArr.count WithBk:^(id backDic, NetWorkStatus status) {
        
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

-(void)fillDataToViewWith:(NSArray*)souceDic
{
    _isLoading = NO;
    
    if (souceDic) {
      [_dataArr addObjectsFromArray:souceDic];
    }

    [self addLoadMoreViewWithCount:souceDic.count];
    [_table reloadData];
}




-(void)addLoadMoreViewWithCount:(int)count
{
    if (count<30) {
        _table.tableFooterView = [[UIView alloc]init];;
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }
}


#pragma mark----tableviewDelegate----------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessSpreadSummarCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessSpreadSummarCell"];
    [cell setLayout];
    cell.accessoryType = UITableViewCellAccessoryNone;
    SpreadData* temp = _dataArr[indexPath.row];
    
    UILabel* first = [cell getFirstLabel];
    first.text = [NSString stringWithFormat:@"邀请码验证时间：%@",temp.codeTime];
    
    UILabel* second = [cell getSecondLabel];
    second.text = [NSString stringWithFormat:@"邀请码验证平台：%@",temp.platform];
    
    UILabel* third = [cell getThirdLabel];
    third.text = [NSString stringWithFormat:@"订单确认收货时间：%@",temp.confirmTime];
    
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
    
    if(h - offset.y-y <50 && _table.tableFooterView)
    {
        [self loadMoreData];
    }
}

@end
