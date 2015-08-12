//
//  ShopBusinessInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderConfirmOrNotListController.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "OrderConfirmCell.h"
//#import "OrderConfirmSeparateCell.h"
#import "OrderData.h"
#import "OrderInfoController.h"
#import "LastViewOnTable.h"
@interface OrderConfirmOrNotListController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    BOOL _isLoading;
    NSString* _orderDate;
    NSString* _orderType;
    UITableView* _table;
    NSMutableArray*_orderArr;
//    NSMutableDictionary* _orderDic;
}
@end

@implementation OrderConfirmOrNotListController

-(void)setOrdeDate:(NSString*)date
{
    _orderDate = date;
}

-(void)setOrderType:(NSString*)type
{
    _orderType = type;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_table registerClass:[OrderConfirmCell class] forCellReuseIdentifier:@"OrderConfirmCell"];
//    [_table registerClass:[OrderConfirmSeparateCell class] forCellReuseIdentifier:@"OrderConfirmSeparateCell"];
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor =  FUNCTCOLOR(237, 237, 237);
    _table.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_table]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
   
    [self getOrderList];
    // Do any additional setup after loading the view.
}


-(void)getOrderList
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    __weak OrderConfirmOrNotListController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getBusinessOrderInfoWithDate:_orderDate WithType:_orderType withIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        [loadView removeFromSuperview];
        
        if (status == NetWorkStatusSuccess) {
            [wSelf reloadTableWithData:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
            
        }

        else
        {
            THActivityView* loadView = [[THActivityView alloc]initWithString:backDic];
            [loadView show];
        }
        
    }];
    [request startAsynchronous];
}


-(void)loadMoreData
{
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    __weak OrderConfirmOrNotListController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getBusinessOrderInfoWithDate:_orderDate WithType:_orderType withIndex:_orderArr.count+1 WithBk:^(id backDic, NetWorkStatus status) {
        
        if (status==NetWorkStatusSuccess) {
            [wSelf addDataArr:backDic];
        }
        else if (status == NetWorkStatusErrorTokenInvalid)
        {
            
        }

        else
        {
            THActivityView* showStr = [[THActivityView alloc]initWithString:backDic];
            [showStr show];
        }

    }];
    [request startAsynchronous];

}
-(void)reloadTableWithData:(NSMutableArray*)arr
{
    _orderArr = arr;
    [_table reloadData];
    [self setTableViewFootWithDataCount:_orderArr.count];
}

-(void)setTableViewFootWithDataCount:(int)count
{
    if (count<20)
    {
        _table.tableFooterView = [self setExtraCellLineHidden];
    
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    }


}

-(void)addDataArr:(NSMutableArray*)da
{
    _isLoading = NO;
    [_orderArr addObjectsFromArray:da];
    [_table reloadData];
    [self setTableViewFootWithDataCount:_orderArr.count];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSString* date = _dateArr[section];
//    NSArray* arr= _orderDic[date];
    return _orderArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//   NSString* str = @"cell";
    OrderConfirmCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OrderConfirmCell"];
    OrderData* data = _orderArr[indexPath.row];
    
    [cell setImageViewImageName:@"order_time"];
    [cell setTitleLabelText: data.orderTime];
    
    NSAttributedString* second = [self setFormateStrHead:@"订单编号：" withEndStr:data.orderNu withColor: FUNCTCOLOR(153, 153, 153)];
    [cell setSecondLAttribute:second];
    
    
    NSAttributedString* third = [self setFormateStrHead:@"订单金额：" withEndStr:data.totalMoney withColor:FUNCTCOLOR(153, 153, 153)];
    [cell setThirdLAttribute: third];
    
    
    NSString* title = nil;
    if (_orderDate) {
        title = @"收货时间：";
    }
    else
    {
      title= @"最晚收货时间：";
    }
    NSAttributedString* fourth = [self setFormateStrHead:title withEndStr:data.orderTakeOver withColor:FUNCTCOLOR(153, 153, 153)];
    [cell setFourthAttribute: fourth];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   OrderData* data = _orderArr[indexPath.row];
    OrderInfoController* orderInfo = [[OrderInfoController alloc]initWithOrderData: data];
    
    [self.navigationController pushViewController:orderInfo animated:YES];

}

- (UIView*)setExtraCellLineHidden
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
     return  view;
}

-(NSAttributedString*)setFormateStrHead:(NSString*)head withEndStr:(NSString*)endStr withColor:(UIColor*)color
{
    NSMutableAttributedString* status = [[NSMutableAttributedString alloc]initWithString:head attributes:@{NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102),NSFontAttributeName:DEFAULTFONT(14)}];
    NSAttributedString* statusStr = [[NSAttributedString alloc]initWithString:endStr attributes:@{NSForegroundColorAttributeName:color}];
    [status appendAttributedString:statusStr];
    
    return status;
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
