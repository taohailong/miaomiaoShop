//
//  ProductInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/18.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ProductInfoController.h"
#import "ProductEditController.h"
@implementation ProductInfoController
-(id)initWithProductData:(ShopProductData*)data
{
    self = [super init];
    
    _productData = data;
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品详情";
    _table.allowsSelection = NO;
    [_table reloadData];
    
}

//-(void)commitProductInfo
//{
//    [super commitProductInfo];
//}
-(void)creatBottomBt
{
    UIButton* rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    rightBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rightBt];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_table attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    
    [rightBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
    
    
    UIButton* middleBt = [UIButton buttonWithType:UIButtonTypeCustom];
    middleBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:middleBt];
    if (_productData.status ==1) {
        [middleBt setTitle:@"下架" forState:UIControlStateNormal];
    }
    else
    {
       [middleBt setTitle:@"上架" forState:UIControlStateNormal];
    }
    
    [middleBt addTarget:self action:@selector(takeDownProduct) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:middleBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_table attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[middleBt(rightBt)]-0-[rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(middleBt,rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[middleBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(middleBt)]];
    
    [middleBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLight"] forState:UIControlStateNormal];
    
    
    
    UIButton* leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:leftBt];
    [leftBt setTitle:@"删除" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_table attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBt(rightBt)]-0-[middleBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt,middleBt,rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt)]];
    
    [leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLighter"] forState:UIControlStateNormal];
}

-(void)takeDownProduct
{
    _productData.status = !_productData.status;
    [self commitProductInfo];
}

-(void)delectAction
{
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    __weak ProductInfoController* wSelf = self;
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopProductDeleteProductWithProductID:_productData.pID WithBk:^(id backDic, NetWorkStatus status) {
        [activeV removeFromSuperview];
        NSString* str = nil;
        if (status == NetWorkStatusSuccess) {
            str = @"删除成功！";
            [wSelf backToRoot];
        }
        else
        {
            str = backDic;
        }
        THActivityView* show = [[THActivityView alloc]initWithString:str];
        [show show];
    }];
    [request startAsynchronous];
}

-(void)editAction
{
    ProductEditController* edit = [[ProductEditController alloc]initWithProductData:_productData];
    if (_completeBk) {
        __weak AddEditProduct wbk = _completeBk;
        
        __weak UITableView* wtable = _table;
       [edit setCompleteBk:^{
           [wtable reloadData];
           wbk();
       }];
    }
    [self.navigationController pushViewController:edit animated:YES];
}

-(void)backToRoot
{
    if (_completeBk) {
        _completeBk();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)networkRequestApi
{
    __weak AddProductController* wSelf = self;
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopProductUpdateWithProduct:_productData WithBk:^(id backDic, NetWorkStatus status) {
        
        NSString* str = nil;
        if (status == NetWorkStatusSuccess) {
            str = @"修改成功";
            [wSelf commitCompleteBack];
        }
        else
        {
            str = @"修改失败";
        }
        THActivityView* show = [[THActivityView alloc]initWithString:str];
        [show show];
        [activeV removeFromSuperview];
        
    }];
    [request startAsynchronous];
    
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 1;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
//    __weak AddProductController* wSelf = self;
//    __weak ShopProductData* wData = _productData;
    
    if (indexPath.section == 1) {
        AddProductPictureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductPictureCell"];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        
        
//        [cell setPhotoBlock:^{
//            [wSelf showSelectSheetView];
//        }];
        if (_productData.pUrl) {
            [cell setProductImageWithUrl:_productData.pUrl];
        }
        
        cell.textLabel.textColor = FUNCTCOLOR(102, 102, 102);
        cell.textLabel.font = DEFAULTFONT(16);
        cell.textLabel.text = @"相关图片";
        return cell;
    }
    
    
    if (indexPath.row==0)
    {
        AddProductFirstCell* cell1 = [tableView dequeueReusableCellWithIdentifier:@"AddProductFirstCell"];
        UITextField* field = [cell1  getTextField];
        field.enabled = NO;
//        field.placeholder = @"请输入或扫描条形码";
//        field.returnKeyType = UIReturnKeySearch;
        
        UILabel* title = [cell1 getTitleLabel];
        title.textColor = FUNCTCOLOR(102, 102, 102);
        title.font = DEFAULTFONT(16);
        title.text = @"条形码";
        [cell1 setTextField:_productData.scanNu];
        return cell1;
    }
    else if(indexPath.row==1)
    {
        AddProductCommonCell* cell2= [tableView dequeueReusableCellWithIdentifier:@"AddProductCommonCell"];
        UITextField* field = [cell2  getTextField];
        field.enabled = NO;
        [cell2 setTextField:_productData.pName];
        [cell2 setTextTitleLabel:@"商品名称"]  ;
        return cell2;
    }
    else if(indexPath.row ==3)
    {
        AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"AddProductCommonCell"];
        
        UITextField* field = [cell3  getTextField];
        field.enabled = NO;
        
        [cell3 setTextTitleLabel:@"商品售价"];
        if (_productData.price) {
            [cell3 setTextField:[NSString stringWithFormat:@"¥%.1f", _productData.price]];
        }
        return cell3;
    }
    else if(indexPath.row == 2)
    {
        AddProductTwoLabelCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductTwoLabelCell"];
        UILabel* first = [cell getFirstLabel];
        UILabel* second = [cell getSecondLabel];
        first.text = @"商品分类";
        NSString* cateName = nil;
        if (_productData.subCateName&&_productData.categoryName)
        {
            cateName = [NSString stringWithFormat:@"%@-%@",_productData.categoryName,_productData.subCateName];
        }
        else if (_productData.categoryName) {
            cateName = _productData.categoryName;
        }
        
        else
        {
            cateName = _productData.subCateName;
        }
        second.text = cateName;
        return cell ;
    }
    else
    {
        AddProductTwoLabelCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductTwoLabelCell"];
        UILabel* first = [cell getFirstLabel];
        UILabel* second = [cell getSecondLabel];
        
        first.text = @"销售状态";
        if (_productData.status) {
            second.text = @"上架";
        }
        else
        {
           second.text = @"下架";
        }
        return cell ;
    
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}



//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    UITableViewCell* cell = nil;
//    __weak AddProductController* wSelf = self;
//    __weak ShopProductData* wData = _productData;
//      if(indexPath.row==0)
//    {
//        AddProductCommonCell* cell2= [tableView dequeueReusableCellWithIdentifier:@"2"];
//        if (cell2==nil) {
//            cell2 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2" WithFieldBk:nil];
//        }
//        [cell2 setTextField:_productData.pName];
//        [cell2 setTextTitleLabel:@"名称:"]  ;
//        cell = cell2;
//    }
//    else if(indexPath.row ==1)
//    {
//        AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"3"];
//        if (cell3==nil) {
//            cell3 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3" WithFieldBk:nil];
//        }
//        [cell3 setTextTitleLabel:@"价格:"]  ;
//        [cell3 setTextField:[NSString stringWithFormat:@"%.2f", _productData.price]];
//        cell = cell3;
//    }
////    else if (indexPath.row==2)
////    {
////        AddProductSwithCell* cell4 = [tableView dequeueReusableCellWithIdentifier:@"4"];
////        if (cell4==nil) {
////            cell4 = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"4"];
////
////            [cell4 setSwitchBlock:^(BOOL statue) {
////                wData.status = statue;
////                 wSelf.infoChange = YES;
////            }];
////        }
////        [cell4 setSWitchStatue:_productData.status];
////        cell4.textLabel.text = @"销售状态:";
////        cell = cell4;
////    }
//    else if (indexPath.row==3)
//    {
//        cell= [tableView dequeueReusableCellWithIdentifier:@"5"];
//        if (cell==nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"5"];
//        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        if (_productData.categoryName) {
//            cell.textLabel.text = [NSString stringWithFormat:@"分类:%@",_productData.categoryName];
//        }
//        else
//        {
//            cell.textLabel.text = @"分类:";
//        }
//    }
//    else
//    {
//        AddProductPictureCell* cell6 = [tableView dequeueReusableCellWithIdentifier:@"6"];
//        if (cell6==nil) {
//            cell6 = [[AddProductPictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"6"];
//            [cell6 setPhotoBlock:^{
//                [wSelf setUpPhoto];
//            }];
//
//        }
//        [cell6 setProductImageWithUrl:_productData.pUrl];
//        cell = cell6;
//    }
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    return cell;
//}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row ==2) {
//        
//        __weak ProductEditController* wSelf = self;
//        CategorySelectController* cateView = [[CategorySelectController alloc]initWithCompleteBk:^(ShopProductData* product) {
//            [wSelf  setSelectCategory:product];
//        }];
//        
//        [self.navigationController pushViewController:cateView animated:YES];
//    }
//}
//
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//    //  清除缓存
//    SDWebImageManager* manager = [SDWebImageManager sharedManager];
//    [manager diskImageRemoveForURL:[NSURL URLWithString:_productData.pUrl]];
//    
//    self.infoChange = YES;
//    UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        _thumbImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200) and:image];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            NSIndexPath* path = [NSIndexPath indexPathForRow:4 inSection:0];
//            AddProductPictureCell* cell = (AddProductPictureCell*)[_table cellForRowAtIndexPath:path];
//            
//            [cell setProductImage:_thumbImage];
//        });
//    });
//    
//}

@end
