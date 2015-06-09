//
//  ShopBusinessController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopBusinessController.h"
#import "NetWorkRequest.h"
#import "BusinessCell.h"
#import "THActivityView.h"
#import "ShopBusinessInfoController.h"
#import "LastViewOnTable.h"
#import "CashDebitController.h"
@interface ShopBusinessController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* _table;
    IBOutlet UILabel* _countOrderL;
    IBOutlet UILabel* _totalMoney;
    IBOutlet UIView* _backView;
    
    IBOutlet UILabel* _topLabel;
    IBOutlet UIView* _topBackView;
    
    float _currentCash;
    BOOL _canTake;
    BOOL _isLoading;
    NSMutableArray* _settleOrderS;
    
    
//    {
//        "date": "2015-05-04",
//        "orderCount": 0,
//        "orderPrice": 0,
//        "payStatus": 0
//    },
    
    
    NSDictionary* _unSettleDic;
//    {
//        "date": "",
//        "orderCount": 1,
//        "orderPrice": 1,
//        "payStatus": 0
//    },
}
@property(nonatomic,weak)THActivityView* errorView;
@end

@implementation ShopBusinessController
@synthesize errorView;

-(void)viewDidAppear:(BOOL)animated
{
   [self getOrderSummary];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _settleOrderS = [[NSMutableArray alloc]init];
    _topLabel.textColor = DEFAULTNAVCOLOR;
    _table.delegate = self;
    _table.dataSource = self;
//    _table.separatorColor =  
    if ([_table respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [_table setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_table setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewToInfo)];
    [_backView addGestureRecognizer:tap];
    
    UITapGestureRecognizer* tapTop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewToCashTrade)];
    [_topBackView addGestureRecognizer:tapTop];
    
    // Do any additional setup after loading the view.
}


-(void)tapViewToCashTrade
{
    CashDebitController* cashView = [[CashDebitController alloc]initWithCash:_currentCash];
    cashView.hidesBottomBarWhenPushed = YES;
    cashView.canTake = _canTake;
    [self.navigationController pushViewController:cashView animated:YES];

}

-(void)tapViewToInfo
{
    [self showDetailInfoViewWithDate:nil Type:@"nosettle"];
}


-(void)getOrderSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak ShopBusinessController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderSummaryFromIndex:0 WithBk:^(NSDictionary* backDic, NetWorkStatus status) {
        
        [wSelf.errorView removeFromSuperview];
        [loadView removeFromSuperview];
        if (status!=NetWorkStatusSuccess) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            wSelf.errorView = loadView;
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

-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    
    __weak ShopBusinessController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderSummaryFromIndex:_settleOrderS.count  WithBk:^(NSDictionary* backDic, NetWorkStatus status) {
    
        if (backDic) {
            [wSelf loadMoreDataAnalysis:backDic];
        }
    }];
    [request startAsynchronous];

}


-(void)loadMoreDataAnalysis:(NSDictionary*)souceDic
{
//    NSDictionary* dic = souceDic[@"data"][@"summary"][@"nosettlemet"];
//    _countOrderL.text = [NSString stringWithFormat:@"%d单",[dic[@"orderCount"] intValue]];
//    _totalMoney.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"orderPrice"] floatValue]/100];
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



-(void)fillDataToViewWith:(NSDictionary*)souceDic
{
    _canTake = [souceDic[@"data"][@"summary"][@"canTake"] boolValue];
    NSDictionary* dic = souceDic[@"data"][@"summary"][@"nosettlemet"];
    _countOrderL.text = [NSString stringWithFormat:@"%d单",[dic[@"orderCount"] intValue]];
    _totalMoney.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"orderPrice"] floatValue]/100];
    
    _currentCash = [souceDic[@"data"][@"summary"][@"walletPrice"]floatValue]/100;
    _topLabel.text = [NSString stringWithFormat:@"  可提现金额：%.2f 元",_currentCash] ;
    NSArray* arr = souceDic[@"data"][@"summary"][@"settlemets"];
    if (arr)
    {
       [_settleOrderS removeAllObjects];
       [_settleOrderS addObjectsFromArray:arr];
    }
    [self addLoadMoreViewWithCount:arr.count];
    [_table reloadData];
    
    NSIndexPath* path = [NSIndexPath  indexPathForRow:0 inSection:0];
    [_table scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _settleOrderS.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
//    cell.separatorInset = UIEdgeInsetsZero;
    
    
    NSDictionary* temp = _settleOrderS[indexPath.row];
    cell.payStatueLabel.text = @"";
    [cell setPayStatueImage:nil];
    
//    if ([temp[@"payStatus"] intValue]==0) {
//
//        cell.payStatueLabel.text = @"未打款";
//        cell.payStatueLabel.textColor = DEFAULTNAVCOLOR;
////        [cell setPayStatueImage:[UIImage imageNamed:@"businessNotPay"]];
//    }
//    else
//    {
//        cell.payStatueLabel.text = @"已打款";
//        cell.payStatueLabel.textColor = DEFAULTGREENCOLOR;
//        [cell setPayStatueImage:[UIImage imageNamed:@"businessPayed"]];
//        [cell setTitleLabelText:temp[@"date"]];
//       
//    }
    [cell setTitleLabelText:temp[@"date"]];
    [cell setCountOrderStr:[NSString stringWithFormat:@"%@单",[temp[@"orderCount"] stringValue]]];
    float money = [temp[@"orderPrice"] floatValue]/100;
    [cell setTotalMoney:[NSString stringWithFormat:@"¥%.2f",money]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

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
    if ([type isEqualToString:@"nosettle"]) {
        buiness.title = @"未确认收货订单";
    }
    else
    {
        buiness.title = @"已确认收货订单";
    }

    [buiness setOrdeDate:date];
    [buiness setOrderType:type];
    buiness.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:buiness animated:YES];

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
