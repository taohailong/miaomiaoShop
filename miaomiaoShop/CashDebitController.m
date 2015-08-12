//
//  CashDebitController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-26.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CashDebitController.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "DateFormateManager.h"
#import "CashDebitData.h"
#import "CashDebitCell.h"
#import "LastViewOnTable.h"
#import "DateFormateManager.h"
#import "CommonWebController.h"
#import "UserManager.h"
#import "OneLabelTableHeadView.h"
#import "CashListCell.h"
#import "CashDebitCell.h"

@interface CashDebitController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    float _cash;
    BOOL _isLoading;
    UILabel* _cashLabel;
    UIButton* _cashBt;
    NSMutableArray* _dataArr ;
    float _spreadMoney;
    int _currentPage;
    UILabel* _detailLabel;
}
@end
@implementation CashDebitController
@synthesize canTake;

-(id)initWithCash:(float)cash WithSpread:(float)spread
{
    self = [super init];
    _cash = cash;
    _spreadMoney = spread;
    _dataArr = [[NSMutableArray alloc]init];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的钱包";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = FUNCTCOLOR(237, 237, 237);
    [self creatSubView];
    [self netWorkStart];
}

-(void)netWorkStart
{
    __weak CashDebitController* wself = self;
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req getCashTradeListWithIndex:_currentPage  WithBK:^(id backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status == NetWorkStatusSuccess) {
            [wself reloadTableWithData:backDic];
        }
    }];
    [req startAsynchronous];
}



-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    _currentPage += 8;
    
    __weak CashDebitController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getCashTradeListWithIndex:_currentPage WithBK:^(id backDic, NetWorkStatus status) {
        
        if(status == NetWorkStatusSuccess)
        {
          [wSelf loadMoreDataReloadTable:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
         
        }
        else
        {
            THActivityView* messageShow = [[THActivityView alloc]initWithString:backDic];
            [messageShow show];
        }
       
    }];
    [request startAsynchronous];
    
}

-(void)loadMoreDataReloadTable:(NSMutableArray*)arr
{
    _isLoading = NO;
    if (arr) {
       [_dataArr addObjectsFromArray:arr];
       [_table reloadData];
    }
    [self addLoadMoreViewWithCount:arr.count];
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


-(void)cashDebitThroughNet
{
    if (self.canTake==NO) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"一天只能提现一次" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    if (_cash==0)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"0元不能提款" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    DateFormateManager* date = [DateFormateManager shareDateFormateManager];

    if (_cash<500)
    {
        if ([date weekDay]!=Sunday) {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"周一到周六最低可提现500元,周日可以任意提现" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    
    THActivityView* fullView = [[THActivityView alloc]initViewOnWindow];
    [fullView loadViewAddOnWindow];
    
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak CashDebitController* wself = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req getCashWithRequestMoney:[NSString stringWithFormat:@"%d",(int)(_cash*100)] WithBk:^(id backDic, NetWorkStatus status) {
        [loadView removeFromSuperview];
        [fullView removeFromSuperview];
         
        if (status == NetWorkStatusSuccess)
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"提现成功！金额：￥%.2f",_cash] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            _cash = 0;
            [wself reloadTableWithData:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
           
        }
        else
        {
            NSString* str = (NSString*)backDic;
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
       
    }];
    [req startAsynchronous];
}


-(void)reloadTableWithData:(NSMutableArray*)arr
{
    _cashLabel.text = [NSString stringWithFormat:@"¥%.1f",_cash];
    _detailLabel.text = [NSString stringWithFormat:@"可提金额＝¥%.1f(订单金额)＋¥%.1f(推广金额)",_cash-_spreadMoney,_spreadMoney];
    _dataArr = arr;
    [_table reloadData];
    [self addLoadMoreViewWithCount:arr.count];
}


-(void)creatSubView
{
    UIView* headBack = [[UIView alloc]init];

    headBack.backgroundColor = [UIColor whiteColor];
    headBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:headBack];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headBack]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    
    if (IOS_VERSION(7.0))
    {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-74-[headBack(115)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    }
    else
    {
      [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[headBack(115)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    }
   
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.textColor = FUNCTCOLOR(102, 102, 102);
    _detailLabel.font = DEFAULTFONT(12);
    _detailLabel.text = [NSString stringWithFormat:@"可提金额＝订单收入(%.1f)＋推广收入(%.1f)",_cash-_spreadMoney,_spreadMoney];

    [headBack addSubview:_detailLabel];
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_detailLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_detailLabel)]];
     [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_detailLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_detailLabel)]];
    
    
    _cashLabel = [[UILabel alloc]init];
    _cashLabel.adjustsFontSizeToFitWidth = YES;
    _cashLabel.text = [NSString stringWithFormat:@"¥%.1f",_cash];
    _cashLabel.textColor = FUNCTCOLOR(64, 64, 64);
    _cashLabel.font = DEFAULTFONT(28);
    _cashLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headBack addSubview:_cashLabel];
    
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_cashLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashLabel)]];
    
   [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_detailLabel]-5-[_cashLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_detailLabel,_cashLabel)]];
    
    
    
    _cashBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cashBt.translatesAutoresizingMaskIntoConstraints = NO;
    [_cashBt setTitle:@"提现" forState:UIControlStateNormal];
    [_cashBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (self.canTake==NO) {
        _cashBt.backgroundColor = [UIColor lightGrayColor];
        
    }
    else
    {
        _cashBt.backgroundColor = DEFAULTNAVCOLOR;
    }
   
    _cashBt.layer.masksToBounds = YES;
    _cashBt.layer.cornerRadius = 4;

    
    [headBack addSubview:_cashBt];
    [_cashBt addTarget:self action:@selector(cashDebitThroughNet) forControlEvents:UIControlEventTouchUpInside];
    
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_cashBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashBt)]];
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cashLabel(30)]-15-[_cashBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashLabel,_cashBt)]];
    
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提现规则" style:UIBarButtonItemStyleDone target:self action:@selector(detailView)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorColor = FUNCTCOLOR(221, 221, 221);
    [self.view addSubview:_table];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_table registerClass:[CashListCell class] forCellReuseIdentifier:@"CashListCell"];
    [_table registerClass:[OneLabelTableHeadView class] forHeaderFooterViewReuseIdentifier:@"OneLabelTableHeadView"];
    [_table registerClass:[CashDebitCell class] forCellReuseIdentifier:@"CashDebitCell"];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headBack]-0-[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack,_table)]];

}


-(void)detailView
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/wallet/cashPrompt?shop_id=%@", @"www.mbianli.com",manager.shopID];
    
    CommonWebController* web = [[CommonWebController alloc]initWithUrl:url];
    web.title = @"提现规则";
    [self.navigationController pushViewController:web animated:YES];
}


#pragma mark-----------getCash------------------


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OneLabelTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OneLabelTableHeadView"];
    UILabel* title = [head getFirstLabel];
    title.font = DEFAULTFONT(14);
    title.text = @"收支明细";
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashDebitData* dic = _dataArr[indexPath.row];
    CashDebitCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CashDebitCell"];
   
    cell.titleLabel.text = dic.debitTime;
    cell.contentLabel.text = [dic cashCellContentStr];
    if (dic.debitType == CashIncome)
    {
         cell.detailLabel.attributedText = [dic cashCellDetailStr];
        cell.subLabel.text = @"";
    }
    else
    {
         cell.detailLabel.attributedText = nil;
        if (dic.debitStatus == CashComplete)
        {
            cell.subLabel.textColor = FUNCTCOLOR(102,102,102);
            cell.subLabel.text = @"打款完成";
        } else
        {
            cell.subLabel.textColor = DEFAULTNAVCOLOR;
            cell.subLabel.text = @"打款中";
        }
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
    if(h - offset.y-y <50 && _table.tableFooterView.frame.size.height>10)
    {
        [self loadMoreData];
    }
}


@end
