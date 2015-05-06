//
//  ShopCategoryList.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopCategoryListView.h"
#import "ShopCategoryData.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"

@implementation ShopCategoryListView
@synthesize delegate;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self creatTableView];
      return self;
}

-(id)init
{
    self = [super init];
    [self creatTableView];
    return self;
}


-(void)creatTableView
{
    
    _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count+1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString* cellID = @"ids";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [self  tableSelectView];
    }
    if (indexPath.row==_dataArr.count) {
        cell.textLabel.text = @"添加分类";
    }
    else
    {
        ShopCategoryData* data = _dataArr[indexPath.row];
        cell.textLabel.text = data.categoryName;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.5];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _dataArr.count) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"添加分类" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle =UIAlertViewStylePlainTextInput;
        [alert show];
        
        return;
    }
    
    ShopCategoryData* data = _dataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectCategoryIndexWith:WithName:)]) {
        [self.delegate didSelectCategoryIndexWith: data.categoryID WithName:data.categoryName];
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _dataArr.count) {
        return NO;
    }
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
        __weak ShopCategoryListView* wSelf = self;
        ShopCategoryData* data = _dataArr[indexPath.row];
        NetWorkRequest* request = [[NetWorkRequest alloc]init];
        [request shopCateDeleteWithCategoryID:data.categoryID WithBk:^(id backDic, NSError *error) {
            
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
    [_dataArr removeObjectAtIndex:[path row]];  //删除数组里的数据
    [_table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.cancelButtonIndex) {
        return;
    }
    
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    
    UITextField* field =  [alertView textFieldAtIndex:0];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopCategoryAddWithName:field.text WithBk:^(id backDic, NSError *error) {
        
        NSString* str = nil;
        if (backDic) {
           str = @"添加成功！";
            [self initNetData];
        }
        else
        {
            str = @"添加失败！";
        }
        THActivityView* show = [[THActivityView alloc]initWithString:str];
        [show show];
        [activeV removeFromSuperview];
    }];
    [request startAsynchronous];
}

-(void)initNetData
{
    NetWorkRequest* categoryReq = [[NetWorkRequest alloc]init];
    [categoryReq shopGetCategoryWithCallBack:^(NSMutableArray* backDic, NSError *error) {
        if (backDic) {
           [self setDataArr:backDic];
        }
     }];
    [categoryReq startAsynchronous];
    
}

-(UIView*)tableSelectView
{
    UIView* selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
//    selectView.backgroundColor = [UIColor redColor];
    UIView* headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [selectView addSubview:headView];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[headView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headView(1)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView)]];

    
    
    
    UIView* bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [selectView addSubview:bottomView];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[bottomView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomView)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomView(1)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomView)]];

    
    
    UIView* colorView = [[UIView alloc]init];
    colorView.backgroundColor = [UIColor redColor];
    colorView.translatesAutoresizingMaskIntoConstraints = NO;
    [selectView addSubview:colorView];
    
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-1-[colorView(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(colorView)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[colorView]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(colorView)]];
    return selectView;
}

@end
