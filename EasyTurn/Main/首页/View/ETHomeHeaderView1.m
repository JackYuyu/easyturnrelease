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
