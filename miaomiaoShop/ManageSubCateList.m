//
//  ManageCateSubList.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ManageSubCateList.h"
#import "OneLabelTableHeadView.h"

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
    _table.backgroundColor = FUNCTCOLOR(243, 243, 243);
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
    
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
//        __weak ShopProductListView* wSelf = self;
//        ShopProductData* data = _dataArr[indexPath.row];
//        NetWorkRequest* request = [[NetWorkRequest alloc]init];
//        [request shopProductDeleteProductWithProductID:data.pID WithBk:^(id backDic, NetWorkStatus status) {
//
//            NSString* str = nil;
//            if (status == NetWorkStatusSuccess) {
//                str = @"删除成功！";
//                [wSelf deleteCategoryReloadTableWithIndex:indexPath];
//            }
//            else
//            {
//                str = backDic;
//            }
//            THActivityView* show = [[THActivityView alloc]initWithString:str];
//            [show show];
//            [activeV removeFromSuperview];
//
//        }];
//        [request startAsynchronous];
//    }
//}




-(void)moveCellAtIndex:(NSInteger) fromRow ToIndex:(NSInteger) toRow
{
    
    
}

@end
