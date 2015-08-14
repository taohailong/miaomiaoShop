//
//  AddProductController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductController.h"
#import "AddProductTwoLabelCell.h"
#import "UIImage+ZoomImage.h"
#import "ScanViewController.h"
#import "NetWorkRequest.h"
#import "ShopProductData.h"
#import "THActivityView.h"
#import "CategorySelectController.h"


@interface AddProductController()<ScanProtocol,UIAlertViewDelegate>
{
//    IBOutlet UIScrollView* _scroll;
//    BOOL _isChange;
    NetWorkRequest* _postAsi;
}

@end
@implementation AddProductController
@synthesize infoChange;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    _productData = [[ShopProductData alloc]init];
    return self;
}


-(id)init
{
    self= [super init];
    _productData = [[ShopProductData alloc]init];
    _productData.status = 1;
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"添加商品";
    
    self.view.backgroundColor = [UIColor whiteColor];
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
        [_table setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_table setLayoutMargins:UIEdgeInsetsZero];
    }

    
    _table.backgroundColor = FUNCTCOLOR(247, 247, 247);
    _table.separatorColor = FUNCTCOLOR(221, 221, 221);
    [_table registerClass:[AddProductCommonCell class] forCellReuseIdentifier:@"AddProductCommonCell"];
    [_table registerClass:[AddProductFirstCell class] forCellReuseIdentifier:@"AddProductFirstCell"];
    [_table registerClass:[AddProductPictureCell class] forCellReuseIdentifier:@"AddProductPictureCell"];
    
    [_table registerClass:[AddProductTwoLabelCell class] forCellReuseIdentifier:@"AddProductTwoLabelCell"];
    
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-55]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];

    
    [self registeNotificationCenter];
    [self setExtraCellLineHidden:_table];
    [self creatBottomBt];

}

#pragma mark- bottomBt


-(void)creatBottomBt
{
    UIButton* rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setTitle:@"保存" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
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
    [leftBt addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_table attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBt]-0-[rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt,rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt)]];
    
    [leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLighter"] forState:UIControlStateNormal];
}


-(void)saveAction
{
    if (_productData.categoryID==nil) {
        
        THActivityView* loadView = [[THActivityView alloc]initWithString:@"请选择分类"];
        [loadView show];
        return;
    }
    
    [self networkRequestApi];
}

-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.cancelButtonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }
    
    [self commitProductInfo];
}



-(void)setCompleteBk:(AddEditProduct)bk
{
    _completeBk = bk;
}
-(void)registeNotificationCenter
{
    /*注册成功后  重新链接服务器*/
    
    NSNotificationCenter *def = [NSNotificationCenter defaultCenter];
    
    /* 注册键盘的显示/隐藏事件 */
    [def addObserver:self selector:@selector(keyboardShown:)
                name:UIKeyboardWillShowNotification
											   object:nil];
    
    
    [def addObserver:self selector:@selector(keyboardHidden:)name:UIKeyboardWillHideNotification
											   object:nil];
    
}


- (void)keyboardShown:(NSNotification *)aNotification
{
    
    NSDictionary *info = [aNotification userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGSize keyboardSize = [aValue CGRectValue].size;
    [self accessViewAnimate:-keyboardSize.height];
    
}


- (void)keyboardHidden:(NSNotification *)aNotification
{
    
    [self accessViewAnimate:0.0];
}

-(void)accessViewAnimate:(float)height
{
    
    [UIView animateWithDuration:.2 delay:0 options:0 animations:^{
        
        for (NSLayoutConstraint * constranint in self.view.constraints) {
            if (constranint.firstItem==_table&&constranint.firstAttribute==NSLayoutAttributeBottom) {
                constranint.constant = height;
            }
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}



-(UIView*)loadPictureView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    UILabel* label = [[UILabel alloc]init];
    label.text = @"照片";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [footView addSubview:label];
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    [footView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    return footView;
}


#pragma mark-tableView-

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 45;
    }
    return 58;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
    __weak AddProductController* wSelf = self;
    __weak ShopProductData* wData = _productData;
    
    if (indexPath.section == 1) {
        AddProductPictureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductPictureCell"];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }

        
        [cell setPhotoBlock:^{
                [wSelf setUpPhoto];
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
        field.returnKeyType = UIReturnKeySearch;
    
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

        [cell2 setTextField:_productData.pName];
        [cell2 setTextTitleLabel:@"商品名称"]  ;
        return cell2;
    }
    else if(indexPath.row ==3)
   {
       AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"AddProductCommonCell"];
       
       [cell3 setTextFieldBk:^(NSString *text) {
           wData.price = [text floatValue];
       }];
       UITextField* field = [cell3  getTextField];
       field.placeholder = @"请输入价格";

       [cell3 setFieldKeyboardStyle:UIKeyboardTypeDecimalPad];
       [cell3 setTextTitleLabel:@"商品售价"];
       if (_productData.price) {
          [cell3 setTextField:[NSString stringWithFormat:@"%.1f", _productData.price]];
       }
       return cell3;
    }
    else
    {
        AddProductTwoLabelCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductTwoLabelCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel* first = [cell getFirstLabel];
        UILabel* second = [cell getSecondLabel];
        first.text = @"商品分类";
        if (_productData.categoryName) {
            second.text = [NSString stringWithFormat:@"%@-%@",_productData.categoryName,_productData.subCateName];
        }
        
        return cell ;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2) {
        
        __weak AddProductController* wSelf = self;
        CategorySelectController* cateView = [[CategorySelectController alloc]initWithCompleteBk:^(ShopProductData* product) {
            [wSelf  setSelectCategory:product];
        }];
        [self.navigationController pushViewController:cateView animated:YES];
    }
}


-(void)manualFillScanNu
{
    if (_productData.scanNu.length) {
        [self getProductDataThroughScanNu:_productData.scanNu];
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
        _productData.categoryID = _productData.subCateID;
    }
    else if (product.categoryName) {
        cateName = product.categoryName;
        _productData.categoryID = _productData.categoryID;
    }
    
    else
    {   _productData.categoryID = _productData.subCateID;
        cateName = product.subCateName;
    }
    
    UILabel* second = [cell getSecondLabel];
    second.text = cateName;
}


#pragma mark-ImagePicker

-(void)setUpPhoto
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.allowsEditing=NO;
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.delegate=self;
//    picker.UIImagePickerControllerQualityTypeLow
    
    
    [self.navigationController presentViewController:picker animated:YES completion:^{}];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

    UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _thumbImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200) and:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:1];
            AddProductPictureCell* cell = (AddProductPictureCell*)[_table cellForRowAtIndexPath:path];
            
            [cell setProductImage:_thumbImage];
        });
    });
    
}


#pragma mark------------scanDelegate---------------

-(void)setUpScanViewController
{
    if (!IOS_VERSION_5_OR_ABOVE) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"ios7以下暂时不能使用该功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    ScanViewController* scan = [[ScanViewController alloc]init];
    scan.delegate = self;
    [self presentViewController:scan animated:YES completion:^{}];
}


-(void)scanActionCompleteWithResult:(NSString *)string
{
    [self getProductDataThroughScanNu:string];

}

-(void)getProductDataThroughScanNu:(NSString*)string
{
    THActivityView* alert = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    
    NetWorkRequest* requ = [[NetWorkRequest alloc]init];
    [requ shopScanProductWithSerial:string WithBk:^(ShopProductData* backDic, NetWorkStatus status) {
        
        [alert removeFromSuperview];
        if (status == NetWorkStatusSuccess) {
            _productData.pName = backDic.pName;
            _productData.pID = backDic.pID;
            //            _productData.categoryID = backDic.categoryID;
            //            _productData.categoryName = backDic.categoryName;
            _productData.pUrl = backDic.pUrl;
            _productData.count = backDic.count;
            _productData.price = backDic.price;
            //            _productData.status = backDic.status;
            _productData.scanNu = backDic.scanNu;
            //            _productData = backDic;
            [_table reloadData];
        }
        
    }];
    [requ startAsynchronous];
}





-(void)commitProductInfo
{
    if (_productData.categoryID==nil) {
        
        THActivityView* alert = [[THActivityView alloc]initWithString:@"请选择分类"];
        [alert show];
        
        return;
    }
    
    __weak ShopProductData* wPdata = _productData;
    __weak AddProductController* wself = self;
    if (_thumbImage==nil) {
        
//        [self checkDifference];
        [self networkRequestApi];
        return;
    }
    
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
   [self postUpImageWithImage:_thumbImage WithBk:^(NSString *url) {
       wPdata.pUrl = url;
       [wself networkRequestApi];
       [activeV removeFromSuperview];
   }];
    
 }



-(void)networkRequestApi
{
    __weak AddProductController* wSelf = self;
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopAddProductInfoToServeWith:_productData WithBk:^(id backDic, NetWorkStatus status) {
        
        NSString* str = nil;
        if (status == NetWorkStatusSuccess) {
            str = @"添加成功！";
            [wSelf commitCompleteBack];
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



-(void)commitCompleteBack
{
    if (_completeBk) {
        _completeBk();
    }
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)postUpImageWithImage:(UIImage*)image WithBk:(void(^)(NSString * url))complete
{
    _postAsi = [[NetWorkRequest alloc]init];
    [_postAsi shopProductImagePostWithImage:UIImageJPEGRepresentation(image, 1.0) WithScanNu:_productData.scanNu WithBk:^(id backDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess) {
            
            complete(backDic[@"data"][@"url"]);
        }
        else
        {
        
            THActivityView* warnView = [[THActivityView alloc]initWithString:@"图片上传失败"];
            [warnView show];
        }
        NSLog(@"%@",backDic);
    }];
}




- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
@end
