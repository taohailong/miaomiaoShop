//
//  ProductEditViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ProductEditController.h"
#import "NetWorkRequest.h"
#import "ShopProductData.h"
#import "THActivityView.h"
#import "CategorySelectController.h"
#import "UIImage+ZoomImage.h"
#import "SDWebImageManager.h"

@interface ProductEditController ()
{
    ShopProductData* _editData;
//    UITableView* _table;
}
@end

@implementation ProductEditController

-(id)initWithProductData:(ShopProductData*)data
{
    self = [super init];
    
    _productData = data;
    _editData = [[ShopProductData alloc]init];
    _editData.categoryName =_productData.categoryName;
    _editData.subCateName = _productData.subCateName;

    _editData.pID = _productData.pID;
    _editData.scanNu = _productData.scanNu;
    _editData.subCateID = _productData.subCateID ;
    _editData.categoryID = _productData.categoryID;
    _editData.price = _productData.price;
    _editData.status = _productData.status ;
    _editData.pName =  _productData.pName;
    _editData.pUrl = _productData.pUrl;
    _editData.score = _productData.score;
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"编辑商品";
    
    [_table reloadData];
   
}

//-(void)commitProductInfo
//{
//    [super commitProductInfo];
//}
-(void)creatBottomBt
{
    UIButton* rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setTitle:@"保存" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    rightBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rightBt];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:CGRectGetWidth(self.view.frame)/2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_table attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    
    [rightBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
    
    
    
    
    
    UIButton* leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:leftBt];
    [leftBt setTitle:@"取消" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_table attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBt]-0-[rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt,rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt)]];
    
    [leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLighter"] forState:UIControlStateNormal];
}


-(void)saveAction
{
    if (_editData.categoryID ==nil)
    {
        THActivityView* loadView = [[THActivityView alloc]initWithString:@"请选择分类"];
        [loadView show];
        return;
    }
    
     [self commitProductInfo];
}

-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitCompleteBack
{
    _productData.scanNu = _editData.scanNu;
    _productData.price = _editData.price;
    _productData.categoryID = _editData.categoryID;
    _productData.pUrl = _editData.pUrl;
    _productData.categoryName = _editData.categoryName;
    _productData.subCateName = _editData.subCateName;
    _productData.subCateID = _editData.subCateID;
    _productData.pName = _editData.pName;
    _productData.status = _editData.status;

    if (_completeBk) {
        _completeBk();
    }
     [self.navigationController popViewControllerAnimated:YES];
}

//-(void)checkDifference
//{
//    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
//    AddProductCommonCell* cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
//    _productData.pName = [cell getTextFieldString];
//    
//    
//    path = [NSIndexPath indexPathForRow:1 inSection:0];
//    cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
//    _productData.price = [[cell getTextFieldString] floatValue];
//    
//}
//

-(void)networkRequestApi
{
    __weak AddProductController* wSelf = self;
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopProductUpdateWithProduct:_editData WithBk:^(id backDic, NetWorkStatus status) {
        
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
    __weak ProductEditController* wSelf = self;
    __weak ShopProductData* wData = _editData;
    
    if (indexPath.section == 1) {
        AddProductPictureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductPictureCell"];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        
        
        [cell setPhotoBlock:^{
            [wSelf showSelectSheetView];
        }];
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
        [cell1 setSearchBk:^(NSString *text) {
            [wSelf getProductDataThroughScanNu:text];
        }];
        [cell1 setCellBtBk:^{
            [wSelf setUpScanViewController];
        }];
        UITextField* field = [cell1  getTextField];
        field.placeholder = @"请输入或扫描条形码";
        field.keyboardType = UIKeyboardTypeNumberPad;
        field.returnKeyType = UIReturnKeySearch;
        field.textColor = FUNCTCOLOR(180, 180, 180);
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
        [cell2 setTextFieldBk:^(NSString *text) {
            wData.pName = text;
        }];
        UITextField* field = [cell2  getTextField];
        field.placeholder = @"请输入商品名称";
        field.textColor = FUNCTCOLOR(180, 180, 180);
        [cell2 setTextField:_productData.pName];
        [cell2 setTextTitleLabel:@"商品名称"]  ;
        return cell2;
    }
    else if(indexPath.row ==3)
    {
        AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"AddProductCommonCell"];
        
        [cell3 setTextFieldBk:^(NSString *text) {
            
            if ([text hasPrefix:@"¥"]) {
                text = [text substringFromIndex:1];
            }
            wData.price = [text floatValue];
        }];
        UITextField* field = [cell3  getTextField];
        field.placeholder = @"请输入价格";
        field.textColor = FUNCTCOLOR(180, 180, 180);
        [cell3 setFieldKeyboardStyle:UIKeyboardTypeDecimalPad];
        [cell3 setTextTitleLabel:@"商品售价"];
        if (_productData.price) {
            [cell3 setTextField:[NSString stringWithFormat:@"¥%.1f", _productData.price]];
        }
        return cell3;
    }
    else if(indexPath.row == 2)
    {
        AddProductTwoLabelCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductTwoLabelCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel* first = [cell getFirstLabel];
        UILabel* second = [cell getSecondLabel];
        second.textColor = FUNCTCOLOR(180, 180, 180);
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
    
        AddProductSwithCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductSwithCell"];
        [cell setSwitchBlock:^(BOOL statue) {
            wData.status = statue;
        }];
        
        [cell setSWitchStatue:_productData.status];
        cell.textLabel.text = @"销售状态";
       
        return cell ;

    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==2) {
        
        __weak ProductEditController* wSelf = self;
        CategorySelectController* cateView = [[CategorySelectController alloc]initWithCompleteBk:^(ShopProductData* product) {
            [wSelf  setSelectCategory:product];
        }];
        
        [self.navigationController pushViewController:cateView animated:YES];
    }
}



-(void)setSelectCategory:(ShopProductData*)product
{
    NSIndexPath* path = [NSIndexPath indexPathForRow:2 inSection:0];
    AddProductTwoLabelCell* cell = (AddProductTwoLabelCell*)[_table cellForRowAtIndexPath:path];
    
    NSString* cateName = nil;
    if (product.subCateName&&product.categoryName)
    {
        cateName = [NSString stringWithFormat:@"%@-%@",product.categoryName,product.subCateName];
        _editData.categoryID = product.subCateID;
    }
    else if (product.categoryName) {
        cateName = product.categoryName;
        _editData.categoryID = product.categoryID;
    }
    
    else
    {   _editData.categoryID = product.subCateID;
        cateName = product.subCateName;
    }
    
    UILabel* second = [cell getSecondLabel];
    second.text = cateName;
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
//  清除缓存
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    [manager diskImageRemoveForURL:[NSURL URLWithString:_productData.pUrl]];
    
    self.infoChange = YES;
    UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _thumbImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200) and:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            NSIndexPath* path = [NSIndexPath indexPathForRow:4 inSection:0];
            AddProductPictureCell* cell = (AddProductPictureCell*)[_table cellForRowAtIndexPath:path];
            
            [cell setProductImage:_thumbImage];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
