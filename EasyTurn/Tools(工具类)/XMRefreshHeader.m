//
//  XMRefreshHeader.m
//  Fireball
//
//  Created by 任长平 on 2017/12/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMRefreshHeader.h"

@implementation XMRefreshHeader

+(instancetype)xm_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshGifHeader * header = [super headerWithRefreshingBlock:refreshingBlock];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    header.labelLeftInset = 10;
//    header.stateLabel.backgroundColor = XMRandomColor;
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    NSArray * array = @[[UIImage imageNamed:@"antsoo_refreshing_0"],
//                        [UIImage imageNamed:@"antsoo_refreshing_1"]];
//
//    [header setImages:@[[UIImage imageNamed:@"antsoo_refreshing_1"]]
//             duration:0.35
//             forState:MJRefreshStateIdle];
    
//    [header setImages:array duration:array.count * 0.35 forState:MJRefreshStatePulling];
//    [header setImages:array duration:array.count * 0.35 forState:MJRefreshStateRefreshing];
    return (XMRefreshHeader *)header;
}


@end
