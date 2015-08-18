//
//  ManageCateSubList.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ManageSubCateList.h"
#import "OneLabelTableHeadView.h"
#import "THActivityView.h"
#import "ShopObjectApi.h"
@implementation ManageSubCateList

-(id)init
{
    self = [super init];
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
    _table.backgroundColor = FUNCTCOLOR(249, 249, 249);
    _table.separatorColor = FUNCTCOLOR(221,221, 221);

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


-(void)setDataArrReloadTable:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_table reloadData];
    
    if (dataArr.count==0) {
        return;
    }
    if (_dataArr.count -1<_currentIndex) {
        _currentIndex = 0;
    }

    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    [self addLoadMoreViewWithCount:dataArr.count];
}

-(ShopCategoryData*)getCurrentCategory
{
    if (_dataArr.count ==0) {
        return nil;
    }
    ShopCategoryData* data = _dataArr[_currentIndex];
    return data;
}

-(void)addLoadMoreViewWithCount:(int)count
{
    UIView *view =[ [UIView alloc]init];
    _table.tableFooterView = view;
}



#pragma mark-table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OneLabelTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OneLabelTableHeadView"];
    head.contentView.backgroundColor = FUNCTCOLOR(237, 237, 237);
    UILabel* title = [head getFirstLabel];
    title.textColor = FUNCTCOLOR(180, 180, 180);
    title.font = DEFAULTFONT(14);
    title.text = @"二级分类";
    return head;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"ids";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        
        cell.selectedBackgroundView = [self cellBackeView];
        cell.textLabel.highlightedTextColor = DEFAULTNAVCOLOR;
        cell.backgroundColor = FUNCTCOLOR(249, 249, 249);
        cell.textLabel.font = DEFAULTFONT(15);
        cell.textLabel.textColor = FUNCTCOLOR(153, 153, 153);
    }
    
    ShopCategoryData* data = _dataArr[indexPath.row];
    cell.textLabel.text = data.categoryName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
//    if ([self.delegate respondsToSelector:@selector(didSelectProductIndex:)]) {
//        ShopProductData* data = _dataArr[indexPath.row];
//        [self.delegate didSelectProductIndex:data];
//    }
}

-(UIView*)cellBackeView
{
    UIView* selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    selectView.backgroundColor = [UIColor whiteColor];
    
    UIView* separateUp = [[UIView alloc]init];
    separateUp.translatesAutoresizingMaskIntoConstraints = NO;
    separateUp.backgroundColor = FUNCTCOLOR(221, 221, 221);
    [selectView addSubview:separateUp];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separateUp]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateUp)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[separateUp(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateUp)]];
    
    
    UIView* separateDown = [[UIView alloc]init];
    separateDown.translatesAutoresizingMaskIntoConstraints = NO;
    separateDown.backgroundColor = separateUp.backgroundColor;
    [selectView addSubview:separateDown];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separateDown]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateDown)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separateDown(0.5)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateDown)]];
    
    
    return selectView;
}

#pragma mark-tableCell-Edit

-(void)setProductEditStyle:(BOOL)flag
{
    [_table setEditing:flag animated:YES];
}


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
    ShopCategoryData* sourceData = _dataArr[sourceIndexPath.row];
    
    ShopCategoryData* destinationData = _dataArr[destinationIndexPath.row];
    
    
    THActivityView* loadView = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    
    __weak UITableView* wtable = _table;
    __weak ManageSubCateList* wSelf = self;
    
    NSInteger sIndex = sourceIndexPath.row;
    NSInteger dIndex = destinationIndexPath.row;
    
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req sortCategoryIndex:sourceData toIndex:destinationData.score returnBk:^(id returnValue) {
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
    [_dataArr exchangeObjectAtIndex:sourceIndex withObjectAtIndex:destination];
}



@end
