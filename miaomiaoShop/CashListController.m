//
//  CashListController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/7.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CashListController.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "LastViewOnTable.h"
#import "OrderConfirmSummerHeadView.h"
#import "CashDebitData.h"
#import "CashListCell.h"
@interface CashListController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    NSMutableDictionary* _dataDic;
    NSMutableArray* _monthArr;
    int _dataCount;
    BOOL _isLoading;
}
@end

@implementation CashListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现明细";
    _dataDic = [[NSMutableDictionary alloc]init];
    _monthArr = [[NSMutableArray alloc]init];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    _table.backgroundColor = FUNCTCOLOR(237, 237, 237);
    [_table setSeparatorColor:FUNCTCOLOR(221, 221, 221)];
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    if ([_table respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_table setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_table setLayoutMargins:UIEdgeInsetsZero];
    }

    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[OrderConfirmSummerHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderConfirmSummerHeadView"];
    [_table registerClass:[CashListCell class] forCellReuseIdentifier:@"CashListCell"];
    
    [self getCashList];

}

-(void)getCashList
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak CashListController* wSelf = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getCashSummaryListWithIndex:0 WithBk:^(id backDic, NetWorkStatus status) {

        [loadView removeFromSuperview];
        if (status==NetWorkStatusErrorCanntConnect) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            
            [loadView setErrorBk:^{
                [wSelf getCashList];
            }];
            return ;
        }
        else if (status == NetWorkStatusSuccess)
        {
            [wSelf fillDataToViewWith:backDic];
        }
        
    }];
    [request startAsynchronous];
}


-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    
    __weak CashListController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getCashSummaryListWithIndex:_dataCount+1 WithBk:^(id backDic, NetWorkStatus status) {
        
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

-(void)fillDataToViewWith:(NSArray*)arrDic
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (CashDebitData * temp in arrDic)
        {
            _dataCount++;
            
            NSString* month = temp.month;
            if (_dataDic[month] == nil)
            {
                NSMutableArray* arr = [[NSMutableArray alloc]init];
                [arr addObject:temp];
                
                [_dataDic setObject:arr forKey:month];
                [_monthArr addObject:@{@"month":temp.month,@"totalNu":temp.outTimes,@"totalMoney":temp.monthMoneyOut}];
            }
            else
            {
                NSMutableArray* arr = _dataDic[month];
                [arr addObject:temp];
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addLoadMoreViewWithCount:arrDic.count];
            [_table reloadData];
        });
    });
    
}


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
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderConfirmSummerHeadView* headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderConfirmSummerHeadView"];
    
    NSDictionary* dic = _monthArr[section];
    
    [headView  setFirstLabelText:[NSString stringWithFormat:@"%@月明细",dic[@"month"]]];
    [headView setSecondLabelText:[NSString stringWithFormat:@"当月共计提现：%@单",dic[@"totalNu"]]];
    [headView setThirdLabelText:[NSString stringWithFormat:@"¥%@",dic[@"totalMoney"]]];
    
    return headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _monthArr.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary* key = _monthArr[section];
    NSArray* arr = _dataDic[key[@"month"]];
    return arr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CashListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CashListCell"];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    NSDictionary*key = _monthArr[indexPath.section];
    CashDebitData* temp = _dataDic[key[@"month"]][indexPath.row];
    
    UILabel* first = [cell getFirstLabel];
    first.font = DEFAULTFONT(14);
    first.textColor = FUNCTCOLOR(153, 153, 153);
    first.text = temp.debitTime;
    
    
    
    UILabel* second = [cell getSecondLabel];
    second.textColor = FUNCTCOLOR(102, 102, 102);
    second.font = DEFAULTFONT(14);
    second.text = [NSString stringWithFormat:@"提现金额：¥%@",temp.debitMoney];
    
    
    
    UILabel* third = [cell getThirdLabel];
    
    third.font = DEFAULTFONT(14);
    
    if (temp.debitStatus == CashComplete) {
        third.textColor = FUNCTCOLOR(102,102,102);
        third.text = @"打款完成";
    }
    else
    {
        third.textColor = DEFAULTNAVCOLOR;
        third.text = @"打款中";
    }
    
    
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
    if(h - offset.y-y <50 &&_table.tableFooterView.frame.size.height>10)
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
