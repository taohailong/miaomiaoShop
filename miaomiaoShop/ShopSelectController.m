//
//  ShopSelectController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopSelectController.h"
#import "UserManager.h"
@interface ShopSelectController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _table;
    NSArray* _shopArr;
}
@end

@implementation ShopSelectController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"选择店铺";
    NSString* shopDirectory = [NSHomeDirectory()
                               stringByAppendingFormat:@"/Documents/%@",@"shopArr"];
    _shopArr = [[NSArray alloc]initWithContentsOfFile:shopDirectory];
    NSLog(@"%@",_shopArr);
    
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_table]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_table)]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* str = @"ids";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        cell.detailTextLabel.textColor  = [UIColor lightGrayColor];
    }
    NSDictionary* dic = _shopArr[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.detailTextLabel.text = dic[@"shop_address"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dic = _shopArr[indexPath.row];
    
    UserManager* manager = [UserManager shareUserManager];
    manager.shopID = dic[@"id"];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOPIDCHANGED object:nil];
}

@end
