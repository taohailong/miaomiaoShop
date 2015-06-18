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
//    ShopProductData* _productData;
//    UITableView* _table;
}
@end

@implementation ProductEditController

-(id)initWithProductData:(ShopProductData*)data
{
    self = [super init];
    
    _productData = data;
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [_table reloadData];
   
}

-(void)commitProductInfo
{
    [super commitProductInfo];
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
    [request shopProductUpdateWithProduct:_productData WithBk:^(id backDic, NetWorkStatus status) {
        
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==4) {
        return 120;
    }
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
    __weak AddProductController* wSelf = self;
    __weak ShopProductData* wData = _productData;
      if(indexPath.row==0)
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
    else if(indexPath.row ==1)
    {
        AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"3"];
        if (cell3==nil) {
            cell3 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3" WithFieldBk:^(NSString *text) {
                 wSelf.infoChange = YES;
                wData.price = [text floatValue];
            }];
        }
        [cell3 setTextTitleLabel:@"价格:"]  ;
        [cell3 setTextField:[NSString stringWithFormat:@"%.2f", _productData.price]];
        cell = cell3;
    }
    else if (indexPath.row==2)
    {
        AddProductSwithCell* cell4 = [tableView dequeueReusableCellWithIdentifier:@"4"];
        if (cell4==nil) {
            cell4 = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"4"];
            
            [cell4 setSwitchBlock:^(BOOL statue) {
                wData.status = statue;
                 wSelf.infoChange = YES;
            }];
        }
        [cell4 setSWitchStatue:_productData.status];
        cell4.textLabel.text = @"销售状态:";
        cell = cell4;
    }
    else if (indexPath.row==3)
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
    if (indexPath.row ==3) {
        
        __weak ProductEditController* wSelf = self;
        CategorySelectController* cateView = [[CategorySelectController alloc]initWithCompleteBk:^(NSString *categoryID, NSString *categoryName) {
            [wSelf  setCategoryWithID:categoryID WithName:categoryName];
        }];
        [self.navigationController pushViewController:cateView animated:YES];
    }
}

-(void)setCategoryWithID:(NSString*)cateID WithName:(NSString*)name
{
    self.infoChange = YES;
    NSIndexPath* path = [NSIndexPath indexPathForRow:3 inSection:0];
    UITableViewCell* cell = [_table cellForRowAtIndexPath:path];
    cell.textLabel.text = [NSString stringWithFormat:@"分类：%@",name];
    _productData.categoryID = cateID;
    _productData.categoryName = name;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
