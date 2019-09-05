//
//  ETHomeViewListCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeViewListCell.h"

@interface ETHomeViewListCell ()
@property (nonatomic, strong) UIImageView *imagevYingYe;
@property (nonatomic, strong) UIImageView *imagevIcon;
@property (nonatomic, strong) UILabel *laTitle;
@property (nonatomic, strong) UILabel *laSatuts;
@property (nonatomic, strong) UILabel *laPrice;
@property (nonatomic, strong) UIImageView *imagevLocation;
@property (nonatomic, strong) UILabel *laCount;
@property (nonatomic, strong) UILabel *laTime;
@property (nonatomic, strong) UILabel *laFanwei;
@end
@implementation ETHomeViewListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    _imagevYingYe = [[UIImageView alloc]init];
    [self.contentView addSubview:_imagevYingYe];
}
    

@end
