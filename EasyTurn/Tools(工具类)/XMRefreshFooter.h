//
//  XMRefreshFooter.h
//  Fireball
//
//  Created by 任长平 on 2017/12/9.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface XMRefreshFooter : MJRefreshAutoGifFooter
+(instancetype)xm_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end
