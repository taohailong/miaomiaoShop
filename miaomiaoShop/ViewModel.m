//
//  ViewModel.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ViewModel.h"
#import "OpenUDID.h"

@implementation ViewModel
-(void) setBlockReturnBk: (NetApiReturnBlock) returnBk
                 errorBk: (NetApiErrorBlock) errorBk
               failureBk: (NetApiFailureBlock) failureBk;
{
    _returnBk = returnBk;
    _errorBk = errorBk;
    _failureBk = failureBk;
}


-(NSString*)setUrlFormateNoParameter:(NSString*)url
{
    url = [NSString stringWithFormat:@"http://%@/%@?%@",HTTPHOST,url, [NSString stringWithFormat:@"uid=%@&key=%@&chn=ios&token=%@&ver=%@",[OpenUDID value],[[NSUserDefaults  standardUserDefaults] objectForKey:PWMD5]?[[NSUserDefaults  standardUserDefaults] objectForKey:PWMD5]:@"",[[NSUserDefaults  standardUserDefaults] objectForKey:UTOKEN]?[[NSUserDefaults  standardUserDefaults] objectForKey:UTOKEN]:@"",VERSION]];
    return url;

}


-(NSString*)setUrlFormate:(NSString*)url
{
    url = [NSString stringWithFormat:@"http://%@/%@&%@",HTTPHOST,url, [NSString stringWithFormat:@"uid=%@&key=%@&chn=ios&token=%@&ver=%@",[OpenUDID value],[[NSUserDefaults  standardUserDefaults] objectForKey:PWMD5]?[[NSUserDefaults  standardUserDefaults] objectForKey:PWMD5]:@"",[[NSUserDefaults  standardUserDefaults] objectForKey:UTOKEN]?[[NSUserDefaults  standardUserDefaults] objectForKey:UTOKEN]:@"",VERSION]];
    return url;
}
@end
