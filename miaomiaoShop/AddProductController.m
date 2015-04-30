//
//  AddProductController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductController.h"
#import "AddProductFirstCell.h"
#import "AddProductSwithCell.h"
#import "AddProductCommonCell.h"
#import "AddProductPictureCell.h"
#import "UIImage+ZoomImage.h"
#import "ScanViewController.h"
#import "NetWorkRequest.h"
#import "ShopProductData.h"
#import "THActivityView.h"
@interface AddProductController()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ScanProtocol>
{
//    IBOutlet UIScrollView* _scroll;
    IBOutlet NSLayoutConstraint* _bottomLay;
    IBOutlet    UITableView*_table;
    ShopProductData* _productData;
    NetWorkRequest* _postAsi;
}

@end
@implementation AddProductController

//-(id)initWithProductData:(ShopProductData*)data
//{
//    self = [super init];
//    
//    
//    return self;
//}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self registeNotificationCenter];
    [self setExtraCellLineHidden:_table];
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitProductInfo)];
    self.navigationItem.rightBarButtonItem = rightBar;
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
        
        [self.view removeConstraint: _bottomLay];
        NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:height];
        _bottomLay = bottom;
        [self.view addConstraint:_bottomLay];
        [self.view layoutIfNeeded];
        
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
    if (indexPath.row==0)
    {
      AddProductFirstCell* cell1 = [tableView dequeueReusableCellWithIdentifier:@"1"];
        if (cell1==nil)
        {
            cell1 = [[AddProductFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1" WithBlock:^{
                [wSelf setUpScanViewController];
            }];
        }
        [cell1 setTextField:_productData.scanNu];
        cell = cell1;
    }
    else if(indexPath.row==1)
    {
        AddProductCommonCell* cell2= [tableView dequeueReusableCellWithIdentifier:@"2"];
        if (cell2==nil) {
            cell2 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2"];
        }
        [cell2 setTextField:_productData.pName];
         cell2.textLabel.text = @"名称:";
        cell = cell2;
    }
    else if(indexPath.row ==2)
   {
       AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"3"];
       if (cell3==nil) {
           cell3 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3"];
       }
       cell3.textLabel.text = @"价格:";
        [cell3 setTextField:[NSString stringWithFormat:@"%.1f", _productData.price]];
       cell = cell3;
    }
    else if (indexPath.row==3)
    {
        AddProductSwithCell* cell4 = [tableView dequeueReusableCellWithIdentifier:@"4"];
        if (cell4==nil) {
           cell4 = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"4"];
            
            [cell4 setSwitchBlock:^{
                
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
        UIImage* thumbImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200) and:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath* path = [NSIndexPath indexPathForRow:5 inSection:0];
            AddProductPictureCell* cell = (AddProductPictureCell*)[_table cellForRowAtIndexPath:path];
            
            [cell setProductImage:thumbImage];
        });
    });
    
}

-(void)setUpScanViewController
{
    ScanViewController* scan = [[ScanViewController alloc]init];
    scan.delegate = self;
    [self presentViewController:scan animated:YES completion:^{
        
    }];

}

-(void)scanActionCompleteWithResult:(NSString *)string
{
    [self getProductDataThroughScanNu:string];

}


-(void)commitProductInfo
{
    NSIndexPath* path = [NSIndexPath indexPathForRow:5 inSection:0];
    AddProductPictureCell* cell = (AddProductPictureCell*)[_table cellForRowAtIndexPath:path];
    UIImage* thumbImage = [cell getProductImage];
   [self postUpImageWithImage:thumbImage];
    
    
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopAddProductInfoToServeWith:_productData WithBk:^(id backDic, NSError *error) {
        NSLog(@"%@",backDic);
    }];
    [request startAsynchronous];
}


-(void)postUpImageWithImage:(UIImage*)image
{
    _postAsi = [[NetWorkRequest alloc]init];
    [_postAsi shopProductImagePostWithImage:UIImageJPEGRepresentation(image, 1.0) WithScanNu:_productData.scanNu WithBk:^(id backDic, NSError *error) {
        NSLog(@"%@",backDic);
    }];
}


-(void)getProductDataThroughScanNu:(NSString*)string
{
    THActivityView* alert = [[THActivityView alloc]initActivityViewWithSuperView:self.view];

    NetWorkRequest* requ = [[NetWorkRequest alloc]init];
    [requ shopScanProductWithSerial:string WithBk:^(ShopProductData* backDic, NSError *error) {
        if (backDic) {
            _productData = backDic;
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
