//
//  ShopInfoViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoViewController.h"
#import "AddProductCommonCell.h"
#import "AddProductSwithCell.h"
#import "DatePickerView.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
@interface ShopInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    __weak UITextField* _currentField;
}
@property(nonatomic,assign)BOOL isInfoChanged;
@end

@implementation ShopInfoViewController
@synthesize isInfoChanged;
-(id)initWithShopInfoData:(ShopInfoData*)data
{
    self = [super init];
    _shopData = data;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_table]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
     NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:bottom];
    
    UIBarButtonItem* rigtBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(updateShopInfo)];
    self.navigationItem.rightBarButtonItem = rigtBar;
    
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(manualBack)];
    self.navigationItem.leftBarButtonItem = leftBar;

    
    
    if (_shopData.openTime) {
        [self creatTableFootView];
    }
    [self registeNotificationCenter];
    // Do any additional setup after loading the view.
}


-(void)manualBack
{
    
    if (self.isInfoChanged) {
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
    
    [self updateShopInfo];
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
    
    [def addObserver:self selector:@selector(textFieldBeginChange:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}


- (void)keyboardShown:(NSNotification *)aNotification
{
    
    NSDictionary *info = [aNotification userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGSize keyboardSize = [aValue CGRectValue].size;
    [self accessViewAnimate:-keyboardSize.height];
    
}

-(void)textFieldBeginChange:(NSNotification*)notic
{
    _currentField = (UITextField*)notic.object;
//    NSLog(@"notic %@",notic.object);
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

       
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark----------Noticfic－－－－－－－

-(void)checkDataAndFill
{
    [_currentField resignFirstResponder];
//    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
//   
//    AddProductCommonCell* cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
//    [cell registeFirstRespond];
////    _shopData.shopName = [cell getTextFieldString];
//    
//    
//    path = [NSIndexPath indexPathForRow:1 inSection:0];
//    cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
////    _shopData.shopAddress = [cell getTextFieldString];
//    [cell registeFirstRespond];
//    
//    path = [NSIndexPath indexPathForRow:2 inSection:0];
//    cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
////    _shopData.minPrice = [[cell getTextFieldString] floatValue];
//    [cell registeFirstRespond];
//    
//    path = [NSIndexPath indexPathForRow:3 inSection:0];
//    cell = (AddProductCommonCell*)[_table cellForRowAtIndexPath:path];
////    _shopData.serveArea = [cell getTextFieldString];
//   [cell registeFirstRespond];
//   
}




-(void)updateShopInfo
{
    [self checkDataAndFill];
    __weak ShopInfoViewController* wself = self;
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopInfoUpdateWithShopInfoData:_shopData WithBk:^(id backDic, NSError *error) {
        
        NSString* str = nil;
        if (backDic) {
            
            [wself.navigationController popViewControllerAnimated:YES];
            str = @"添加成功！";
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak ShopInfoViewController* wSelf = self;
    __weak ShopInfoData* wShopData = _shopData;
    if (indexPath.row==0) {
        AddProductCommonCell* cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell1==nil) {
            cell1 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1" WithFieldBk:^(NSString *text) {
                wSelf.isInfoChanged = YES;
                wShopData.shopName = text;
            }];
            [cell1 setTextTitleLabel:@"店名"];
            [cell1 setTextField:wShopData.shopName];
        }
        return cell1;
    }
    else if (indexPath.row==1) {
        AddProductCommonCell* cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2==nil) {
            cell2 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2" WithFieldBk:^(NSString *text) {
                 wSelf.isInfoChanged = YES;
                wShopData.shopAddress = text;
            }];
            [cell2 setTextTitleLabel:@"店地址"];
            [cell2 setTextField:wShopData.shopAddress];
        }
        return cell2;
    }
    else if (indexPath.row==2) {
        AddProductCommonCell* cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (cell3==nil) {
            cell3 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3" WithFieldBk:^(NSString *text) {
                 wSelf.isInfoChanged = YES;
                wShopData.minPrice = [text floatValue];
            }];
            [cell3 setTextTitleLabel:@"起送价格¥"];
            [cell3 setTextField:[NSString stringWithFormat:@"%.1f",wShopData.minPrice]];
        }
        return cell3;
    }
    else if (indexPath.row==3) {
        AddProductCommonCell* cell4 = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (cell4==nil) {
            cell4 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4" WithFieldBk:^(NSString *text) {
                 wSelf.isInfoChanged = YES;
                wShopData.serveArea = text;
            }];
            [cell4 setTextTitleLabel:@"服务范围"];
            [cell4 setTextField:wShopData.serveArea];

        }
        return cell4;
    }
    else if (indexPath.row==4) {
        AddProductCommonCell* cell5 = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
        if (cell5==nil) {
            cell5 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5" WithFieldBk:^(NSString *text) {
                 wSelf.isInfoChanged = YES;
                wShopData.telPhoneNu = text;
            }];
            [cell5 setFieldKeyboardStyle:UIKeyboardTypeNumberPad];
            [cell5 setTextTitleLabel:@"店铺座机"];
            [cell5 setTextField:wShopData.telPhoneNu];
        }
        return cell5;
    }
    else if (indexPath.row==5) {
        AddProductCommonCell* cell6 = [tableView dequeueReusableCellWithIdentifier:@"cell6"];
        if (cell6==nil) {
            cell6 = [[AddProductCommonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell6" WithFieldBk:^(NSString *text) {
                 wSelf.isInfoChanged = YES;
                wShopData.mobilePhoneNu = text;
            }];
            [cell6 setFieldKeyboardStyle:UIKeyboardTypeNumberPad];
            [cell6 setTextTitleLabel:@"老板电话"];
            [cell6 setTextField:wShopData.mobilePhoneNu];
        }
        return cell6;
    }
    else if (indexPath.row==6) {
        AddProductSwithCell* cell7 = [tableView dequeueReusableCellWithIdentifier:@"cell7"];
        if (cell7==nil) {
            cell7 = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell7"];
            __weak AddProductSwithCell* wCell = cell7;
            [cell7 setSwitchBlock:^(BOOL statue) {
                
                if (statue) {
                   wCell.textLabel.text = @"营业管理:营业中";
                }
                else
                {
                   wCell.textLabel.text = @"营业管理:打烊";
                }
                 wSelf.isInfoChanged = YES;
                wShopData.shopStatue = statue;
            }];
            [cell7 setSWitchStatue:wShopData.shopStatue];
            
            if (wShopData.shopStatue) {
                cell7.textLabel.text = @"营业管理:营业中";
            }
            else
            {
                cell7.textLabel.text = @"营业管理:打烊";
            }


        }
        return cell7;
    }
    else  {
        AddProductSwithCell* cell8 = [tableView dequeueReusableCellWithIdentifier:@"cell8"];
        if (cell8==nil) {
            cell8 = [[AddProductSwithCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell8" ];
            cell8.textLabel.text = @"营业时间24小时" ;
            [cell8 setSwitchBlock:^(BOOL statue) {
                if (statue) {
                    [wSelf creatTableFootView];
                }
                else
                {
                    [wSelf removeTableFootView];
                }
                 wSelf.isInfoChanged = YES;
            }];
            if (_shopData.openTime) {
                [cell8 setSWitchStatue:0];
            }
            else
            {
                [cell8 setSWitchStatue:1];
            }
        }
        return cell8;
    }
}


-(void)creatTableFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    footView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240/255.0 alpha:1.0];
    
    UIButton* closeBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    NSString* closeStr = nil;
    if (_shopData.closeTime) {
        closeStr = [NSString stringWithFormat:@"关门时间: %@",_shopData.closeTime] ;
    }
    else
    {
        closeStr = [NSString stringWithFormat:@"关门时间: 22:00"] ;
        _shopData.closeTime = @"22:00";
    }
    
    [closeBt setTitle:closeStr forState:UIControlStateNormal];
    closeBt.translatesAutoresizingMaskIntoConstraints = NO;
    [footView addSubview:closeBt];
    [closeBt addTarget:self action:@selector(selectCloseTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:closeBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:closeBt attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0]];
    
    
    UIButton * openBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    openBt.translatesAutoresizingMaskIntoConstraints  = NO;
    
    NSString* openStr = nil;
    if (_shopData.openTime) {
        openStr = [NSString stringWithFormat:@"开门时间: %@",_shopData.openTime] ;
    }
    else
    {
        openStr = [NSString stringWithFormat:@"开门时间: 08:00"] ;
        _shopData.openTime = @"08:00";
    }

    [openBt setTitle:openStr forState:UIControlStateNormal];
    [footView addSubview:openBt];
    [openBt addTarget:self action:@selector(selectOpenTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:openBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [footView addConstraint:[NSLayoutConstraint constraintWithItem:openBt attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:footView attribute:NSLayoutAttributeCenterX multiplier:.5 constant:0]];
    
    _table.tableFooterView = footView;
}

-(void)removeTableFootView
{
    _table.tableFooterView = nil;
    _shopData.closeTime = nil;
    _shopData.openTime = nil;
}


-(void)selectCloseTime:(UIButton*)sender
{
    [self creatPickerView:sender];
}

-(void)selectOpenTime:(UIButton*)sender
{
    sender.tag = 1;
    [self creatPickerView:sender];
}


-(void)creatPickerView:(UIButton*)bt
{
     self.isInfoChanged = YES;
    __weak ShopInfoData* wData = _shopData;
    DatePickerView* picker = [[DatePickerView alloc]initWithDateSelectComplete:^(NSString *dateStr) {
        
        if (bt.tag) {
            [bt setTitle:[NSString stringWithFormat:@"开门时间: %@",dateStr] forState:UIControlStateNormal];
            wData.openTime =  dateStr;
        }
        else
        {
            [bt setTitle:[NSString stringWithFormat:@"关门时间: %@",dateStr] forState:UIControlStateNormal];
            wData.closeTime = dateStr;
        }
        
    }];
    picker.translatesAutoresizingMaskIntoConstraints = NO;
    //    _table.tableFooterView = picker;
    [self.view addSubview:picker];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(picker)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(picker)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:picker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0]];
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
