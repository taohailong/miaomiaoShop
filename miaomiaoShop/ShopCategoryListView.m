//
//  ShopCategoryList.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopCategoryListView.h"
#import "ShopCategoryData.h"
//#import "NetWorkRequest.h"
#import "ShopObjectApi.h"
#import "THActivityView.h"
#import "CateTableHeadView.h"
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
    _table.separatorColor = FUNCTCOLOR(221, 221, 221);
    [_table registerClass:[CateTableHeadView class] forHeaderFooterViewReuseIdentifier:@"CateTableHeadView"];
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
    [self initNetData];
}

-(void)getNetData
{
    THActivityView* loadV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
    
    ShopObjectApi* req = [[ShopObjectApi alloc]init];
    [req  getShopAllCategorysWithReturnBk:^(NSArray* returnValue) {
        [loadV removeFromSuperview];
        
        
        
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
    
    free(_flag);
    _flag = calloc(dataArr.count, sizeof(int));
//    _flag[0] = 1;
    [_table reloadData];
}


#pragma mark-table


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopCategoryData* cate = _dataArr[section];
    CateTableHeadView* head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CateTableHeadView"];
    UILabel* title = [head getFirstLabel];
    title.textColor = FUNCTCOLOR(102, 102, 102);
    title.font = DEFAULTFONT(16);
    title.highlightedTextColor = DEFAULTNAVCOLOR;
    title.text = cate.categoryName;
    
    [head setAccessImage:@"navBar_narrow" selectImage:@"narrow_down_red"];
    
    if (_flag[section] ==1) {
        [head setSelectView];
    }
    else
    {
        [head disSelectView];
    }
   
    __weak ShopCategoryListView* wself = self;
    [head setSelectBk:^{
        [wself tableViewHeadSelectAtSection:section];
    }];
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_flag[section]==1) {
        ShopCategoryData* data  = _dataArr[section];
        return data.subClass.count;
    }
    return 0;
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

         cell.textLabel.font = DEFAULTFONT(14);
        cell.textLabel.textColor = FUNCTCOLOR(153, 153, 153);
        cell.textLabel.highlightedTextColor = DEFAULTNAVCOLOR;
        cell.backgroundColor = FUNCTCOLOR(243, 243, 243);
        cell.selectedBackgroundView = [self  tableCellSelectView];
    }
    ShopCategoryData* data = _dataArr[indexPath.section];
    
    ShopCategoryData* subData = data.subClass[indexPath.row];
    cell.textLabel.text = subData.categoryName;
   
    return cell;

}


-(void)tableViewHeadSelectAtSection:(NSInteger)section
{
   
    ShopCategoryData* data = _dataArr[section];
    if (data.subClass.count==0)
    {
        if ([self.delegate respondsToSelector:@selector(didSelectSubCategory:WithName:)]) {
            
            [self.delegate didSelectSubCategory: data.categoryID WithName: data.categoryName];
        }
        
        if ([self.delegate respondsToSelector:@selector(didSelectMainCategory:WithName:)]) {
            
            [self.delegate didSelectMainCategory:data.categoryID WithName:data.categoryName];
        }
    }
     _flag[section] = !_flag[section];
    
     NSMutableIndexSet* index = [[NSMutableIndexSet alloc]initWithIndex:section];
    if (_currentSection != section) {
         _flag[_currentSection] = 0;
        [index addIndex:_currentSection];
    }
    _currentSection = section;
    
    [_table reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ShopCategoryData* data = _dataArr[indexPath.section];
    ShopCategoryData* subData = data.subClass[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectSubCategory:WithName:)]) {
        
        [self.delegate didSelectSubCategory: subData.categoryID WithName: subData.categoryName];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectMainCategory:WithName:)]) {
        
        [self.delegate didSelectMainCategory:data.categoryID WithName:data.categoryName];
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
//        NetWorkRequest* request = [[NetWorkRequest alloc]init];
//        [request shopCateDeleteWithCategoryID:data.categoryID WithBk:^(id backDic, NetWorkStatus status) {
//            
//            NSString* str = nil;
//            if (status == NetWorkStatusSuccess) {
//                str = @"删除成功！";
//              [wSelf deleteCategoryReloadTableWithIndex:indexPath];
//            }
//            else
//            {
//                str = @"删除失败！";
//            }
//            THActivityView* show = [[THActivityView alloc]initWithString:str];
//            [show show];
//            [activeV removeFromSuperview];
//
//        }];
//        [request startAsynchronous];
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
    
//    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.superview];
//    
//    UITextField* field =  [alertView textFieldAtIndex:0];
//    NetWorkRequest* request = [[NetWorkRequest alloc]init];
//    [request shopCategoryAddWithName:field.text WithBk:^(id backDic, NetWorkStatus status) {
//        
//        NSString* str = nil;
//        if (status == NetWorkStatusSuccess) {
//           str = @"添加成功！";
//            [self initNetData];
//        }
//        else
//        {
//            str = @"添加失败！";
//        }
//        THActivityView* show = [[THActivityView alloc]initWithString:str];
//        [show show];
//        [activeV removeFromSuperview];
//    }];
//    [request startAsynchronous];
}

-(void)initNetData
{
    __weak ShopCategoryListView *wself = self;
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



-(UIView*)tableCellSelectView
{
    UIView* selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    selectView.backgroundColor = [UIColor whiteColor];
        
//    UIView* separateUp = [[UIView alloc]init];
//    separateUp.translatesAutoresizingMaskIntoConstraints = NO;
//    separateUp.backgroundColor = FUNCTCOLOR(221, 221, 221);
//    [selectView addSubview:separateUp];
//    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[separateUp]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateUp)]];
//        [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[separateUp(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateUp)]];
    
        
    UIView* separateDown = [[UIView alloc]init];
    separateDown.translatesAutoresizingMaskIntoConstraints = NO;
    separateDown.backgroundColor = FUNCTCOLOR(221, 221, 221);;
    [selectView addSubview:separateDown];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[separateDown]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateDown)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separateDown(0.5)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateDown)]];
    
    return selectView;
}


-(UIView*)tableSelectView
{
    UIView* selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    selectView.backgroundColor = [UIColor whiteColor];
    
    UIView* separateUp = [[UIView alloc]init];
    separateUp.translatesAutoresizingMaskIntoConstraints = NO;
    separateUp.backgroundColor = FUNCTCOLOR(221, 221, 221);
    [selectView addSubview:separateUp];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[separateUp]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateUp)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[separateUp(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateUp)]];
    
    
    UIView* separateDown = [[UIView alloc]init];
    separateDown.translatesAutoresizingMaskIntoConstraints = NO;
    separateDown.backgroundColor = separateUp.backgroundColor;
    [selectView addSubview:separateDown];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[separateDown]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateDown)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separateDown(0.5)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separateDown)]];
    
    
    UIView* colorView = [[UIView alloc]init];
    colorView.backgroundColor = DEFAULTNAVCOLOR;
    colorView.translatesAutoresizingMaskIntoConstraints = NO;
    [selectView addSubview:colorView];
    
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[colorView(5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(colorView)]];
    [selectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[colorView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(colorView)]];
    return selectView;
}


-(void)dealloc
{
    free(_flag);
}

@end
