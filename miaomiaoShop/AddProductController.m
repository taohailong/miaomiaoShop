//
//  AddProductController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductController.h"

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
    self.infoChange = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];

    
    [self registeNotificationCenter];
    [self setExtraCellLineHidden:_table];

    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitProductInfo)];
    
    UIButton* bt = [UIButton buttonWithType:UIButtonTypeCustom] ;
    bt.frame = CGRectMake(0, 0, 25, 25);
    [bt  addTarget:self action:@selector(setUpScanViewController) forControlEvents:UIControlEventTouchUpInside];
    [bt setImage:[UIImage imageNamed:@"ProductEditScan"] forState:UIControlStateNormal];
    
    
    UIBarButtonItem* rightBar1 = [[UIBarButtonItem alloc]initWithCustomView:bt];
    
    self.navigationItem.rightBarButtonItems = @[rightBar,rightBar1];
    
    
    
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(manualBack)];
    self.navigationItem.leftBarButtonItem = leftBar;

}



-(void)manualBack
{
    
    if (self.infoChange) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要提交信息吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else
    {
       [self.navigationController popViewControllerAnimated:YES];
    }
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5) {
        return 120;
    }
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
    __weak AddProductController* wSelf = self;
    __weak ShopProductData* wData = _productData;
    if (indexPath.row==0)
    {
      AddProductFirstCell* cell1 = [tableView dequeueReusableCellWithIdentifier:@"1"];
        if (cell1==nil)
        {
            cell1 = [[AddProductFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1" WithBlock:^{
                [wSelf manualFillScanNu];
            } WithFieldBk:^(NSString *text) {
                wData.scanNu = text;
                wSelf.infoChange = YES;
            }];
        }
        [cell1 setTextField:_productData.scanNu];
        cell = cell1;
    }
    else if(indexPath.row==1)
    {
        AddProductCommonCell* cell2= [tableView dequeueReusableCellWithIdentifier:@"2"];
        if (cell2==nil) {
            cell2 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2" WithFieldBk:^(NSString *text) {
                wData.pName = text;
                wSelf.infoChange = YES;
            }];
        }
        [cell2 setTextField:_productData.pName];
         [cell2 setTextTitleLabel:@"名称:"]  ;
        cell = cell2;
    }
    else if(indexPath.row ==2)
   {
       AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"3"];
       if (cell3==nil) {
           cell3 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3" WithFieldBk:^(NSString *text) {
               wData.price = [text floatValue];
               wSelf.infoChange = YES;
           }];
        
       }
       [cell3 setFieldKeyboardStyle:UIKeyboardTypeDecimalPad];
        [cell3 setTextTitleLabel:@"价格:"]  ;
        [cell3 setTextField:[NSString stringWithFormat:@"%.2f", _productData.price]];
       cell = cell3;
    }
    else if (indexPath.row==3)
    {
        AddProductSwithCell* cell4 = [tableView dequeueReusableCellWithIdentifier:@"4"];
        if (cell4==nil) {
           cell4 = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"4"];
            
            [cell4 setSwitchBlock:^(BOOL statue) {
                wData.status =statue;
                wSelf.infoChange = YES;
            }];
        }
        [cell4 setSWitchStatue:_productData.status];
        cell4.textLabel.text = @"销售状态:";
        cell = cell4;
    }
    else if (indexPath.row==4)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:@"5"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"5"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_productData.categoryName) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"分类:%@",_productData.categoryName];
        }
        else
        {
           cell.textLabel.text = @"分类:";
        }
    }
    else
    {
        AddProductPictureCell* cell6 = [tableView dequeueReusableCellWithIdentifier:@"6"];
        if (cell6==nil) {
            cell6 = [[AddProductPictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"6"];
            [cell6 setPhotoBlock:^{
              [wSelf setUpPhoto];
            }];
            
        }
        [cell6 setProductImageWithUrl:_productData.pUrl];
        cell = cell6;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==4) {
        
        __weak AddProductController* wSelf = self;
        CategorySelectController* cateView = [[CategorySelectController alloc]initWithCompleteBk:^(NSString *categoryID, NSString *categoryName) {
            
            [wSelf  setCategoryWithID:categoryID WithName:categoryName];
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



-(void)setCategoryWithID:(NSString*)cateID WithName:(NSString*)name
{
    self.infoChange = YES;
    NSIndexPath* path = [NSIndexPath indexPathForRow:4 inSection:0];
    UITableViewCell* cell = [_table cellForRowAtIndexPath:path];
    cell.textLabel.text = [NSString stringWithFormat:@"分类：%@",name];
    _productData.categoryID = cateID;
    _productData.categoryName = name;
}


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
    self.infoChange = YES;

    UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _thumbImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200) and:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath* path = [NSIndexPath indexPathForRow:5 inSection:0];
            AddProductPictureCell* cell = (AddProductPictureCell*)[_table cellForRowAtIndexPath:path];
            
            [cell setProductImage:_thumbImage];
        });
    });
    
}

-(void)setUpScanViewController
{
    if (!IOS_VERSION_5_OR_ABOVE) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"ios7以下暂时不能使用该功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    ScanViewController* scan = [[ScanViewController alloc]init];
    scan.delegate = self;
    [self presentViewController:scan animated:YES completion:^{
        
    }];

}

#pragma mark------------scanDelegate---------------
-(void)scanActionCompleteWithResult:(NSString *)string
{
    [self getProductDataThroughScanNu:string];

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

//-(void)checkDifference
//{
//    NSIndexPath* path = [NSIndexPath indexPathForRow:1 inSection:0];
//    AddProductCommonCell* cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
//    _productData.pName = [cell getTextFieldString];
//    
//    
//    path = [NSIndexPath indexPathForRow:2 inSection:0];
//    cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
//    _productData.price = [[cell getTextFieldString] floatValue];
//}



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


-(void)getProductDataThroughScanNu:(NSString*)string
{
    THActivityView* alert = [[THActivityView alloc]initActivityViewWithSuperView:self.view];

    NetWorkRequest* requ = [[NetWorkRequest alloc]init];
    [requ shopScanProductWithSerial:string WithBk:^(ShopProductData* backDic, NetWorkStatus status) {
        
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
        [alert removeFromSuperview];
    }];
    [requ startAsynchronous];
}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
@end
