//
//  NetWorkRequest.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "NetWorkRequest.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
#import "ShopCategoryData.h"
#import "ShopProductData.h"
#import "UserManager.h"
#import "OpenUDID.h"
#import "OrderData.h"
#import "DateFormateManager.h"
#import "ShopInfoData.h"
#import "CashDebitData.h"
#import "SpreadData.h"
#import "NSString+Md5.h"


#define HTTPADD(X) X = [NSString stringWithFormat:@"%@&%@",X, [NSString stringWithFormat:@"uid=%@&key=%@&chn=ios&token=%@&ver=%@",[OpenUDID value],[[NSUserDefaults  standardUserDefaults] objectForKey:PWMD5]?[[NSUserDefaults  standardUserDefaults] objectForKey:PWMD5]:@"",[[NSUserDefaults  standardUserDefaults] objectForKey:UTOKEN]?[[NSUserDefaults  standardUserDefaults] objectForKey:UTOKEN]:@"",VERSION]]


@interface NetWorkRequest()
{
    AFHTTPRequestOperation* _afnet;
//    ASIHTTPRequest* _asi;
//    ASIFormDataRequest* _postAsi;
}
@end;
@implementation NetWorkRequest

-(void)getShopInfoWitbBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    if (!manager.shopID) {
        return;
    }
    
    DateFormateManager* formate = [DateFormateManager shareDateFormateManager];
    
    [formate setDateStyleString:@"HH:mm"];
//    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/summary?shop_id=%@&beginDate=&endDate=&ver=%@",HTTPHOST,manager.shopID,VERSION];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/index?shopId=%@&",HTTPHOST,manager.shopID];
    HTTPADD(url);

    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            NSMutableDictionary* backDic = [[NSMutableDictionary alloc]init];
            
            ShopInfoData* data = [[ShopInfoData alloc]init];
            data.countCategory = [sourceDic[@"data"][@"totalCount"]  stringValue];
            data.countOrder =  sourceDic[@"data"][@"totalCount"];
            data.totalMoney = sourceDic[@"data"][@"totalPrice"];
            data.countProducts = [sourceDic[@"data"][@"product"][@"totalCount"]stringValue];
            
            data.shopName = sourceDic[@"data"][@"shop"][@"name"];
            data.shopAddress = sourceDic[@"data"][@"shop"][@"shop_address"];
            data.serveArea = sourceDic[@"data"][@"shop"][@"shop_info"];
            
            if (sourceDic[@"data"][@"shop"][@"open_time"]) {
                
                double openT = [sourceDic[@"data"][@"shop"][@"open_time"] doubleValue]/1000;
                data.openTime =  [formate formateFloatTimeValueToString:openT];
                
                double closeT = [sourceDic[@"data"][@"shop"][@"close_time"] doubleValue]/1000;
                data.closeTime = [formate formateFloatTimeValueToString:closeT];
            }
            data.shopSpread = sourceDic[@"data"][@"shop"][@"shop_code"];
            data.mobilePhoneNu = sourceDic[@"data"][@"shop"][@"owner_phone"];
            int shopStatus = [sourceDic[@"data"][@"shop"][@"status"] intValue];
            //0 营业中,1 打烊
            data.shopStatue = shopStatus==0?ShopStatusOpen:ShopStatusClose;
            
            data.minPrice = [sourceDic[@"data"][@"shop"][@"base_price"] floatValue]/100;
            data.telPhoneNu  = sourceDic[@"data"][@"shop"][@"tel"];
            
            NSArray* picData = sourceDic[@"data"][@"urls"];
            
            NSMutableArray* picArr = [NSMutableArray array];
            for (NSDictionary* temp  in picData) {
                [picArr addObject:temp[@"image"]];
            }
            
            [backDic setObject:data forKey:@"shop"];
            if (picData) {
                [backDic setObject:picData forKey:@"pic_data"];
                [backDic setObject:picArr forKey:@"pics"];
            }
            completeBk(backDic,status);
        }
        else
        {
            completeBk(sourceDic,status);
        }
    }];
}

-(void)shopInfoUpdateWithShopInfoData:(ShopInfoData*)data WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/updateShopInfo?shop_id=%@&name=%@&tel=%@&shop_address=%@&owner_phone=%@&base_price=%d&shopInfo=%@&status=%d",HTTPHOST,manager.shopID,data.shopName,data.telPhoneNu,data.shopAddress,data.mobilePhoneNu,(int)(data.minPrice*100),data.serveArea,data.shopStatue];
    HTTPADD(url);
    
    if (data.openTime) {
        url = [NSString stringWithFormat:@"%@&open_time=%@&close_time=%@",url,data.openTime,data.closeTime];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        completeBk(sourceDic,status);
    }];

}



#pragma mark--------------------Business--------

-(void)getCashTradeListWithIndex:(int)index WithBK:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/wallet/show?shop_id=%@&from=%d&offset=7",HTTPHOST,manager.shopID,index];
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            DateFormateManager* dateManager = [DateFormateManager shareDateFormateManager];
            
            NSArray* arr = sourceDic[@"data"][@"shopCashLists"];
            NSMutableArray* backArr = [[NSMutableArray alloc]init];
            
            for (NSDictionary* dic in arr)
            {
                CashDebitData* cashData = [[CashDebitData alloc]init];
                cashData.debitMoney = [NSString stringWithFormat:@"%.2f",[dic[@"price"] floatValue]/100];
                cashData.spreadMoney = [dic[@"invite_price"] floatValue]/100;
                cashData.debitStatus = [dic[@"status"] intValue]?CashComplete:CashProcess;
                
                switch ([dic[@"cash_type"] intValue]) {
                    case 0:
                        cashData.debitType = CashExpend;
                        break;
                    case 1:
                         cashData.debitType = CashIncome;
                        break;
                    default:
                        break;
                }
                
                if (cashData.debitType==CashIncome)
                {
                     [dateManager setDateStyleString:@"YY-MM-dd"];
                }
                else
                {
                      [dateManager setDateStyleString:@"YY-MM-dd HH:mm"];
                }
                
                double time = [dic[@"create_time"] doubleValue]/1000;
                cashData.debitTime = [dateManager formateFloatTimeValueToString:time];
                [backArr addObject:cashData];
            }
            completeBk(backArr,status);
        }
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];
}

//提现明细

-(void)getCashSummaryListWithIndex:(int)index WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/cashout/list?shop_id=%@&from=0&offset=7",HTTPHOST,manager.shopID];
    HTTPADD(url);
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            DateFormateManager* dateManager = [DateFormateManager shareDateFormateManager];
            
            NSArray* arr = sourceDic[@"data"][@"list"];
            NSMutableArray* backArr = [[NSMutableArray alloc]init];
            
            for (NSDictionary* dic in arr)
            {
                CashDebitData* cashData = [[CashDebitData alloc]init];
                cashData.month = dic[@"month"];
                cashData.outTimes = [NSString stringWithFormat:@"%d",[dic[@"monthTotalCashout"] intValue]];
                cashData.monthMoneyOut = [NSString stringWithFormat:@"%.1f",[dic[@"monthTotalPrice"] floatValue]/100];
                cashData.debitMoney = [NSString stringWithFormat:@"%.1f",[dic[@"price"] floatValue]/100];
                
                cashData.debitStatus = [dic[@"status"] intValue]?CashComplete:CashProcess;
                cashData.debitType = [dic[@"cash_type"] intValue]?CashIncome:CashExpend;
                
                [dateManager setDateStyleString:@"YY-MM-dd HH:mm"];
            
                double time = [dic[@"create_time"] doubleValue]/1000;
                cashData.debitTime = [dateManager formateFloatTimeValueToString:time];
                [backArr addObject:cashData];
            }
            completeBk(backArr,status);
        }
        
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];

}




-(void)getCashWithRequestMoney:(NSString*)money WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/wallet/getCash?shop_id=%@&from=0&offset=7&price=%@",HTTPHOST,manager.shopID,money];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
    
        if (status == NetWorkStatusSuccess)
        {
            
            DateFormateManager* dateManager = [DateFormateManager shareDateFormateManager];
//            [dateManager setDateStyleString:@"YY-MM-dd"];
            
            NSArray* arr = sourceDic[@"data"][@"shopCashLists"];
            NSMutableArray* backArr = [[NSMutableArray alloc]init];
            
            for (NSDictionary* dic in arr)
            {
                CashDebitData* cashData = [[CashDebitData alloc]init];
                cashData.debitMoney = [NSString stringWithFormat:@"%.2f",[dic[@"price"] floatValue]/100];
                
                cashData.debitStatus = [dic[@"status"] intValue]?CashComplete:CashProcess;
                cashData.debitType = [dic[@"cash_type"] intValue]?CashIncome:CashExpend;
                
                if (cashData.debitType==CashIncome)
                {
                    [dateManager setDateStyleString:@"YY-MM-dd"];
                }
                else
                {
                    [dateManager setDateStyleString:@"YY-MM-dd HH:mm"];
                }

                double time = [dic[@"create_time"] doubleValue]/1000;
                cashData.debitTime = [dateManager formateFloatTimeValueToString:time];
                [backArr addObject:cashData];
            }
            completeBk(backArr,status);
        }
        
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];
}


//钱包首页  总数
-(void)getDailyOrderSummaryDataWithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/dailySummaryNew?shop_id=%@",HTTPHOST,manager.shopID];
    HTTPADD(url);
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        completeBk(sourceDic,status);
    }];

}



//已结算订单列表
-(void)getDailyOrderFromIndex:(int)index WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/settleOrderList?shop_id=%@&from=%d&offset=7",HTTPHOST,manager.shopID,index];
    HTTPADD(url);
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
//        NSMutableDictionary* dic 
         completeBk(sourceDic,status);
    }];
}


// type nosettle(未结算订单) settle（以结算的订单详情传入日期）
-(void)getBusinessOrderInfoWithDate:(NSString*)date WithType:(NSString*)type  withIndex:(int)index WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/dailySummaryDetail?shop_id=%@&from=%d&offset=20&date=%@&type=%@",HTTPHOST,manager.shopID,index,date,type];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {

            NSArray* sourceArr = sourceDic[@"data"][@"orders"];
            DateFormateManager* manager = [DateFormateManager shareDateFormateManager];
            [manager  setDateStyleString:@"YY-MM-dd HH:mm"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
               NSMutableArray* backArr = [NSMutableArray array];
                for (NSDictionary* dic in sourceArr) {
                    OrderData* order = [[OrderData alloc]init];
                    order.orderAddress = dic[@"address"];

                    double timeLength = [dic[@"create_time"] doubleValue]/1000;
                    double takeOverLength = [dic[@"user_confirm_time"] doubleValue]/1000;
                    if (takeOverLength==0) {
                        order.orderTakeOver = @"未确认收货";
                    }
                    else
                    {
                       order.orderTakeOver = [manager formateFloatTimeValueToString:takeOverLength];
                    }
                    order.orderTime = [manager  formateFloatTimeValueToString:timeLength] ;
                    
                    
                    order.orderNu = dic[@"order_id"];
                    order.payWay = dic[@"act"];
                    order.discountMoney = [dic[@"dprice"] floatValue];
                    order.telPhone = dic[@"phone"];
                    
                    order.discountMoney = [dic[@"dprice"] floatValue];
                    order.totalMoney = [NSString stringWithFormat:@"%.2f",[dic[@"price"] floatValue]/100] ;
                    order.messageStr = dic[@"remarks"];
                    [order setOrderStatueWithString:dic[@"order_status"]];
                    [order setOrderInfoString:dic[@"info"]];
                    [backArr addObject:order];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBk(backArr,status);
                });
                
            });
        }
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];
}

-(void)getSpreadSummaryDataWithIndex:(int)index WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/inviteSummary?shop_id=%@&from=%d&offset=30",HTTPHOST,manager.shopID,index];
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(id sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            NSArray* dataArr = sourceDic[@"data"][@"list"];
//            NSMutableDictionary* returnDic = [[NSMutableDictionary alloc]init];
            completeBk(dataArr,status);
        }
        else
        {
           
           completeBk(sourceDic,status);
        }
    }];
}

-(void)getSpreadInfoWithDate:(NSString*)date WithIndex:(int)index WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/inviteDetail?shop_id=%@&date=%@&from=%d&offset=30",HTTPHOST,manager.shopID,date,index];
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(id sourceDic, NetWorkStatus status) {
        if (status == NetWorkStatusSuccess)
        {
            NSArray* dataArr = sourceDic[@"data"][@"list"];
            NSMutableArray* returnArr = [[NSMutableArray alloc]init];
            
            for (NSDictionary* dic in dataArr) {
                
                SpreadData* element = [[SpreadData alloc]init];
                element.confirmTime = dic[@"corderTime"];
                element.shopID = dic[@"shopId"];
                element.userID = dic[@"userId"];
                element.codeTime = dic[@"ccodeTime"] ;
                element.platform = dic[@"plat"];
                element.telPhone = dic[@"userPhone"];
                [returnArr addObject:element];
            }
            completeBk(returnArr,status);
        }
        else
        {
            completeBk(sourceDic,status);
        }
    }];
}



#pragma mark-------------order-------------------

-(void)shopGetOrderWithStatue:(NSString *)statue WithIndex:(int)index WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/listbyType?shop_id=%@&from=%d&offset=20&order_status=%@",HTTPHOST,manager.shopID,index,statue];
    HTTPADD(url);
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
 
        if (status == NetWorkStatusSuccess)
        {
            NSArray* sourceArr = sourceDic[@"data"][@"orderls"];
            DateFormateManager* manager = [DateFormateManager shareDateFormateManager];
            [manager  setDateStyleString:@"YY-MM-dd HH:mm"];
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSMutableArray* todayArr = [NSMutableArray array];
                NSMutableArray* notTodayArr = [NSMutableArray array];
                for (NSDictionary* dic in sourceArr) {
                    
                   OrderData* order = [[OrderData alloc]init];
                   order.orderAddress = dic[@"address"];
                   order.orderID = dic[@"id"];
                    
                   order.isNew = [dic[@"flag"] boolValue];
                   double timeLength = [dic[@"create_time"] doubleValue]/1000;
                   order.orderTime = [manager  formateFloatTimeValueToString:timeLength] ;
                   order.orderNu = dic[@"order_id"];
                   order.payWay = dic[@"act"];
                    order.discountMoney = [dic[@"dprice"] floatValue];
                   order.telPhone = dic[@"phone"];
                   
                   order.discountMoney = [dic[@"dprice"] floatValue];
                   order.totalMoney = [NSString stringWithFormat:@"%.1f",[dic[@"price"] floatValue]/100] ;
                   order.messageStr = dic[@"remarks"];
                   [order setOrderStatueWithString:dic[@"order_status"]];
                   [order setOrderInfoString:dic[@"info"]];
                   
                   if ([manager  isTodayWithTimeFloatValue:timeLength])
                   {
                       [todayArr addObject:order];
                   }
                   else
                   {
                       [notTodayArr addObject:order];
                   }
                   
               }
               
               NSMutableArray* backArr = [NSMutableArray array];
               [backArr addObject:todayArr];
               [backArr addObject: notTodayArr];
               dispatch_async(dispatch_get_main_queue(), ^{
                  completeBk(backArr,status);
               });
               
           });
            
        }
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];
}



-(void)shopCateDeleteWithCategoryID:(NSString *)cateID WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/cate/del?category_id=%@&shop_id=%@",HTTPHOST,cateID,manager.shopID];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        completeBk(sourceDic,status);
            
    }];
}

-(void)shopCategoryAddWithName:(NSString *)name WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/cate/add?categoryId=0&shopId=%@&scorce=0&categoryName=%@",HTTPHOST,manager.shopID,name];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        completeBk(sourceDic,status);

    }];
}






-(void)shopProductDeleteProductWithProductID:(NSString *)pID WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/del?itemId=%@&shop_id=%@",HTTPHOST,pID,manager.shopID];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
    
        completeBk(sourceDic,status);
        
    }];
}



-(void)shopProductUpdateWithProduct:(ShopProductData *)data WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    data.price += 0.0001;

    
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/update?itemId=%@&itemName=%@&serialNo=%@&category_id=%@&count=1000&price=%d&saleStatus=%d&shop_id=%@&pic_url=%@&score=%@",HTTPHOST,data.pID,data.pName,data.scanNu,data.categoryID,(int)(data.price*100),data.status,manager.shopID,data.pUrl,data.score];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
            completeBk(sourceDic,status);
    }];


}


-(void)shopProductImagePostWithImage:(NSData *)data WithScanNu:(NSString *)nu WithBk:(NetCallback)completeBk
{
   NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/ul_pic",HTTPHOST];
   HTTPADD(url);
    
   UserManager* manager = [UserManager shareUserManager];
    
    
    AFHTTPRequestOperationManager *af_manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"shop_id":manager.shopID,@"serialNo":nu};
    [af_manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"pic" fileName:@"text.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {

        completeBk(responseObject,NetWorkStatusSuccess);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         completeBk(@"网络连接失败",NetWorkStatusErrorCanntConnect);
    }];
    
    return;
//    _postAsi = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//    _postAsi.delegate = self;
//    __weak ASIFormDataRequest* wPost = _postAsi;
//    [_postAsi setPostValue:manager.shopID forKey:@"shop_id"];
//    [_postAsi setPostValue:nu forKey:@"serialNo"];
//    [_postAsi addData:data withFileName:@"text.jpg" andContentType:@"image/jpeg" forKey:@"pic"];
//    [_postAsi setFailedBlock:^{
//        completeBk(@"网络连接失败",NetWorkStatusErrorCanntConnect);
//    }];
//    [_postAsi setCompletionBlock:^{
//        
//           NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:wPost.responseData options:NSJSONReadingMutableContainers error:NULL];
//        completeBk(dataDic,NetWorkStatusSuccess);
//       
//    }];
//    [_postAsi startAsynchronous];
}

-(void)shopAddProductInfoToServeWith:(ShopProductData*)data WithBk:(NetCallback)completeBk
{
    
    data.price += 0.0001;
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shopItem/addItem?serialNo=%@&name=%@&categoryId=%@&count=100&score=0&price=%d&saleStatus=%d&shop_id=%@&pic_url=%@",HTTPHOST,data.scanNu,data.pName,data.categoryID,(int)(data.price*100),data.status,manager.shopID,data.pUrl];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
    
        if (status==NetWorkStatusSuccess)
        {
            completeBk(sourceDic,status);
            
        }
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];

}




-(void)shopScanProductWithSerial:(NSString*)serialNu WithBk:(NetCallback)completeBk
{

    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/product/get?serialNo=%@",HTTPHOST,serialNu];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
    
        if (status==NetWorkStatusSuccess)
        {
            NSDictionary* pDic = sourceDic[@"data"][@"product"];
            ShopProductData* product = [[ShopProductData alloc]init];
            product.pID = pDic[@"id"];
            product.pName = pDic[@"name"];
            product.pUrl = pDic[@"pic_url"];
            product.price = [pDic[@"price"] intValue]/100.0;
            product.scanNu =pDic[@"serialNo"];
            completeBk(product,status);
        }
        else
        {
            completeBk(sourceDic,status);
        }
        
    }];

}


-(void)shopGetCategoryWithCallBack:(NetCallback)back
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/category/get?shop_id=%@",HTTPHOST,manager.shopID];
    HTTPADD(url);
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            NSMutableArray* arr = [NSMutableArray array];
            NSArray* cateArr = sourceDic[@"data"][@"categoryls"];
            for (NSDictionary* dic in cateArr)
            {
                ShopCategoryData* ca = [[ShopCategoryData alloc]init];
                ca.categoryID = dic[@"category_id"];
                ca.categoryName = dic[@"name"];
                [arr addObject:ca];
            }
             back(arr,status);
        }
        else
        {
           back(sourceDic,status);
        }
        
    }];

}




-(void)shopGetProductWithShopID:(NSString*)shopID withCategory:(NSString*)category fromIndex:(int)nu WithCallBack:(NetCallback)back
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/shop/getitems?shop_id=%@&category_id=%@&from=%d&offset=20",HTTPHOST,shopID,category,nu];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            NSMutableArray* arr = [NSMutableArray array];
            NSArray* products = sourceDic[@"data"][@"itemls"];
            for (NSDictionary* dic in products)
            {
                ShopProductData* product = [[ShopProductData alloc]init];
                product.pUrl = dic[@"pic_url"];
                product.categoryID = dic[@"category_id"];
                product.price = [dic[@"price"] floatValue]/100;
                product.pName = dic[@"name"];
                product.status = [dic[@"onsell"] intValue];
                product.pID = dic[@"id"];
                product.count = [dic[@"count"] intValue];
                product.scanNu = dic[@"serialNo"] ;
                product.score = dic[@"score"];
                [arr addObject:product];
            }
             back(arr,status);
        }
        else
        {
           back(sourceDic,status);
        }
       
    }];

}

-(void)shopOrderConfirmDeliverWithOrderID:(NSString*)orderID WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/order_confirm?shop_id=%@&order_id=%@&confirm=done",HTTPHOST,manager.shopID,orderID];
    HTTPADD(url);
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
            completeBk(sourceDic,status);
    }];

}

-(void)shopOrderCancelDeliverWithOrderID:(NSString*)orderID WithBk:(NetCallback)completeBk
{
    UserManager* manager = [UserManager shareUserManager];
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/order/order_cancel?shop_id=%@&order_id=%@&confirm=done",HTTPHOST,manager.shopID,orderID];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
            completeBk(sourceDic,status);
    }];

}


#pragma mark---------userAccount-----------------



-(void)verifyTokenToServer:(NSString *)token WithCallBack:(NetCallback)back
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/login/islogin?token=%@",HTTPHOST,token];
    
    HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
    
             back(sourceDic,status);
    }];
}

-(void)shopLoginWithPhone:(NSString *)phone password:(NSString *)pw withCallBack:(NetCallback)back
{
    
//    NSString* logUrl = [NSString stringWithFormat:@"http://%@/console/api/login/valid?phone=%@&pwd=%@",HTTPHOST,phone,pw];
    
    NSString* logUrl = [NSString stringWithFormat:@"http://%@/console/api/login/validNew?phone=%@&pwd=%@",HTTPHOST,phone,[NSString md5:pw]];
    HTTPADD(logUrl);
    [self getMethodRequestStrUrl:logUrl complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        back(sourceDic,status);
    }];
}

-(void)requestRemoveUserAccount:(NSString*)account WithPushKey:(NSString*)pushKey WithToken:(NSString*)token Bk:(NetCallback)completeBk
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/logout?phone=%@&device_token=%@&token=%@&ver=%@",HTTPHOST,account,pushKey,token,VERSION];
    
    
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        completeBk(sourceDic,status);
    }];
}

-(void)registePushToken:(NSString*)token WithAccount:(NSString*)account WithBk:(NetCallback)completeBk
{
    NSString* url = [NSString stringWithFormat:@"http://%@/console/api/subscribe?ower_phone=%@&device_token=%@",HTTPHOST,account,token];
   HTTPADD(url);
    [self getMethodRequestStrUrl:url complete:^(NSDictionary *sourceDic, NetWorkStatus status) {
        
        if (status == NetWorkStatusSuccess)
        {
            completeBk(sourceDic,status);
        }
        else
        {
            completeBk(sourceDic,status);
        }
    }];
}


-(void)getMethodRequestStrUrl:(NSString*)url complete:(void(^)( id sourceDic,NetWorkStatus status))block
{
    __weak UserManager* manager = [UserManager shareUserManager];
    
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    _afnet = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [_afnet setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        
        if (dataDic&&[dataDic[@"code"] intValue]==0) {
            block(dataDic,NetWorkStatusSuccess);
        }
        else if ([dataDic[@"code"] intValue]==300)
        {
            block(nil,NetWorkStatusErrorTokenInvalid);
            [manager removeUserData];
            [[NSNotificationCenter defaultCenter] postNotificationName:TOKENINVALID object:nil];
        }
        else
        {
            block(dataDic[@"msg"],NetWorkStatusServerError);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(@"网络连接失败！",NetWorkStatusErrorCanntConnect);
    }];
    
    return;
    
//    _asi = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    
//    __weak ASIHTTPRequest* bkAsi = _asi;
//    
//    [_asi setCompletionBlock:^{
//        
//        NSDictionary* dataDic = [NSJSONSerialization JSONObjectWithData:bkAsi.responseData options:NSJSONReadingMutableContainers error:NULL];
//       
//        if (dataDic&&[dataDic[@"code"] intValue]==0) {
//            block(dataDic,NetWorkStatusSuccess);
//        }
//        else
//        {
//           block(dataDic[@"msg"],NetWorkStatusServerError);
//        }
//        
//    }];
//    
//    [_asi setFailedBlock:^{
//        block(@"网络连接失败！",NetWorkStatusErrorCanntConnect);
//    }];
    
}


-(void)startAsynchronous
{
    [_afnet start];
//    [_asi startAsynchronous];
}

-(void)cancel
{
     [_afnet cancel];
    _afnet = nil;
//    [_asi cancel];
//    _asi = nil;
}

-(void)dealloc
{
//    [self cancel];
}

@end
