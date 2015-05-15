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
    _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    //    _table
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    return self;
}


-(void)reloadTable
{
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
    [productReq shopGetProductWithShopID:manager.shopID withCategory:categoryID fromIndex:0 WithCallBack:^(id backDic, NSError *error) {
        [loadView removeFromSuperview];
        [fullView removeFromSuperview];
        if (error) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wSelf.superview];
            
            [loadView setErrorBk:^{
                [wSelf setCategoryIDToGetData:categoryID];
            }];
            return ;
        }

        if (backDic) {
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
    [productReq shopGetProductWithShopID:manager.shopID withCategory:_currentCategoryID fromIndex:_dataArr.count WithCallBack:^(id backDic, NSError *error) {
       
        wSelf.isLoading = NO;
    
        [wSelf addDataArr:backDic];
        [fullView removeFromSuperview];
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
//        UIView *view =[ [UIView alloc]init];
//        view.backgroundColor = [UIColor clearColor];
//        _table.tableFooterView = view;
        _table.tableFooterView = nil;
    }
    else
    {
        _table.tableFooterView = [[LastViewOnTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH*0.71, 50)];
    }
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    ShopProductData* data = _dataArr[indexPath.row];
    [cell setProductOnOff:data.status?YES:NO];
    [cell setPriceStr:[NSString stringWithFormat:@"%.1f", data.price]];
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
        __weak ShopProductListView* wSelf = self;
        ShopProductData* data = _dataArr[indexPath.row];
        NetWorkRequest* request = [[NetWorkRequest alloc]init];
        [request shopProductDeleteProductWithProductID:data.pID WithBk:^(id backDic, NSError *error) {
            NSString* str = nil;
            if (backDic) {
                str = @"删除成功！";
                [wSelf deleteCategoryReloadTableWithIndex:indexPath];
            }
            else
            {
                str = @"删除失败！";
            }
            THActivityView* show = [[THActivityView alloc]initWithString:str];
            [show show];
            [activeV removeFromSuperview];
            
        }];
        [request startAsynchronous];
    }
}


-(void)deleteCategoryReloadTableWithIndex:(NSIndexPath*)path
{
    [_dataArr removeObjectAtIndex:[path row]];
    NSLog(@"path %d %d",path.row,path.section);
    [_table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
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
        [self loadMoreDataFromNet];
    }
    
}



@end
