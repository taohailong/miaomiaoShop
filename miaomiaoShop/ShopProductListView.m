//
//  ShopProductListView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopProductListView.h"
#import "ProductCell.h"
#import "ShopProductData.h"
#import "LastViewOnTable.h"
#import "NetWorkRequest.h"
#import "UserManager.h"
#import "THActivityView.h"
#import "OneLabelTableHeadView.h"
#import "ShopObjectApi.h"
@interface ShopProductListView()
{
    NSMutableArray* _dataArr;
     NSString* _currentCategoryID;
}
@property(nonatomic,assign)BOOL isLoading;
@end


@implementation ShopProductListView
@synthesize isLoading;
@synthesize delegate;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    _dataArr = [[NSMutableArray alloc]init];
    [self creatTableView];
    return self;
}


-(id)init
{
    self = [super init];
    _dataArr = [[NSMutableArray alloc]init];
    [self creatTableView];
    return self;
}


-(void)creatTableView
{
    UIView* verticalSeparate = [[UIView alloc]init];
    verticalSeparate.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:verticalSeparate];
    
    verticalSeparate.backgroundColor = FUNCTCOLOR(221, 221, 221);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[verticalSeparate]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(verticalSeparate)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[verticalSeparate(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(verticalSeparate)]];
    
    
    
    
    _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _table.separatorColor = FUNCTCOLOR(221, 221, 221);
    [_table registerClass:[OneLabelTableHeadView class] forHeaderFooterViewReuseIdentifier:@"OneLabelTableHeadView"];
    [self addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    [self addLoadMoreViewWithCount:0];
    if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
        [_table setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_table setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0.5-[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];

}

-(void)reloadTable
{
    [_table reloadData];
}

-(void)setMainCategoryName:(NSString*)name
{
    _cateName = name;
    [_table reloadData];
}


-(void)setCategoryIDToGetData:(NSString *)categoryID
{
   
    __weak ShopProductListView* wSelf = self;
    self.isLoading = NO;
    
    THActivityView* fullView = [[THActivityView alloc]initFullViewTransparentWithSuperView:self.superview];
    
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    
    UserManager* manager = [UserManager shareUserManager];
    NetWorkRequest* productReq = [[NetWorkRequest alloc]init];
    _currentCategoryID = categoryID;
    [productReq shopGetProductWithShopID:manager.shopID withCategory:categoryID fromIndex:0 WithCallBack:^(id backDic, NetWorkStatus status) {
        
        [loadView removeFromSuperview];
        [fullView removeFromSuperview];
        if (status == NetWorkStatusErrorCanntConnect) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.superview];
            
            [loadView setErrorBk:^{
                [wSelf setCategoryIDToGetData:categoryID];
            }];
            return ;
        }
        else if (status ==NetWorkStatusServerError)
        {
            THActivityView* messageShow = [[THActivityView alloc]initWithString:backDic];
            [messageShow show];

        }
        else if (status == NetWorkStatusSuccess) {
           [wSelf setDataArrReloadTable:backDic];
        }
        
    }];
    [productReq startAsynchronous];

}


-(void)loadMoreDataFromNet
{
    if (self.isLoading==YES) {
        return;
    }
    self.isLoading = YES;
    
    
    THActivityView* fullView = [[THActivityView alloc]initFullViewTransparentWithSuperView:self.superview];
    UserManager* manager = [UserManager shareUserManager];
    NetWorkRequest* productReq = [[NetWorkRequest alloc]init];
    __weak ShopProductListView* wSelf = self;
    [productReq shopGetProductWithShopID:manager.shopID withCategory:_currentCategoryID fromIndex:_dataArr.count+1 WithCallBack:^(id backDic, NetWorkStatus status) {
        
        [fullView removeFromSuperview];
        wSelf.isLoading = NO;
        
        if (status == NetWorkStatusSuccess) {
            [wSelf addDataArr:backDic];
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
    [productReq startAsynchronous];

}


-(void)setDataArrReloadTable:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_table reloadData];
    
    if (_dataArr.count) {
       [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
    [self addLoadMoreViewWithCount:dataArr.count];
}


-(void)addDataArr:(NSMutableArray*)da
{
    if (da) {
        [_dataArr addObjectsFromArray:da];
        [_table reloadData];
    }
    
    [self addLoadMoreViewWithCount:da.count];
}

-(void)addLoadMoreViewWithCount:(int)count
{
    
    if (count<20) {
        UIView *view =[ [UIView alloc]init];
        _table.tableFooterView = view;
//        _table.tableFooterView = nil;
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH*0.71, 50)];
    }
 }


-(void)setProductEditStyle:(BOOL)flag
{
    [_table setEditing:flag animated:YES];
}

#pragma mark-table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OneLabelTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OneLabelTableHeadView"];
    head.contentView.backgroundColor = FUNCTCOLOR(237, 237, 237);
    UILabel* title = [head getFirstLabel];
    title.textColor = FUNCTCOLOR(180, 180, 180);
    title.font = DEFAULTFONT(14);
    title.text = _cateName;
    return head;
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
    NSString* cellID = @"ids";
    ProductCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    NSInteger row = indexPath.row;
    __weak ShopProductListView * wself = self;
    [cell setProductBk:^(ProductCellAction type) {
        if (type == ProductCellDelect) {
            [wself delectProductThroughNetAtIndex:row];
        }
        else
        {
            [wself moveCellToTopAtIndex:row];
        }
        
    }];
    ShopProductData* data = _dataArr[indexPath.row];
    [cell setProductOnOff:data.status?YES:NO];
    [cell setPriceStr:[NSString stringWithFormat:@"%.2f", data.price]];
    [cell setTitleStr:data.pName];
    [cell setPicUrl:data.pUrl];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectProductIndex:)]) {
         ShopProductData* data = _dataArr[indexPath.row];
        [self.delegate didSelectProductIndex:data];
    }
}


#pragma mark-tableCell-Edit

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ShopProductData* sourceData = _dataArr[sourceIndexPath.row];
    
    ShopProductData* destinationData = _dataArr[destinationIndexPath.row];

    
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];

    __weak UITableView* wtable = _table;
    __weak ShopProductListView* wSelf = self;
    
    NSInteger sIndex = sourceIndexPath.row;
    NSInteger dIndex = destinationIndexPath.row;
    
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req sortProductIndex:sourceData toIndex:destinationData.score returnBk:^(id returnValue) {
        
        [loadView removeFromSuperview];
        [wSelf moveDataFromIndex:sIndex toDestinationIndex:dIndex];
        
    } errBk:^(NetApiErrType errCode, NSString* errMes) {
        
        [loadView removeFromSuperview];
        [wtable reloadData];
        THActivityView* messageShow = [[THActivityView alloc]initWithString:errMes];
        [messageShow show];

    } failureBk:^(NSString *mes) {
        
        [loadView removeFromSuperview];
        THActivityView* messageShow = [[THActivityView alloc]initWithString:mes];
        [messageShow show];
        [wtable reloadData];
    }];
        
 }


-(void)moveDataFromIndex:(NSInteger)sourceIndex toDestinationIndex:(NSInteger)destination
{
    if (destination==0) {
        ShopProductData* data = _dataArr[sourceIndex];
        [_dataArr removeObjectAtIndex:sourceIndex];
        [_dataArr insertObject:data atIndex:0];
        [_table reloadData];
        return;
    }
    [_dataArr exchangeObjectAtIndex:sourceIndex withObjectAtIndex:destination];
}




-(void)delectProductThroughNetAtIndex:(NSInteger)row
{
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    __weak ShopProductListView* wSelf = self;
    ShopProductData* data = _dataArr[row];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopProductDeleteProductWithProductID:data.pID WithBk:^(id backDic, NetWorkStatus status) {
    
        NSString* str = nil;
        if (status == NetWorkStatusSuccess) {
            str = @"删除成功！";
            [wSelf deleteCategoryReloadTableWithIndex:row];
        }
        else
        {
            str = backDic;
        }
        THActivityView* show = [[THActivityView alloc]initWithString:str];
        [show show];
        [activeV removeFromSuperview];
                
    }];
    [request startAsynchronous];

}

-(void)deleteCategoryReloadTableWithIndex:(NSInteger)row
{
    [_dataArr removeObjectAtIndex:row];
    [_table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)moveCellToTopAtIndex:(NSInteger) fromRow
{
    ShopProductData* data = _dataArr[fromRow];
    
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    
    __weak ShopProductListView* wSelf = self;
    
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req sortProductToTop:data returnBk:^(id returnValue) {
        
        [loadView removeFromSuperview];
        [wSelf moveDataFromIndex:fromRow toDestinationIndex:0];
        
    } errBk:^(NetApiErrType errCode, NSString* errMes) {
        
        [loadView removeFromSuperview];
        THActivityView* messageShow = [[THActivityView alloc]initWithString:errMes];
        [messageShow show];
        
    } failureBk:^(NSString *mes) {
        
        [loadView removeFromSuperview];
        THActivityView* messageShow = [[THActivityView alloc]initWithString:mes];
        [messageShow show];
    }];
    

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
        [self loadMoreDataFromNet];
    }
    
}



@end
