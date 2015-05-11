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
@interface ShopBusinessController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* _table;
    IBOutlet UILabel* _countOrderL;
    IBOutlet UILabel* _totalMoney;
    IBOutlet UIView* _backView;
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
    
    _table.delegate = self;
    _table.dataSource = self;
    if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_table setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_table setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    UITapGestureRecognizer* tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewToInfo)];
    [_backView addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
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
    [request getDailyOrderSummaryWithBk:^(NSDictionary* backDic, NSError *error) {
        
        [wSelf.errorView removeFromSuperview];
        [loadView removeFromSuperview];
        if (error) {
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
    NSDictionary* dic = souceDic[@"data"][@"summary"][@"nosettlemet"];
    _countOrderL.text = [NSString stringWithFormat:@"%d单",[dic[@"orderCount"] intValue]];
    _totalMoney.text = [NSString stringWithFormat:@"¥%.1f",[dic[@"orderPrice"] floatValue]/100];
    
    _settleOrderS = souceDic[@"data"][@"summary"][@"settlemets"];
    [_table reloadData];
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
    
    
    if ([temp[@"payStatus"] intValue]==0) {

        cell.payStatueLabel.text = @"未打款";
        cell.payStatueLabel.textColor = DEFAULTNAVCOLOR;
        [cell setPayStatueImage:[UIImage imageNamed:@"businessNotPay"]];
    }
    else
    {
        cell.payStatueLabel.text = @"已打款";
        cell.payStatueLabel.textColor = DEFAULTGREENCOLOR;
        [cell setPayStatueImage:[UIImage imageNamed:@"businessPayed"]];
        [cell setTitleLabelText:temp[@"date"]];
       
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* temp = _settleOrderS[indexPath.row];
    [self showDetailInfoViewWithDate:temp[@"date"] Type:@"settled"];
}

-(void)showDetailInfoViewWithDate:(NSString*)date Type:(NSString*)type
{
    ShopBusinessInfoController* buiness = [[ShopBusinessInfoController alloc]init];
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
