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
@interface CashDebitController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    float _cash;
    BOOL _isLoading;
    UILabel* _cashLabel;
    UIButton* _cashBt;
    NSMutableArray* _dataArr ;
}
@end
@implementation CashDebitController
@synthesize canTake;

-(id)initWithCash:(float)cash
{
    self = [super init];
    _cash = cash;
    _dataArr = [[NSMutableArray alloc]init];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的钱包";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
    [self netWorkStart];
}

-(void)netWorkStart
{
    __weak CashDebitController* wself = self;
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req getCashTradeListWithIndex:0 WithBK:^(NSMutableArray* backDic, NSError *error) {
        [loadView removeFromSuperview];
        if (backDic) {
            [wself reloadTableWithData:backDic];
        }
    }];
    [req startAsynchronous];
}

-(void)reloadTableWithData:(NSMutableArray*)arr
{
    _cashLabel.text = [NSString stringWithFormat:@"可提金额：%.2f 元",_cash];;
    _dataArr = arr;
    [_table reloadData];
    [self addLoadMoreViewWithCount:arr.count];
}


-(void)loadMoreData
{
    if (_isLoading==YES) {
        return;
    }
    _isLoading = YES;
    
    __weak CashDebitController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getCashTradeListWithIndex:_dataArr.count WithBK:^(id backDic, NSError *error) {
        if (error!=nil) {
          [wSelf loadMoreDataReloadTable:backDic];
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
       [self addLoadMoreViewWithCount:arr.count];
    }
    
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
        THActivityView* loadView = [[THActivityView alloc]initWithString:@"一天只能提现一次"];
        [loadView show];
        return;
    }
    

    if (_cash==0)
    {
        THActivityView* loadView = [[THActivityView alloc]initWithString:@"0元不能提款"];
        [loadView show];
        return;
    }
    
    
    DateFormateManager* date = [DateFormateManager shareDateFormateManager];
    if (_cash<500)
    {
        if ([date weekDay]!=Sunday) {
            
            THActivityView* loadView = [[THActivityView alloc]initWithString:@"周一到周六最低可提现500元,周日可以任意提现"];
            [loadView show];
            return;
        }
    }
    
    
    THActivityView* fullView = [[THActivityView alloc]initViewOnWindow];
    [fullView loadViewAddOnWindow];
    
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak CashDebitController* wself = self;
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req getCashWithRequestMoney:[NSString stringWithFormat:@"%d",(int)(_cash*100)] WithBk:^(id backDic, NSError *error) {
        [loadView removeFromSuperview];
        [fullView removeFromSuperview];
        
        if (backDic)
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"提现成功！金额：￥%.2f",_cash] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            _cash = 0;
            [wself reloadTableWithData:backDic];
        }
        else
        {
            NSString* str = nil;
            str = @"提现失败！";
            THActivityView* showStr = [[THActivityView alloc]initWithString:str];
            [showStr show];
            
        }
       
    }];
    [req startAsynchronous];
}

-(void)creatSubView
{
    UIView* headBack = [[UIView alloc]init];
//    headBack.backgroundColor = [UIColor colorWithRed:240.0f/255.0 green:240.f/255.0 blue:240.f/255.0 alpha:1.0 ];
    headBack.backgroundColor = [UIColor whiteColor];
    headBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:headBack];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headBack]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    
    if (IOS_VERSION(7.0))
    {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[headBack(90)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    }
    else
    {
      [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headBack(90)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    }
   
    _cashLabel = [[UILabel alloc]init];
    _cashLabel.adjustsFontSizeToFitWidth = YES;
    _cashLabel.text = [NSString stringWithFormat:@"可提金额：%.2f 元",_cash];
    _cashLabel.font = [UIFont boldSystemFontOfSize:24];
    _cashLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headBack addSubview:_cashLabel];
    
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_cashLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashLabel)]];
    
    [headBack addConstraint:[NSLayoutConstraint constraintWithItem:_cashLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headBack attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    
    _cashBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cashBt.translatesAutoresizingMaskIntoConstraints = NO;
    [_cashBt setTitle:@"提现" forState:UIControlStateNormal];
    [_cashBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cashBt.backgroundColor = DEFAULTNAVCOLOR;
    _cashBt.layer.masksToBounds = YES;
    _cashBt.layer.cornerRadius = 5;

    
    [headBack addSubview:_cashBt];
    [_cashBt addTarget:self action:@selector(cashDebitThroughNet) forControlEvents:UIControlEventTouchUpInside];
    
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_cashLabel]-25-[_cashBt(>=60)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashLabel,_cashBt)]];
    [headBack addConstraint:[NSLayoutConstraint constraintWithItem:_cashBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headBack attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提现规则" style:UIBarButtonItemStyleDone target:self action:@selector(detailView)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headBack]-0-[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack,_table)]];

}


-(void)detailView
{
    CommonWebController* web = [[CommonWebController alloc]init];
    web.title = @"提现规则";
    [self.navigationController pushViewController:web animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return @"收支明细";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* str = @"d";
    CashDebitCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell = [[CashDebitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    CashDebitData* dic = _dataArr[indexPath.row];
    
    cell.titleLabel.text = dic.debitTime;
    cell.contentLabel.text = [NSString stringWithFormat:@"当日%@¥%@",dic.debitType==CashIncome?@"收入 +":@"提现 -", dic.debitMoney];
    
    if(dic.debitType==CashIncome)
    {
       cell.detailLabel.text = @"";
    }
    else
    {
        
        if (dic.debitType==CashComplete) {
           cell.detailLabel.text = @"打款状态：打款完成";
        }
        else
        {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"打款状态：打款中"];
            [str addAttribute:NSForegroundColorAttributeName value:DEFAULTNAVCOLOR range:NSMakeRange(5, 3)];
            
           cell.detailLabel.attributedText = str;
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
    if(h - offset.y-y <50 && _table.tableFooterView)
    {
        [self loadMoreData];
    }
}


@end