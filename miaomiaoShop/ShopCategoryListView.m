//
//  ShopCategoryList.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopCategoryListView.h"
#import "ShopCategoryData.h"

@implementation ShopCategoryListView
@synthesize delegate;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
//    _table.backgroundColor = [UIColor redColor];
//    _table.scrollIndicatorInsets =

    [self addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
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

-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    [_table reloadData];
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
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    ShopCategoryData* data = _dataArr[indexPath.row];
    
    cell.textLabel.text = data.categoryName;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCategoryData* data = _dataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectCategoryIndexWith:)]) {
        [self.delegate didSelectCategoryIndexWith: data.categoryID];
    }
    
}

@end
