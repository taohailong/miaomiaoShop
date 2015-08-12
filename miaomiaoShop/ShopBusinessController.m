//
//  ShopBusinessController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopBusinessController.h"
#import "NetWorkRequest.h"
#import "ShopBusinHeadCell.h"
#import "THActivityView.h"
#import "OrderConfirmOrNotListController.h"
#import "SpreadListController.h"
#import "CashDebitController.h"
#import "BusinessSpreadSummarCell.h"
#import "BusinessSummaryCell.h"
#import "OrderConfirmSummerControl.h"
#import "CashListController.h"
#import "OneLabelTableHeadView.h"

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
    NSString* _spreadUser;
    
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
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_table];
    
    [_table registerClass:[OneLabelTableHeadView class] forHeaderFooterViewReuseIdentifier:@"OneLabelTableHeadView"];
    
    [_table registerClass:[ShopBusinHeadCell class] forCellReuseIdentifier:@"ShopBusinHeadCell"];
    
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [_table registerClass:[BusinessSummaryCell class] forCellReuseIdentifier:@"BusinessSummaryCell"];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    
    
}




-(void)getOrderSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak ShopBusinessController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getDailyOrderSummaryDataWithBk:^(id backDic, NetWorkStatus status) {
    
        [wSelf.errorView removeFromSuperview];
        [loadView removeFromSuperview];
        if (status == NetWorkStatusErrorCanntConnect) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            wSelf.errorView = loadView;
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
    _canTake = [souceDic[@"data"][@"summary"][@"canTake"] boolValue];
    _currentCash = [souceDic[@"data"][@"summary"][@"walletPrice"][@"totalPrice"]floatValue]/100;
    _spreadMoney = [souceDic[@"data"][@"summary"][@"walletPrice"][@"invitePrice"]floatValue]/100;
    
    NSDictionary* nosetDic = souceDic[@"data"][@"summary"][@"nosettlemet"];
    
    _nosettleCountOrder = [NSString stringWithFormat:@"%@单",nosetDic[@"orderCount"]];
    
    _nosettleTotalMoney = [NSString stringWithFormat:@"¥%.1f",[nosetDic[@"orderPrice"] floatValue]/100];
    
    
    _settleCountOrder = [NSString stringWithFormat:@"%@单",souceDic[@"data"][@"summary"][@"settleOder"][@"count"]];
    _settleTotalMoney = [NSString stringWithFormat:@"¥%.1f",[souceDic[@"data"][@"summary"][@"settleOder"][@"price"] floatValue]/100];
    
    
    _spreadUser =  [souceDic[@"data"][@"summary"][@"totalInvite"] stringValue];
    _spreadUser = [NSString stringWithFormat:@"累计推广用户：%@人",_spreadUser];
    
    
    float money = [souceDic[@"data"][@"summary"][@"totalCashOut"] floatValue];
    
    _spreadTotal = [NSString stringWithFormat:@"累计提现：¥%.1f",money/100];
    [_table reloadData];
}


#pragma mark-----------tableview-----------------


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.1;
    }
    return 27;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
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
    if (indexPath.section==0) {
        return 90;
    }
    else if (indexPath.section == 1)
    {
        return 60;
    }
    else
    {
        return 35;
    }
   
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    OneLabelTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OneLabelTableHeadView"];
    UILabel* title = [head getFirstLabel];
    title.font = DEFAULTFONT(14);
   
    if (section==0) {
        return nil;
    }
    
    if (section == 1) {
        title.text = @"在线支付订单明细";
    }
    else if (section == 2)
    {
       title.text = @"推广用户明细";
    }
    else
    {
        title.text = @"提现纪录明细";
    }
    
    return head;
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        ShopBusinHeadCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ShopBusinHeadCell"];
        [cell setSecondLabelText:[NSString stringWithFormat:@"¥%.2f",_currentCash]];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        __weak ShopBusinessController* wself = self;
        BusinessSummaryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessSummaryCell"];
        [cell setBk:^(BOOL isLeft) {
            
            if (isLeft) {
                [wself showNoSettleBusinessDataController];
            }
            else
            {
                [wself showSettleBusinessController];
            }
        }];
        [cell setFirstLStr:_nosettleCountOrder];
        [cell setSecondLText:_nosettleTotalMoney];
        [cell setThirdLText:_settleCountOrder];
        [cell setFourthText:_settleTotalMoney];
        return cell;
    }
    else if (indexPath.section == 2)
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = DEFAULTFONT(16);
        cell.textLabel.textColor = FUNCTCOLOR(102, 102, 102);
        cell.textLabel.text = _spreadUser;
        return cell;
    }
    else
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = DEFAULTFONT(16);
        cell.textLabel.textColor = FUNCTCOLOR(102, 102, 102);
        cell.textLabel.text = _spreadTotal;
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
//        [self showNoSettleBusinessDataController];
    }
    
    else if (indexPath.section == 2)
    {
        [self showSpreadListController];
        
    }
    else
    {
        [self showCashListController];
    }
}



-(void)tapViewToCashTrade
{
    CashDebitController* cashView = [[CashDebitController alloc]initWithCash:_currentCash WithSpread:_spreadMoney];
    cashView.canTake = _canTake;
    [self.navigationController pushViewController:cashView animated:YES];
}



-(void)showNoSettleBusinessDataController
{
    OrderConfirmOrNotListController* buiness = [[OrderConfirmOrNotListController alloc]init];
    buiness.title = @"未确认收货订单";
    [buiness setOrdeDate:nil];
    [buiness setOrderType:@"nosettle"];
    [self.navigationController pushViewController:buiness animated:YES];

}

-(void)showSettleBusinessController
{
    OrderConfirmSummerControl* dailyC = [[OrderConfirmSummerControl alloc]init];
//    dailyC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dailyC animated:YES];
}

-(void)showSpreadListController
{
    SpreadListController* spreadList = [[SpreadListController alloc]init];
//    spreadList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:spreadList animated:YES];
}

-(void)showCashListController
{
    CashListController* cashList = [[CashListController alloc]init];
    [self.navigationController pushViewController:cashList animated:YES];
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
