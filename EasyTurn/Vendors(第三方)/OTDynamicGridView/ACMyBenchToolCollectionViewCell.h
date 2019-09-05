//
//  ACMyBenchToolCollectionViewCell.h
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/20.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STHomeToolsItemModel;
@interface ACMyBenchToolCollectionViewCell : UICollectionViewCell

- (void)makeCallWithMyBenchToolModuleItemModel:(STHomeToolsItemModel *)mItem indexPath:(NSIndexPath *)indexPath;

@end
