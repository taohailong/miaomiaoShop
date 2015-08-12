//
//  OrderInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderInfoController.h"
#import "OrderInfoSecondCell.h"
#import "OrderInfoFirstCell.h"
#import "ShopProductData.h"
#import "THActivityView.h"
#import "NetWorkRequest.h"
#import "OrderInfoTwoLCell.h"
#import "OneLabelTableHeadView.h"
@interface OrderInfoController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    OrderData* _orderData;
}

@end

@implementation OrderInfoController


-(id)initWithOrderData:(OrderData *)data
{
    self = [super init];
    _orderData = data;
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = FUNCTCOLOR(237, 237, 237);
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_table registerClass:[OneLabelTableHeadView class] forHeaderFooterViewReuseIdentifier:@"OneLabelTableHeadView"];
    [_table registerClass:[OrderInfoFirstCell class] forCellReuseIdentifier:@"OrderInfoFirstCell"];
    [_table registerClass:[OrderInfoSecondCell class] forCellReuseIdentifier:@"OrderInfoSecondCell"];
    
    [_table registerClass:[OrderInfoTwoLCell class] forCellReuseIdentifier:@"OrderInfoTwoLCell"];
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    if ([_orderData.orderStatue isEqualToString:@"订单确认"]) {
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
        [self setTableViewFootWithConfirmDeliver:YES];
    }
    else
    {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];

        [self setTableViewFootWithConfirmDeliver:NO];
    }

    
    
    UIButton* bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    bt.frame = CGRectMake(0, 0, 25, 35);
    [bt setImage:[UIImage imageNamed:@"orderinfo_tel_on"] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"orderinfo_tel"] forState:UIControlStateHighlighted];
    [bt addTarget:self action:@selector(makeTelphoneCall) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:bt];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    // Do any additional setup after loading the view.
}

-(void)setTableViewFootWithConfirmDeliver:(BOOL)flag
{
    if(flag)
    {
        UIView* footView = [self creatOrderConfirmFootView];
        footView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:footView];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[footView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footView)]];
        
         [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[footView(55)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footView)]];
    }
    else
    {
        _table.tableFooterView = [self setExtraCellLineHidden];
    }
   
}

-(UIView*)creatOrderConfirmFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    
    UIButton* cancelBt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBt.tag = 0;
    cancelBt.titleLabel.font = DEFAULTFONT(16);
    [cancelBt setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];

    [cancelBt setImage:[UIImage imageNamed:@"orderInfo_canntDeliver"] forState:UIControlStateNormal];
    [cancelBt setTitle:@"无法配送" forState:UIControlStateNormal];
    cancelBt.backgroundColor = FUNCTCOLOR(255, 192, 192);
    cancelBt.translatesAutoresizingMaskIntoConstraints = NO;
    [footView addSubview:cancelBt];
    [cancelBt addTarget:self action:@selector(performOrderConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[cancelBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cancelBt)]];
    
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cancelBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cancelBt)]];
    
    
    
    UIButton * confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBt.backgroundColor = DEFAULTNAVCOLOR;
    confirmBt.tag = 1;
    confirmBt.titleLabel.font = DEFAULTFONT(16);
    confirmBt.translatesAutoresizingMaskIntoConstraints  = NO;
    
    [confirmBt setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [confirmBt setImage:[UIImage imageNamed:@"orderInfo_confirmDeliver"] forState:UIControlStateNormal];
    [confirmBt setTitle:@"确认配送" forState:UIControlStateNormal];
    [footView addSubview:confirmBt];
    [confirmBt addTarget:self action:@selector(performOrderConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cancelBt]-0-[confirmBt(cancelBt)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(confirmBt,cancelBt)]];
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[confirmBt(cancelBt)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(confirmBt,cancelBt)]];
    
    return footView;
    
}


-(void)makeTelphoneCall
{
    NSString* url = [NSString stringWithFormat:@"tel://%@",_orderData.telPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


-(void)performOrderConfirmAction:(UIButton*)bu
{
    if (bu.tag) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认要配送吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = bu.tag;
        [alert show];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认无法配送吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = bu.tag;
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex==buttonIndex) {
        return;
    }
    
    THActivityView* fullView = [[THActivityView alloc]initViewOnWindow];
    [fullView loadViewAddOnWindow];
    
    __weak OrderInfoController* wself = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    if (alertView.tag) {
        
        [request shopOrderConfirmDeliverWithOrderID:_orderData.orderNu WithBk:^(id backDic, NetWorkStatus status) {
            
            [fullView removeFromSuperview];
            if (status==NetWorkStatusSuccess) {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功！"];
                [showStr show];
                [wself manualBack];
            }
            else if (status == NetWorkStatusErrorTokenInvalid)
            {
                
            }

            else
            {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败！"];
                [showStr show];
            }
            
        }];
        [request startAsynchronous];
    }
    else
    {
        [request shopOrderCancelDeliverWithOrderID:_orderData.orderNu WithBk:^(id backDic, NetWorkStatus status) {
            
            [fullView removeFromSuperview];
            
            if (status == NetWorkStatusSuccess) {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交成功！"];
                [showStr show];
                [wself manualBack];
            }
            else
            {
                THActivityView* showStr = [[THActivityView alloc]initWithString:@"提交失败！"];
                [showStr show];
            }
            
        }];
        [request startAsynchronous];
    }
}



- (UIView*)setExtraCellLineHidden
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return  view;
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   OneLabelTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OneLabelTableHeadView"];
    UILabel* titleL = [head getFirstLabel];
    titleL.font = DEFAULTFONT(14);
    head.contentView.backgroundColor = FUNCTCOLOR(237, 237, 237);
    if (section == 0) {
        titleL.text = @"用户信息";
    }
    else if (section == 1)
    {
       titleL.text = @"商品信息";
    }
    else
    {
       titleL.text = @"订单信息";
    }
   
    return head;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return _orderData.productArr.count+1;
    }
    else
    {
        return 1;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        return 40;
    }
    else
    {
        return 90;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        OrderInfoFirstCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoFirstCell"];
            [cell setTelPhoneText:_orderData.telPhone];
        [cell setAddressText:_orderData.orderAddress];
        [cell setOrderMessage:_orderData.messageStr];
        return cell;

    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == _orderData.productArr.count)
        {
            OrderInfoTwoLCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoTwoLCell"];
            
            [cell setFirstLabelText:[NSString stringWithFormat:@"总计：%d个",_orderData.countOfProduct]];
            [cell setSecondLabelText:[NSString stringWithFormat:@"总价：¥%@",_orderData.totalMoney]];
            return cell;
        }
        else
        {
            ShopProductData* product = _orderData.productArr[indexPath.row];
            OrderInfoSecondCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoSecondCell"];
            [cell setTitleText:product.pName];
            [cell setProductUrl:product.pUrl];
            [cell setTotalMoney:[NSString stringWithFormat:@"¥%.1f",product.price]];
            [cell setNuStr:[NSString stringWithFormat:@"X%d",product.count]];
            return cell;
        }
    }
    else
    {
        OrderInfoFirstCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoFirstCell"];
        NSAttributedString* status = [self setFormateStrHead:@"支付方式：" withEndStr:[_orderData getPayMethod] withColor:DEFAULTNAVCOLOR];
        [cell setFirstLabelAtt:status];
        
        
         NSAttributedString* time = [self setFormateStrHead:@"订单时间：" withEndStr:_orderData.orderTime withColor:FUNCTCOLOR(153, 153, 153)];
        [cell setSecondLabelAtt:time];
        
        
         NSAttributedString* orderNu = [self setFormateStrHead:@"订单编号：" withEndStr:_orderData.orderNu withColor:FUNCTCOLOR(153, 153, 153)];
        [cell setThirdLabelAtt:orderNu];
        return cell;
    }
}


-(NSAttributedString*)setFormateStrHead:(NSString*)head withEndStr:(NSString*)endStr withColor:(UIColor*)color
{
    NSMutableAttributedString* status = [[NSMutableAttributedString alloc]initWithString:head attributes:@{NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102),NSFontAttributeName:DEFAULTFONT(14)}];
    NSAttributedString* statusStr = [[NSAttributedString alloc]initWithString:endStr attributes:@{NSForegroundColorAttributeName:color}];
    [status appendAttributedString:statusStr];

    return status;
}



-(void)manualBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
