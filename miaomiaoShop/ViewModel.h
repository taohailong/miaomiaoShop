//
//  ViewModel.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/11.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequestApi.h"
#import "UserManager.h"
@interface ViewModel : NSObject
{
   NetApiReturnBlock _returnBk ;
   NetApiErrorBlock _errorBk ;
   NetApiFailureBlock _failureBk;
}
-(NSString*)setUrlFormateNoParameter: (NSString*)url;//没有？需要加
-(NSString*)setUrlFormate: (NSString*)url;
-(void) setBlockReturnBk: (NetApiReturnBlock) returnBk
                 errorBk: (NetApiErrorBlock) errorBk
               failureBk: (NetApiFailureBlock) failureBk;
@end
