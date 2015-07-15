//
//  AdvertiseCollectionCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AdvertiseCollectionCell.h"


@interface AdvertiseCollectionCell ()
{
    PosterScorllView* _scorll;
}
@end

@implementation AdvertiseCollectionCell
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    self.backgroundColor = [UIColor blueColor];
    _scorll = [[PosterScorllView alloc]initWithFrame:self.contentView.bounds];
    _scorll.delegate = self;
    [self.contentView addSubview:_scorll];
    return self;
}

-(void)setImageDataArr:(NSArray*)arr
{
    if (arr) {
       [_scorll loadImageViewsWithData:arr]; 
    }
    
}

-(void)posterViewDidSelectAtIndex:(NSInteger)index WithData:(id)data
{
    if ([self.delegate respondsToSelector:@selector(posterViewDidSelectAtIndex:WithData:)]) {
        [self.delegate posterViewDidSelectAtIndex:index WithData:data];
    }

}
@end
