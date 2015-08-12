//
//  SpreadListController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "SpreadListController.h"
#import "SpreadData.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "LastViewOnTable.h"
#import "SpreadListCell.h"
#import "OrderConfirmSummerHeadView.h"
#import "SpreadListNoSeparateCell.h"

#import "SpreadInfoController.h"

@interface SpreadListController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    NSMutableDictionary* _dataDic;
    NSMutableArray* _monthArr;
    int _dataCount;
    BOOL _isLoading;
}
@end
@implementation SpreadListController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"推广信息";
    
    _dataDic = [[NSMutableDictionary alloc]init];
    _monthArr = [[NSMutableArray alloc]init];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_table];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = FUNCTCOLOR(237, 237, 237);

    [_table registerClass:[OrderConfirmSummerHeadView class] forHeaderFooterViewReuseIdentifier:@"OrderConfirmSummerHeadView"];
     [_table registerClass:[SpreadListNoSeparateCell class] forCellReuseIdentifier:@"SpreadListNoSeparateCell"];
    
    [_table registerClass:[SpreadListCell class] forCellReuseIdentifier:@"SpreadListCell"];
    
    
    [self getSpreadSummary];
}


-(void)getSpreadSummary
{
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    __weak SpreadListController* wSelf = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getSpreadSummaryDataWithIndex:0 WithBk:^(id backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        if (status==NetWorkStatusErrorCanntConnect) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.view];
            
            [loadView setErrorBk:^{
                [wSelf getSpreadSummary];
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
    
    __weak SpreadListController* wSelf = self;
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request getSpreadSummaryDataWithIndex:_dataCount+1 WithBk:^(id backDic, NetWorkStatus status) {
        
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
        
        for (NSDictionary * dic in arrDic)
        {
            _dataCount++;
            
            SpreadData* element = [[SpreadData alloc]init];
            element.month = dic[@"month"];
            element.date = dic[@"date"];
            element.currentMonthNu = [dic[@"monthTotalUser"] stringValue];
            
            float money = [dic[@"monthTotalPrice"] floatValue];
            element.currentMonthMoney = [NSString stringWithFormat:@"¥%.1f",money/100];
            element.wxUserNu = [dic[@"wxUser"] intValue];
            element.appUserNu = [dic[@"appUser"] intValue];
            element.totalUserNu = [dic[@"totalUser"] intValue];
            
            NSString* month = dic[@"month"];
            if (_dataDic[month] == nil)
            {
                NSMutableArray* arr = [[NSMutableArray alloc]init];
                [arr addObject:element];
                [_dataDic setObject:arr forKey:month];
                
                
                 NSString* totalMoney = [NSString stringWithFormat:@"%.1f",[dic[@"monthTotalPrice"] floatValue]/100];
                [_monthArr addObject:@{@"month":dic[@"month"],@"totalNu":dic[@"monthTotalUser"],@"totalMoney":totalMoney}];
            }
            else
            {
                NSMutableArray* arr = _dataDic[month];
                [arr addObject:element];
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addLoadMoreViewWithCount:arrDic.count];
            [_table reloadData];
        });
    });

}




//-(void)loadMoreDataAnalysis:(NSDictionary*)souceDic
//{
//    _isLoading = NO;
//    NSArray* arr = souceDic[@"data"][@"summary"][@"settlemets"];
//    [self addLoadMoreViewWithCount:arr.count];
//    if (arr)
//    {
//        [_settleOrderS addObjectsFromArray:arr];
//    }
//    [_table reloadData];
//}


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
    if (indexPath.row==0) {
        return 135;
    }
    else
    {
        return 145;
    }
    
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
    [headView setSecondLabelText:[NSString stringWithFormat:@"当月共计：%@个",dic[@"totalNu"]]];
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
    
    SpreadListCell* cell ;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SpreadListNoSeparateCell"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SpreadListCell"];
    }
    [cell setImageViewImageName:@"order_time"];

    NSDictionary*key = _monthArr[indexPath.section];
    SpreadData* temp = _dataDic[key[@"month"]][indexPath.row];
    
    [cell setTitleLabelText:temp.date];
   
    UILabel* second = [cell getSecondLabel];
    second.textColor = FUNCTCOLOR(153, 153, 153);
    second.font = DEFAULTFONT(14);
    second.text = [NSString stringWithFormat:@"微信用户推广数量：%d",temp.wxUserNu];
    
    
    
    UILabel* third = [cell getThirdLabel];
    third.textColor = FUNCTCOLOR(153, 153, 153);
    third.font = DEFAULTFONT(14);
    third.text = [NSString stringWithFormat:@"APP用户推广数量：%d",temp.appUserNu];
    
    UILabel* fourth = [cell getFourthLabel];
    NSAttributedString* str = [self setFormateStrHead:@"用户推广总数量：" withEndStr:[NSString stringWithFormat:@"%d",temp.totalUserNu] withColor:FUNCTCOLOR(153, 153, 153)];
    fourth.attributedText = str;
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




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary*key = _monthArr[indexPath.section];
    SpreadData* temp = _dataDic[key[@"month"]][indexPath.row];

    SpreadInfoController* infoController = [[SpreadInfoController alloc]initWithDate:temp.date];
    [self.navigationController pushViewController:infoController animated:YES];
}


-(NSAttributedString*)setFormateStrHead:(NSString*)head withEndStr:(NSString*)endStr withColor:(UIColor*)color
{
    NSMutableAttributedString* status = [[NSMutableAttributedString alloc]initWithString:head attributes:@{NSForegroundColorAttributeName:FUNCTCOLOR(102, 102, 102),NSFontAttributeName:DEFAULTFONT(14)}];
    NSAttributedString* statusStr = [[NSAttributedString alloc]initWithString:endStr attributes:@{NSForegroundColorAttributeName:color}];
    [status appendAttributedString:statusStr];
    
    return status;
}



@end
