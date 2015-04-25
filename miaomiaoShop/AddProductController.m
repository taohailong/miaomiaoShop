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
@interface AddProductController()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
//    IBOutlet UIScrollView* _scroll;
    IBOutlet NSLayoutConstraint* _bottomLay;
    IBOutlet    UITableView*_table;
}

@end
@implementation AddProductController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self registeNotificationCenter];
//    _table.tableFooterView = [self loadPictureView];
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
//    NSString* cID = @"";
    UITableViewCell* cell = nil;
    __weak AddProductController* wSelf = self;
    if (indexPath.row==0) {
      cell= [tableView dequeueReusableCellWithIdentifier:@"1"];
        if (cell==nil) {
            cell = [[AddProductFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1" WithBlock:^{
                
            }];
        }
      
    }
    else if(indexPath.row==1)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:@"2"];
        if (cell==nil) {
            cell = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2"];
        }

         cell.textLabel.text = @"名称:";
    }
    else if(indexPath.row ==2)
   {
       cell= [tableView dequeueReusableCellWithIdentifier:@"3"];
       if (cell==nil) {
           cell = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3"];
       }

       cell.textLabel.text = @"价格:";

    }
    else if (indexPath.row==3)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:@"4"];
        if (cell==nil) {
           AddProductSwithCell* sCell = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"4"];
            
            [sCell setSwitchBlock:^{
                
            }];
            cell = sCell;
            
        }
        

        cell.textLabel.text = @"销售状态:";

    }
    else if (indexPath.row==4)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:@"5"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"5"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"分类:";
        cell.textLabel.font = [UIFont systemFontOfSize:14];

    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"6"];
        if (cell==nil) {
            AddProductPictureCell* pCell = [[AddProductPictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"6"];
            [pCell setPhotoBlock:^{
                
              [wSelf setUpPhoto];
            }];
            cell = pCell;
        }
        
    }
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
//    [self.navigationController pushViewController:picker animated:YES];

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

//-(void)initSubView
//{
//    UILabel* tiaoMaL = [[UILabel alloc]init];
//    tiaoMaL.translatesAutoresizingMaskIntoConstraints = NO;
//    tiaoMaL.text = @"";
//    [_scroll addSubview:tiaoMaL];
//    
//    [_scroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tiaoMaL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tiaoMaL)]];
//    [_scroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tiaoMal]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tiaoMaL)]];
//    
//    
//    
//    
//}
@end
