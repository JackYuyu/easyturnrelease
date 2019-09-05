//
//  XMRefreshFooter.m
//  Fireball
//
//  Created by 任长平 on 2017/12/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMRefreshFooter.h"

@implementation XMRefreshFooter


+(instancetype)xm_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshAutoGifFooter * footer = [super footerWithRefreshingBlock:refreshingBlock];
    //    footer.refreshingTitleHidden = YES;
    //    header.stateLabel.hidden = YES;
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    NSArray * array = @[[UIImage imageNamed:@"antsoo_refreshing_0"],
//                        [UIImage imageNamed:@"antsoo_refreshing_1"]];
//    [footer setImages:array duration:array.count * 0.35 forState:MJRefreshStateIdle];
//    [footer setImages:array duration:array.count * 0.35 forState:MJRefreshStatePulling];
//    [footer setImages:array duration:array.count * 0.35 forState:MJRefreshStateRefreshing];
    return (XMRefreshFooter *)footer;
    
}

@end
