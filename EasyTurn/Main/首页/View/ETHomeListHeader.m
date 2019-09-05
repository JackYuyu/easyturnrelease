//
//  ETHomeListHeader.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeListHeader.h"

@interface ETHomeListHeader ()

@property (nonatomic,copy) void (^clickBlock)(void);

@end

@implementation ETHomeListHeader

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 11)];
        imv.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [self addSubview:imv];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        label.text = @"动态列表";
        label.frame = CGRectMake(15, CGRectGetMaxY(imv.frame), 120, 40);
        [self addSubview:label];
        
        imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页_进入"]];
        imv.contentMode = UIViewContentModeScaleAspectFit;
        imv.frame = CGRectMake(Screen_Width-11-15, 0, 11, 11);
        imv.center = CGPointMake(imv.center.x, label.center.y);
        [self addSubview:imv];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"查看全部" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.frame = CGRectMake(CGRectGetMinX(imv.frame)-52-10, 0, imv.frame.size.width+52, 40);
        btn.center = CGPointMake(btn.center.x, imv.center.y);
        [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), Screen_Width, 1)];
        imv.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [self addSubview:imv];
        
        self.frame = CGRectMake(0, 0, Screen_Width, CGRectGetMaxY(imv.frame));
    }
    return self;
}

- (void)clickAction{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

+ (instancetype)homeListHeader:(void (^)(void))clickBlock{
    ETHomeListHeader *header = [[self alloc] init];
    header.clickBlock = clickBlock;
    return header;
}

@end
