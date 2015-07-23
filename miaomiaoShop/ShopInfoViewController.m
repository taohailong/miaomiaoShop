//
//  ShopInfoViewController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoViewController.h"
//#import "AddProductCommonCell.h"
//#import "AddProductSwithCell.h"

#import "ShopNameChangeController.h"
#import "DatePickerView.h"
#import "NetWorkRequest.h"
#import "THActivityView.h"
#import "NSString+ZhengZe.h"
#import "ShopInfoHeadCell.h"
#import "ShopInfoSubCell.h"
#import "ShopInfoThreeLCell.h"
#import "ShopInfoTimeSetCell.h"
#import "AddProductSwithCell.h"

@interface ShopInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,ShopNameChangeProtocol>
{
    UITableView* _table;
    __weak UITextField* _currentField;
    UIView* _inputView;
    __weak UIView* _picker;
//    UIToolbar* _inputAccessoryView;
//    UIpi*
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
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
        [_table setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_table setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        _table.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }

    [_table registerClass:[AddProductSwithCell class] forCellReuseIdentifier:@"AddProductSwithCell"];
    [_table registerClass:[ShopInfoHeadCell class] forCellReuseIdentifier:@"ShopInfoHeadCell"];
    
    [_table registerClass:[ShopInfoSubCell class] forCellReuseIdentifier:@"ShopInfoSubCell"];
    
    [_table registerClass:[ShopInfoThreeLCell class] forCellReuseIdentifier:@"ShopInfoThreeLCell"];
    
    [_table registerClass:[ShopInfoTimeSetCell class] forCellReuseIdentifier:@"ShopInfoTimeSetCell"];
    
    
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_table]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    
     NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:_table attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:bottom];
    
    
    
//    UIBarButtonItem* rigtBar = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(updateShopInfo)];
//    self.navigationItem.rightBarButtonItem = rigtBar;
//    
//    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(manualBack)];
////    self.navigationItem.backBarButtonItem = nil;
//    self.navigationItem.leftBarButtonItem = leftBar;
////    [self.navigationItem.backBarButtonItem add]
    
    [self creatTableFootView];
//    [self registeNotificationCenter];
    
    
    
//    NSLog(@"%d",self.navigationController.interactivePopGestureRecognizer.enabled);
//     self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    
    // Do any additional setup after loading the view.
}

#pragma mark-------------------pushGesture------------------

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    // fix 'nested pop animation can result in corrupted navigation bar'
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}
//
//
//- (void)navigationController:(UINavigationController *)navigationController
//       didShowViewController:(UIViewController *)viewController
//                    animated:(BOOL)animated
//{
//    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//}


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

-(BOOL)checkDataAndFill
{
    [_currentField resignFirstResponder];
    
    if (![NSString verifyIsMobilePhoneNu:_shopData.mobilePhoneNu])
    {
        THActivityView* showView = [[THActivityView alloc]initWithString:@"手机号格式不正确"];
        [showView show];
        return NO;
    }
    
//    if (![NSString verifyisTelPhone:_shopData.telPhoneNu])
//    {
//        THActivityView* showView = [[THActivityView alloc]initWithString:@"电话格式不正确"];
//        [showView show];
//        return NO;
//    }

    return YES;
}




-(void)updateShopInfo
{
//    __weak ShopInfoViewController* wself = self;
    __weak UITableView* wtable = _table;
    THActivityView* activeV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    NetWorkRequest* request = [[NetWorkRequest alloc]init];
    [request shopInfoUpdateWithShopInfoData:_shopData WithBk:^(id backDic, NetWorkStatus status) {
        
        NSString* str = nil;
        if (status == NetWorkStatusSuccess) {
            [wtable reloadData];
            str = @"修改成功！";
        }
        else
        {
            str = backDic;
        }
        THActivityView* show = [[THActivityView alloc]initWithString:str];
        [show show];
        [activeV removeFromSuperview];

    }];
    [request startAsynchronous];
}


#pragma mark-TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1) {
        return 2;
    }
    else
    {
        return 1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70;
        }
        else
        {
            return 50;
        }
    }
    else if(indexPath.section == 1)
    {
        return 45;
    }
    else
    {
        return 100 ;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
       
        if (indexPath.row == 0) {
           
            ShopInfoHeadCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInfoHeadCell"];
            [cell setHeadLabelStr:_shopData.shopName];
            [cell setCellImage:@"shopInfo_modifyImage"];
            return cell;
        }
        else
        {
            ShopInfoSubCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInfoSubCell"];
            [cell setLeftLabelStr:[NSString stringWithFormat:@"%.2f",_shopData.minPrice]];
            [cell setRightLabelStr:_shopData.shopSpread];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        
    }
    else if (indexPath.section == 1)
    {
        
        if (indexPath.row == 0) {
            
            __weak ShopInfoViewController* wSelf = self;
            __weak ShopInfoData* wData = _shopData;
            AddProductSwithCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddProductSwithCell"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

            cell.textLabel.textColor = FUNCTCOLOR(102, 102, 102);
            cell.textLabel.font = DEFAULTFONT(15);

            if(_shopData.shopStatue ==ShopStatusOpen)
            {
                cell.textLabel.text = @"营业状态：营业中";
                [cell setSWitchStatue:1];
            }
            else
            {
                cell.textLabel.text = @"营业状态：打烊";
                [cell setSWitchStatue:0];
            }
            
            [cell setSwitchBlock:^(BOOL statue) {
                
                if (statue) {
                    wData.shopStatue = ShopStatusOpen;
                }
                else
                {
                    wData.shopStatue = ShopStatusClose;
                }
                [wSelf updateShopInfo];
            }];
            return cell;
        }
        
        ShopInfoTimeSetCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInfoTimeSetCell"];
        
        NSString* time = nil;
        
        if (_shopData.openTime) {
            time = [NSString stringWithFormat:@"%@-%@",_shopData.openTime,_shopData.closeTime];
        }
        else
        {
          time = @"24小时";
        }
        [cell setAccessLabelStr:time];
        return cell;
    }
    else
    {
        ShopInfoThreeLCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInfoThreeLCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setFirstLabelStr:[NSString stringWithFormat:@"店铺地址：%@",_shopData.shopAddress ]];
        [cell setSecondLabelStr:[NSString stringWithFormat:@"店铺电话：%@",_shopData.telPhoneNu]];
        [cell setThirdLabelStr:[NSString stringWithFormat:@"老板手机：%@",_shopData.mobilePhoneNu]];
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        [self showChangeShopNameView];
    }
    else if(indexPath.section == 1)
    {
        [self creatPickerView];
    }
        
}



-(void)creatTableFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    

    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 20)];
    titleLabel.text = @"服务范围";
    titleLabel.font = DEFAULTFONT(16);
    titleLabel.textColor = FUNCTCOLOR(153, 153, 153);
    [footView addSubview:titleLabel];
    
    
    CGRect frame = CGRectMake(15, 30, 0, 20);

    NSArray* strArr = [_shopData.serveArea componentsSeparatedByString:@","];
    
    
    for (NSString* sub in strArr) {
        
        CGSize size = [sub sizeWithAttributes:@{NSFontAttributeName:DEFAULTFONT(15)}];
        size.width += 20;
        if (size.width + frame.origin.x +15 >SCREENWIDTH)
        {
            frame.origin.y += 25;
            frame.origin.x = 15;
        }
        frame.size.width = size.width;
        
        UILabel* lable = [[UILabel alloc]initWithFrame:frame];
        lable.textColor = FUNCTCOLOR(246, 246, 246);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = FUNCTCOLOR(219, 219, 219);
        
        frame.origin.x += size.width +15;
        [footView addSubview:lable];
        lable.layer.masksToBounds = YES;
        lable.layer.cornerRadius = 10;
        lable.font = DEFAULTFONT(15);
        lable.text = sub;
    }
    footView.frame = CGRectMake(0, 0, SCREENWIDTH, frame.origin.y+frame.size.height+10);
     _table.tableFooterView = footView;
    return;
    
}

//-(void)removeTableFootView
//{
//    _table.tableFooterView = nil;
//    _shopData.closeTime = nil;
//    _shopData.openTime = nil;
//}


//-(void)selectCloseTime:(UIButton*)sender
//{
//    [self creatPickerView:sender];
//}
//
//-(void)selectOpenTime:(UIButton*)sender
//{
//    sender.tag = 1;
//    [self creatPickerView:sender];
//}

#pragma mark-Picker


-(void)creatPickerView
{
//     self.isInfoChanged = YES;
    
    UIView* shadeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    shadeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.navigationController.view addSubview:shadeView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRemovePicker:)];
    [shadeView addGestureRecognizer:tap];
    
    
    __weak UIView* wshade = shadeView;
    __weak ShopInfoViewController* wSelf = self;
    __weak UITableView* wtable = _table;
    __weak ShopInfoData* wData = _shopData;
    DatePickerView* picker = [[DatePickerView alloc]initWithDateSelectComplete:^(NSString *startT, NSString *endT) {
        
        if ([startT isEqualToString:@"00:00"]&&[endT isEqualToString:@"23:59"]) {
            wData.openTime = nil;
            wData.closeTime = nil;
        }
        else
        {
            wData.openTime =  startT;
            wData.closeTime = endT;
        }
        [wtable reloadData];
        [wSelf updateShopInfo];
        [wshade removeFromSuperview];
    }];
    picker.translatesAutoresizingMaskIntoConstraints = NO;
    _picker = picker;
    if (_shopData.openTime) {
        [picker setStartTime:_shopData.openTime];
        [picker setEndTime:_shopData.closeTime];
    }
    else
    {
        [picker setSwithStatus:YES];
    }
    
    [self.navigationController.view addSubview:picker];
    [self.navigationController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(picker)]];
    [self.navigationController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[picker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(picker)]];
    
    [self.navigationController.view addConstraint:[NSLayoutConstraint constraintWithItem:picker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
}

-(void)tapGestureRemovePicker:(UIGestureRecognizer*)gesture
{
    [gesture.view removeFromSuperview];
    [_picker removeFromSuperview];
}

//-(UIView*)inputView
//{
//    if (_inputView==nil) {
//        
//        __weak ShopInfoData* wData = _shopData;
//        DatePickerView* picker = [[DatePickerView alloc]initWithDateSelectComplete:^(NSString *dateStr) {
//            [self resignFirstResponder];
////            [bt setTitle:[NSString stringWithFormat:@"开门时间: %@",dateStr] forState:UIControlStateNormal];
//            wData.openTime =  dateStr;
//        }];
//        
//        picker.frame = CGRectMake(0, 0, SCREENWIDTH, 300);
//        _inputView = picker;
//    }
//    
//    return _inputView;
//}
//
//-(BOOL)canBecomeFirstResponder
//{
//    return YES;
//}


#pragma mark-ShopnameChanged

-(void)showChangeShopNameView
{
    ShopNameChangeController* changeName = [[ShopNameChangeController alloc]init];
    changeName.delegate = self;
    [self.navigationController pushViewController:changeName animated:YES];
}

-(void)shopNameChanged:(NSString *)shopName
{
    _shopData.shopName = shopName;
    [self updateShopInfo];
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
