//
//  ManageMainCateList.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ManageMainCateList.h"
#import "OneLabelTableHeadView.h"
#import "THActivityView.h"
#import "ShopCategoryData.h"
#import "ShopObjectApi.h"

@implementation ManageMainCateList
@synthesize delegate;

-(id)init
{
    self = [super init];
    [self creatTableView];
    return self;
}

-(void)creatTableView
{
    
    _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    [_table registerClass:[OneLabelTableHeadView class] forHeaderFooterViewReuseIdentifier:@"OneLabelTableHeadView"];
    [self addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    UIView *view =[ [UIView alloc]init];
    _table.tableFooterView = view;
    
    
    if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
        [_table setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_table setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
//    [self initNetData];
}

-(void)setDataArrAndSelectOneRow:(NSMutableArray *)dataArr
{
    [self setDataArr:dataArr];
    [_table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    if (dataArr.count==0) {
        return;
    }
    _dataArr = dataArr;
    
    [_table reloadData];
}


#pragma mark-table


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OneLabelTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OneLabelTableHeadView"];
    UILabel* title = [head getFirstLabel];
    title.textColor = FUNCTCOLOR(180, 180, 180);
    title.font = DEFAULTFONT(14);
    title.text = @"一级分类";
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
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
        cell.textLabel.font = DEFAULTFONT(14);
        cell.textLabel.textColor = FUNCTCOLOR(102, 102, 102);
        cell.textLabel.highlightedTextColor = DEFAULTNAVCOLOR;
        cell.backgroundColor = FUNCTCOLOR(243, 243, 243);
        
        cell.selectedBackgroundView = [self  tableSelectView];
    }
    ShopCategoryData* data = _dataArr[indexPath.row];
    
    cell.textLabel.text = data.categoryName;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCategoryData* data = _dataArr[indexPath.row];
    NSMutableArray* subArr = data.subClass;

    if ([self.delegate respondsToSelector:@selector(selectMainCateReturnSubClass:)]) {
        [self.delegate selectMainCateReturnSubClass:subArr];
    }
}


-(void)deleteCategoryReloadTableWithIndex:(NSIndexPath*)path
{
    [_dataArr removeObjectAtIndex:[path row]];  //删除数组里的数据
    [_table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除
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




-(void)initNetData
{
    __weak ManageMainCateList *wself = self;
    THActivityView* loadV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req  getShopAllCategorysWithReturnBk:^(NSMutableArray* returnValue) {
        [loadV removeFromSuperview];
        
        [wself setDataArrAndSelectOneRow:returnValue];
        
    } errBk:^(NetApiErrType errCode, NSString* errMes) {
        [loadV removeFromSuperview];
        
        THActivityView* showV = [[THActivityView alloc]initWithString:errMes];
        [showV show];
        
    } failureBk:^(NSString *mes) {
        [loadV removeFromSuperview];
        THActivityView* showV = [[THActivityView alloc]initWithString:mes];
        [showV show];
        
    }];
}

-(UIView*)tableSelectView
{
    UIView* selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    selectView.backgroundColor = [UIColor whiteColor];
    UIView* colorView = [[UIView alloc]init];
    colorView.backgroundColor = DEFAULTNAVCOLOR;
    colorView.translatesAutoresizingMaskIntoConstraints = NO;
    [selectView addSubview:colorView];
    
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[colorView(5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(colorView)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[colorView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(colorView)]];
    return selectView;
}

@end
