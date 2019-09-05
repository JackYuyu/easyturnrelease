//
//  ETHomeHeaderView1.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/27.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeHeaderView1.h"
#import "SDCycleScrollView.h"
#import "OTAutoScrollView.h"
#import "ETHomeHeaderAutoScrollCell.h"
static NSString *const kETHomeHeaderAutoScrollCell = @"ETHomeHeaderAutoScrollCell";
@interface ETHomeHeaderView1 ()<SDCycleScrollViewDelegate, OTAutoScrollViewDataSource>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView *vSearch;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UILabel *laSearch;
@property (nonatomic, strong) UIImageView *imagevQiugou;
@property (nonatomic, strong) OTAutoScrollView *vAutoScroll;
@property (nonatomic, strong) UILabel *laAllQiugou;
@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation ETHomeHeaderView1

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
        make.height.mas_equalTo(67);
    }];
    
//    _vSearch = [[UIView alloc]init];
//    _vSearch.backgroundColor = kACColorWhite;
//    [_vSearch addCornerRadiusWithRadius:4.0f];
//    [vBackground addSubview:_vSearch];
//    [_vSearch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(47);
//    }];
//    
//    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSearch)];
//    [_vSearch addGestureRecognizer:tap];
//    
//    _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_btnSearch setBackgroundImage:[UIImage imageNamed:@"首页_搜索"] forState:UIControlStateNormal];
//    [_vSearch addSubview:_btnSearch];
//    [_btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.vSearch);
//        make.left.mas_equalTo(13);
//    }];
//    
//    _laSearch = [[UILabel alloc]init];
//    _laSearch.text = @"请输入你要搜索的内容";
//    _laSearch.textColor = kACColorRGB(153, 153, 153);
//    _laSearch.font = kFontSize(14);
//    [_vSearch addSubview:_laSearch];
//    [_laSearch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.vSearch);
//        make.left.equalTo(self.btnSearch.mas_right).offset(4);
//    }];
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 7, Screen_Width -20 - 80, 36)];
    self.searchTextField.placeholder = @"搜索个关键词试试";
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索商品或服务" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],         NSFontAttributeName:self.searchTextField.font}];
    self.searchTextField.attributedPlaceholder = attrString;
    
    self.searchTextField.borderStyle=UITextBorderStyleNone;
    self.searchTextField.font = [UIFont systemFontOfSize:13.0];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    
    [vBackground addSubview:self.searchTextField];
    
    //
    UIView* line=[[UIView alloc] initWithFrame:CGRectMake(30,self.searchTextField.maxY, Screen_Width -20 - 80, 0.5)];
    [line setBackgroundColor:[UIColor whiteColor]];
    //
    UIButton* searchBtn=[UIButton new];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_分组"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAct) forControlEvents:UIControlEventTouchUpInside];
    [vBackground addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(vBackground).offset(-20);
        make.centerY.mas_equalTo(self.searchTextField);
        make.width.height.mas_equalTo(22);
    }];
    
    
    [vBackground addSubview:line];
    
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, self.height) delegate:self placeholderImage:nil];
//    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    _cycleScrollView.autoScrollTimeInterval = 5.0;
//    [self addSubview:_cycleScrollView];
//    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(vBackground.mas_bottom);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(210);
//    }];
//    
//    UIView *vQiugou = [[UIView alloc]init];
//    [self addSubview:vQiugou];
//    [vQiugou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cycleScrollView.mas_bottom);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(50);
//    }];
//    
//    _imagevQiugou = [[UIImageView alloc]init];
//    _imagevQiugou.image = [UIImage imageNamed:@"首页_实时求购"];
//    [vQiugou addSubview:_imagevQiugou];
//    [_imagevQiugou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(vQiugou);
//        make.left.mas_equalTo(16);
//        make.size.mas_equalTo(CGSizeMake(28, 34));
//    }];
//    
//    
//    OTAutoScrollViewStyleConfig *style = [[OTAutoScrollViewStyleConfig alloc] init];
//    style.scrollDirection = OTAutoScrollViewScrollDirectionVertical;
//    style.isShowPageControl = NO;
//    _vAutoScroll = [[OTAutoScrollView alloc] initWithFrame:CGRectZero style:style];
//    _vAutoScroll.dataSource = self;
//    _vAutoScroll.isNeedAutoScroll = YES;
//    _vAutoScroll.isPanGestureRecognizer = NO;
//    _vAutoScroll.timeInterval = 4;
//    [_vAutoScroll registerClass:[ETHomeHeaderAutoScrollCell class] forCellWithReuseIdentifier:kETHomeHeaderAutoScrollCell];
//    [vQiugou addSubview:_vAutoScroll];
//    [_vAutoScroll mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cycleScrollView.mas_bottom);
//        make.left.equalTo(self.imagevQiugou.mas_right).offset(15);
//        make.right.mas_equalTo(-96);
//        make.height.mas_equalTo(50);
//    }];
//    [_vAutoScroll reloadData];
//    
//    UIView *vShu = [[UIView alloc]init];
//    vShu.backgroundColor = kACColorRGB(192, 192, 192);
//    [vQiugou addSubview:vShu];
//    [vShu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(vQiugou);
//        make.left.equalTo(self.vAutoScroll.mas_right);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(1);
//    }];
//    
//    _laAllQiugou = [[UILabel alloc]init];
//    _laAllQiugou.textAlignment = NSTextAlignmentCenter;
//    _laAllQiugou.text = @"全部5条";
//    [vQiugou addSubview:_laAllQiugou];
//    [_laAllQiugou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(vQiugou);
//        make.left.equalTo(vShu.mas_right);
//        make.right.mas_equalTo(0);
//    }];
    
    
    
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
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(slideshowHeadViewDidSelectItemAtIndex:)]) {
        [_delegate slideshowHeadViewDidSelectItemAtIndex:index];
    }
}
@end
