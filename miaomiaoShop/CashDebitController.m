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
@interface CashDebitController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    float _cash;
    UILabel* _cashLabel;
    UIButton* _cashBt;
    NSMutableArray* _dataArr ;
}
@end
@implementation CashDebitController
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
    self.title = @"提现";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
    [self netWorkStart];
}

-(void)netWorkStart
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req getCashTradeListWithIndex:0 WithBK:^(NSDictionary* backDic, NSError *error) {
        [loadView removeFromSuperview];
        
    }];
    [req startAsynchronous];
}

-(void)cashThroughNet
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    NetWorkRequest* req = [[NetWorkRequest alloc]init];
    [req getCashWithRequestMoney:[NSString stringWithFormat:@"%d",(int)(_cash*100)] WithBk:^(id backDic, NSError *error) {
        [loadView removeFromSuperview];
        
        
    }];
    [req startAsynchronous];


}

-(void)creatSubView
{
    UIView* headBack = [[UIView alloc]init];
    headBack.backgroundColor = DEFAULTNAVCOLOR;
    headBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:headBack];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headBack]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[headBack(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack)]];
    
    _cashLabel = [[UILabel alloc]init];
    _cashLabel.text = [NSString stringWithFormat:@"%.2f 元",_cash];
    _cashLabel.font = [UIFont boldSystemFontOfSize:20];
    _cashLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headBack addSubview:_cashLabel];
    
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_cashLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashLabel)]];
    
    [headBack addConstraint:[NSLayoutConstraint constraintWithItem:_cashLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headBack attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    _cashBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cashBt.translatesAutoresizingMaskIntoConstraints = NO;
    [_cashBt setTitle:@"提现" forState:UIControlStateNormal];
    [headBack addSubview:_cashBt];
    
    [headBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_cashLabel]-20-[_cashBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cashLabel,_cashBt)]];
    [headBack addConstraint:[NSLayoutConstraint constraintWithItem:_cashBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headBack attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headBack]-0-[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headBack,_table)]];

}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    {"cash_type":0,"create_time":1432627143000,"id":1,"operate_time":1432627143000,"price":100,"shop_id":1,"status":0}
    
//    DateFormateManager* date = [DateFormateManager shareDateFormateManager];
    NSString* str = @"d";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    NSDictionary* dic = _dataArr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",];
    return cell;

}



@end
