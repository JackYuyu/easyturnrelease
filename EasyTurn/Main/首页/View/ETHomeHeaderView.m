//
//  ETHomeHeaderView.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "OTAutoScrollView.h"
#import "ETHomeHeaderAutoScrollCell.h"
#import "ETHomeViewController.h"
#import "ETRealTimeBuyListVC.h"
#import "DCCycleScrollView.h"

static NSString *const kETHomeHeaderAutoScrollCell = @"ETHomeHeaderAutoScrollCell";
@interface ETHomeHeaderView ()<SDCycleScrollViewDelegate, OTAutoScrollViewDataSource>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView *vSearch;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UILabel *laSearch;
@property (nonatomic, strong) UIImageView *imagevQiugou;
@property (nonatomic, strong) OTAutoScrollView *vAutoScroll;
//@property (nonatomic, strong) UILabel *laAllQiugou;
@end

@implementation ETHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    UIView *vBackground = [[UIView alloc]init];
    vBackground.backgroundColor = kACColorBlue_Theme;
    [self addSubview:vBackground];
    [vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, self.height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.hidden=YES;
    [self addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vBackground.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(160+13);
    }];
    
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goDymic)];
    UIView *vQiugou = [[UIView alloc]init];
//    vQiugou.backgroundColor=[UIColor redColor];
    [vQiugou addGestureRecognizer:tap1];
    [self addSubview:vQiugou];
    [vQiugou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    _imagevQiugou = [[UIImageView alloc]init];
    _imagevQiugou.image = [UIImage imageNamed:@"首页_实时求购"];
    [vQiugou addSubview:_imagevQiugou];
    [_imagevQiugou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vQiugou);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(28, 34));
    }];
    
    
    OTAutoScrollViewStyleConfig *style = [[OTAutoScrollViewStyleConfig alloc] init];
    style.scrollDirection = OTAutoScrollViewScrollDirectionVertical;
    style.isShowPageControl = NO;
    _vAutoScroll = [[OTAutoScrollView alloc] initWithFrame:CGRectZero style:style];
    _vAutoScroll.dataSource = self;
    _vAutoScroll.isNeedAutoScroll = YES;
    _vAutoScroll.isPanGestureRecognizer = NO;
    _vAutoScroll.timeInterval = 4;
    [_vAutoScroll registerClass:[ETHomeHeaderAutoScrollCell class] forCellWithReuseIdentifier:kETHomeHeaderAutoScrollCell];
    [vQiugou addSubview:_vAutoScroll];
    [_vAutoScroll mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cycleScrollView.mas_bottom);
//
//        make.left.equalTo(self.imagevQiugou.mas_right).offset(15);
        make.right.mas_equalTo(-96);
        make.centerY.mas_equalTo(vQiugou);
        make.height.mas_equalTo(50);
    }];
    [_vAutoScroll reloadData];
    
    UIView *vShu = [[UIView alloc]init];
    vShu.backgroundColor = kACColorRGB(192, 192, 192);
    vShu.backgroundColor = [UIColor lightGrayColor];

    [vQiugou addSubview:vShu];
    [vShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vQiugou);
        make.left.equalTo(self.vAutoScroll.mas_right);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    
    _laAllQiugou = [[UILabel alloc]init];
    _laAllQiugou.textAlignment = NSTextAlignmentCenter;
    _laAllQiugou.text = [NSString stringWithFormat:@"全部5条"];
    [_laAllQiugou setFont:[UIFont systemFontOfSize:14]];
    [vQiugou addSubview:_laAllQiugou];
    [_laAllQiugou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vQiugou);
        make.left.equalTo(vShu.mas_right).mas_offset(5);
        make.right.mas_equalTo(-5);
    }];
    
    
    
}
-(void)goDymic
{
    if (self.block) {
        self.block();
    }
}
- (void)onClickSearch {
    if ([_delegate respondsToSelector:@selector(homeHeaderViewPushSearch)]) {
        [_delegate homeHeaderViewPushSearch];
    }
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"首页_轮播占位图"];
    if (imageGroupArray.count == 0) return;
    //    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
    
    DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:_cycleScrollView.frame shouldInfiniteLoop:YES imageGroups:imageGroupArray];
    //    banner.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
    //    banner.cellPlaceholderImage = [UIImage imageNamed:@"placeholderImage"];
    banner.backgroundColor=kACColorBackgroundGray;
    banner.autoScrollTimeInterval = 5;
    banner.autoScroll = YES;
    banner.isZoom = YES;
    banner.itemSpace = -30;
    banner.imgCornerRadius = 10;
    
    banner.itemWidth = Screen_Width - 60;
    banner.delegate = self;
    banner.pageControl.hidden=YES;
    [self addSubview:banner];
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(slideshowHeadViewDidSelectItemAtIndex:)]) {
        [_delegate slideshowHeadViewDidSelectItemAtIndex:index];
    }    
}
@end
