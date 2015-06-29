//
//  ShopBusinessController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopBusinessController.h"
#import "NetWorkRequest.h"
//#import "BusinessCell.h"
#import "THActivityView.h"
#import "ShopBusinessInfoController.h"
#import "SpreadListController.h"
#import "CashDebitController.h"
#import "BusinessSpreadSummarCell.h"
#import "BusinessSummaryCell.h"
#import "ShopDailyDataController.h"

@interface ShopBusinessController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* _table;
    IBOutlet UILabel* _countOrderL;
    IBOutlet UILabel* _totalMoney;
    IBOutlet UIView* _backView;
    
    IBOutlet UILabel* _topLabel;
    IBOutlet UIView* _topBackView;
    
    float _currentCash;
    float _spreadMoney;
    BOOL _canTake;
    BOOL _isLoading;
    
    NSString* _settleCountOrder;
    NSString* _settleTotalMoney;
    
    NSString* _nosettleCountOrder;
    NSString* _nosettleTotalMoney;
    
    NSString* _spread_wx;
    NSString* _spread_app;
    NSString* _spreadTotal;
    
    
    NSMutableArray* _settleOrderS;
    
    NSDictionary* _unSettleDic;
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
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_table];
    
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];
    
    [_table registerClass:[BusinessSpreadSummarCell class] forCellReuseIdentifier:@"SpreadSummarCell"];
    
    [_table registerClass:[BusinessSummaryCell class] forCellReuseIdentifier:@"BusinessSummaryCell"];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    
    
//    _topLabel.textColor = DEFAULTNAVCOLOR;
//      
//    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewToInfo)];
//    [_backView addGestureRecognizer:tap];
//    
//    UITapGestureRecognizer* tapTop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewToCashTrade)];
//    [_topBackView addGestureRecognizer:tapTop];
    // Do any additional setup after loading the view.
}




-(void)getOrderSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak ShopBusinessController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderSummaryDataWithBk:^(id backDic, NetWorkStatus status) {
    
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


-(void)fillDataToViewWith:(NSDictionary*)souceDic
{
    _canTake = [souceDic[@"data"][@"summary"][@"canTake"] boolValue];
    _currentCash = [souceDic[@"data"][@"summary"][@"walletPrice"][@"totalPrice"]floatValue]/100;
    _spreadMoney = [souceDic[@"data"][@"summary"][@"walletPrice"][@"invitePrice"]floatValue]/100;
    
    NSDictionary* nosetDic = souceDic[@"data"][@"summary"][@"nosettlemet"];
    
    _nosettleCountOrder = [NSString stringWithFormat:@"%@单",nosetDic[@"orderCount"]];
    
    _nosettleTotalMoney = [NSString stringWithFormat:@"¥%.2f",[nosetDic[@"orderPrice"] floatValue]/100];
    
    
    _settleCountOrder = [souceDic[@"data"][@"summary"][@"settleOder"][@"count"] stringValue];
    _settleTotalMoney = [NSString stringWithFormat:@"¥%.2f",[souceDic[@"data"][@"summary"][@"settleOder"][@"price"] floatValue]/100];
    
    
    _spread_app = [souceDic[@"data"][@"summary"][@"inviteUser"][@"appUser"] stringValue];
    
    _spread_wx = [souceDic[@"data"][@"summary"][@"inviteUser"][@"wxUser"] stringValue];
    
    _spreadTotal = [souceDic[@"data"][@"summary"][@"inviteUser"][@"totalUser"] stringValue];
    [_table reloadData];
}


#pragma mark-----------tableview-----------------


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        return 80;
    }
    return 60;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"我的钱包";
           
        case 1:
            return @"用户未确认收货订单";
        case 2:
            return @"用户已确认收货订单";
        case 3:
            return @"当前月推广用户信息";
        default:
            break;
    }
     return @"";
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = DEFAULTNAVCOLOR;
        cell.textLabel.text = [NSString stringWithFormat:@"可提现金额：%.2f 元",_currentCash];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        BusinessSummaryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessSummaryCell"];
        [cell setCountOrderStr:_nosettleCountOrder];
        [cell setTotalMoney:_nosettleTotalMoney];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        BusinessSummaryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessSummaryCell"];
        [cell setCountOrderStr:_settleCountOrder];
        [cell setTotalMoney:_settleTotalMoney];
        return cell;
    }
    else
    {
        BusinessSpreadSummarCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SpreadSummarCell"];
        [cell setLayout];
        UILabel* first = [cell getFirstLabel];
        first.text = [NSString stringWithFormat:@"微信用户推广数量：%@",_spread_wx];
        
        UILabel* second = [cell getSecondLabel];
        second.text = [NSString stringWithFormat:@"app用户推广数量：%@",_spread_app];
        
        
        UILabel* third = [cell getThirdLabel];
        third.text = [NSString stringWithFormat:@"用户推广总数量：%@",_spreadTotal];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        [self tapViewToCashTrade];
    }
    else if (indexPath.section == 1)
    {
        [self showNoSettleBusinessDataController];
    }
    
    else if (indexPath.section == 2)
    {
        [self showSettleBusinessController];
    }
    else
    {
        [self showSpreadListController];
    }
}



-(void)tapViewToCashTrade
{
    CashDebitController* cashView = [[CashDebitController alloc]initWithCash:_currentCash WithSpread:_spreadMoney];
    cashView.hidesBottomBarWhenPushed = YES;
    cashView.canTake = _canTake;
    [self.navigationController pushViewController:cashView animated:YES];
}



-(void)showNoSettleBusinessDataController
{
    ShopBusinessInfoController* buiness = [[ShopBusinessInfoController alloc]init];
    buiness.title = @"未确认收货订单";
    [buiness setOrdeDate:nil];
    [buiness setOrderType:@"nosettle"];
    buiness.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:buiness animated:YES];

}

-(void)showSettleBusinessController
{
    ShopDailyDataController* dailyC = [[ShopDailyDataController alloc]init];
    dailyC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dailyC animated:YES];
}

-(void)showSpreadListController
{
    SpreadListController* spreadList = [[SpreadListController alloc]init];
    spreadList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:spreadList animated:YES];
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
