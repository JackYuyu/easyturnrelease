//
//  JMColumnMenuCell.m
//  JMCollectionView
//
//  Created by 刘俊敏 on 2017/12/7.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "JMColumnMenuCell.h"

@interface JMColumnMenuCell()

/** 空View */
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation JMColumnMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //空View
        self.emptyView = [[UIView alloc] initWithFrame:CGRectZero];
        self.emptyView.backgroundColor = [UIColor whiteColor];
        self.emptyView.layer.cornerRadius = 4.0;
        [self.contentView addSubview:self.emptyView];
        
        //标题
        self.title = [[UILabel alloc] initWithFrame:CGRectZero];
        self.title.font = [UIFont systemFontOfSize:15];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.emptyView addSubview:self.title];
        
        //关闭按钮
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"JMColumnMenu" ofType:@"bundle"]];
        NSString *path = [bundle pathForResource:@"close" ofType:@"png"];
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        self.closeBtn.hidden = YES;
        [self.emptyView addSubview:self.closeBtn];
        
    }
    return self;
}

- (void)updateAllFrame:(AticleMenu *)model {
    self.emptyView.frame = CGRectMake(5, 6.5, self.contentView.width - 10, self.contentView.height - 13);
    
    self.title.size = [self returnTitleSize];

    self.title.center = CGPointMake(self.emptyView.width / 2, self.emptyView.height / 2);

    self.closeBtn.frame = CGRectMake(self.contentView.width - 18, -5, 18, 18);

}

- (void)setModel:(AticleMenu *)model {
    _model = model;
//    if (_model.resident) {
//        self.title.textColor = [UIColor xm_MainColor];
//    }
    //标题文字处理
    if (model.Text.length == 2) {
        self.title.font = [UIFont systemFontOfSize:15];
    } else if (model.Text.length == 3) {
        self.title.font = [UIFont systemFontOfSize:14];
    } else if (model.Text.length == 4) {
        self.title.font = [UIFont systemFontOfSize:13];
    } else if (model.Text.length > 4) {
        self.title.font = [UIFont systemFontOfSize:12];
    }

    self.closeBtn.hidden = !model.isEditing;
    self.title.text = [NSString stringWithFormat:@"%@",model.Text];
    
    [self updateAllFrame:model];
}

- (CGSize)returnTitleSize {
    CGFloat maxWidth = self.emptyView.width - 12;
    CGSize size = [self.title.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:self.title.font}
                                                context:nil].size;
    return size;
}


@end
