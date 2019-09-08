//
//  EaseUserMeagessListCell.h
//  EasyTurn
//
//  Created by 王翔 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ETProductModel;
@interface EaseUserMeagessListCell : UITableViewCell
@property (nonatomic, assign) CGFloat cellHeight;
- (void)makeCellWithETProductModel:(ETProductModel *)model WithIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
