//
//  ETMineHeaderView.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineHeaderView.h"
#import "OTDynamicGridView.h"
#import "ETMineGridCollectionCell.h"
#import "ETMineViewModel.h"
#import "PublicFunc.h"
static NSString *kETMineGridCollectionCell = @"ETMineGridCollectionCell";
@interface ETMineHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *imagevHeader;
@property (nonatomic, strong) UIImageView *imagevUserEdit;
@property (nonatomic, strong) UILabel *laName;
@property (nonatomic, strong) UIImageView *imagevUserType;
@property (nonatomic, strong) UILabel *laVip;
@property (nonatomic, strong) UILabel *laIdAuthentication;
@property (nonatomic, strong) UIButton *btnPayVip;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIView *vLastLine;
//item图片名称数组
@property (nonatomic, strong) NSArray *arrItemImage;
//itme文字数组
@property (nonatomic, strong) NSArray *arrItemTitle;
@property (nonatomic, strong) UICollectionView *collectionView;
//刷新次数view
@property (nonatomic, strong) UIView *vRefreshBox;
@property (nonatomic, strong) UIView *vRefreshCircular;
@property (nonatomic, strong) UILabel *laTipsSurplusrRefreshCount;
@property (nonatomic, strong) UILabel *laSurplusrRefreshCount;
@property (nonatomic, strong) UILabel *laTipsSurplusrRefresh;
@property (nonatomic, strong) UIButton *btnPayRefreshCount;
@property (nonatomic, strong) UIView *vMyDynamic;
@property (nonatomic, strong) UILabel *laDynamicTitle;
@end

@implementation ETMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    [self addSubview:self.imagevHeader];
    [self.imagevHeader addSubview:self.imagevUserEdit];
    [self addSubview:self.laName];
    [self addSubview:self.imagevUserType];
    [self addSubview:self.laVip];
    [self addSubview:self.laIdAuthentication];
    [self addSubview:self.btnPayVip];
    [self addSubview:self.vLine];
    [self addSubview:self.collectionView];
    [self addSubview:self.vLastLine];
    [self addSubview:self.vRefreshBox];
    
    [self.vRefreshBox addSubview:self.vRefreshCircular];
    [self.vRefreshBox addSubview:self.laTipsSurplusrRefreshCount];
    [self.vRefreshBox addSubview:self.laSurplusrRefreshCount];
    [self.vRefreshBox addSubview:self.laTipsSurplusrRefresh];
    [self.vRefreshBox addSubview:self.btnPayRefreshCount];
    
    [self addSubview:self.vMyDynamic];
    [self.vMyDynamic addSubview:self.laDynamicTitle];
    
    [self.imagevHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.imagevUserEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imagevHeader);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];

    [self.laName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevHeader);
        make.left.equalTo(self.imagevHeader.mas_right).offset(15);
        make.right.mas_equalTo(-130);
        make.height.mas_equalTo(21);
    }];
    
    [self.imagevUserType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laName);
        make.left.equalTo(self.laName.mas_right).offset(4);
        make.size.mas_equalTo(CGSizeMake(27, 12));
    }];
    
    [self.laVip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laName.mas_bottom).offset(3);
        make.left.equalTo(self.laName);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(-100);
    }];
    
    [self.laIdAuthentication mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laVip.mas_bottom).offset(3);
        make.left.equalTo(self.laName);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(-100);
    }];
    
    [self.btnPayVip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagevHeader);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(90, 33));
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevHeader.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(kLinePixel);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(141);
    }];
    
    [self.vLastLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(13);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.vRefreshBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLastLine.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(112);
    }];
    
    [self.vRefreshCircular mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vRefreshBox);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self.laTipsSurplusrRefreshCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.vRefreshCircular);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(17);
    }];
    
    [self.laSurplusrRefreshCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laTipsSurplusrRefreshCount.mas_bottom);
        make.centerX.equalTo(self.vRefreshCircular);
        make.height.mas_equalTo(33);
    }];
    
    [self.laTipsSurplusrRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vRefreshCircular);
        make.left.equalTo(self.vRefreshCircular.mas_right).offset(20);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.btnPayRefreshCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laTipsSurplusrRefresh.mas_bottom).offset(9);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(195, 35));
    }];
    
    [self.vMyDynamic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vRefreshBox.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(self);
    }];
    
    [self.laDynamicTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vMyDynamic);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(21);
    }];
}

- (void)makeMineHeaderViewWithETMineViewModel:(ETMineViewModel *)model {
    if (model.userInfo.portrait == nil) {
        self.imagevHeader.image = [UIImage imageNamed:@"我的_默认头像"];
    }else {
        [self.imagevHeader sd_setImageWithURL:[NSURL URLWithString:model.userInfo.portrait]];
    }
    
    self.laName.text = model.userInfo.name;
    CGFloat h= [PublicFunc textWidthFromString:self.laName.text height:30 fontsize:14];
    [self.laName mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevHeader);
        make.left.mas_equalTo(95);
        make.width.mas_equalTo(h);
        make.height.mas_equalTo(21);
    }];
    [self.imagevUserType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laName);
        make.left.equalTo(self).offset(85+h+20);
        make.size.mas_equalTo(CGSizeMake(27, 12));
    }];
    if (model.userInfo.vip == nil) {
        self.laVip.text = @"您还不是易转会员";
    }else{
        NSString *strfommt = [DCSpeedy getDateStringWithTimeStr:model.userInfo.vipExpiryDate];
        self.laVip.text = [NSString stringWithFormat:@"VIP到期时间 %@",strfommt];
    }
    self.laSurplusrRefreshCount.text = model.userInfo.refreshCount;
    
    if ([model.userInfo.isChecked isEqualToString:@"0"]) {
        self.laIdAuthentication.text = @"未认证";
    }else if ([model.userInfo.isChecked isEqualToString:@"1"]) {
        self.laIdAuthentication.text = @"个人认证";
    }else if ([model.userInfo.isChecked isEqualToString:@"2"]) {
        self.laIdAuthentication.text = @"员工认证中";
    }
    else if ([model.userInfo.isChecked isEqualToString:@"3"]) {
        self.laIdAuthentication.text = @"法人认证中";
    }
    else if ([model.userInfo.isChecked isEqualToString:@"4"]) {
        self.laIdAuthentication.text = @"企业认证";
    }
    else if ([model.userInfo.isChecked isEqualToString:@"5"]) {
        self.laIdAuthentication.text = @"企业认证";
    }
    
    if (model.userInfo.vip == nil) {
        [self.btnPayVip setImage:[UIImage imageNamed:@"我的_购买VIP"] forState:UIControlStateNormal];
    }else{
        [self.btnPayVip setImage:[UIImage imageNamed:@"我的_续费VIP"] forState:UIControlStateNormal];
    }
}

- (void)onClickEdit {
    if ([_delegate respondsToSelector:@selector(eTMineHeaderviewOnClickHeaderEdit)]) {
        [_delegate eTMineHeaderviewOnClickHeaderEdit];
    }
}

- (void)onClickPayVip {
    if ([_delegate respondsToSelector:@selector(eTMineHeaderviewOnClickPayVip)]) {
        [_delegate eTMineHeaderviewOnClickPayVip];
    }
}

- (void)onClickPayRefreshCount {
    if ([_delegate respondsToSelector:@selector(eTMineHeaderviewOnClickPayRefreshCount)]) {
        [_delegate eTMineHeaderviewOnClickPayRefreshCount];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ETMineGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kETMineGridCollectionCell forIndexPath:indexPath];
    cell.laGirdTitle.text = self.arrItemTitle[indexPath.row];
    cell.imagevGrid.image = [UIImage imageNamed:self.arrItemImage[indexPath.row]];
    return cell;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Screen_Width)/4 , 66);
}

#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 9;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(eTMineHeaderviewDidSelectItemAtIndexPath:)]) {
        [_delegate eTMineHeaderviewDidSelectItemAtIndexPath:indexPath];
    }
}

- (UIImageView *)imagevHeader {
    if (!_imagevHeader) {
        _imagevHeader = [[UIImageView alloc]init];
        _imagevHeader.userInteractionEnabled = YES;
        [_imagevHeader addCornerRadiusWithRadius:4.0f];
        _imagevHeader.image = [UIImage imageNamed:@"我的_默认头像"];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickEdit)];
        [_imagevHeader addGestureRecognizer:tap];
    }
    return _imagevHeader;
}

- (UILabel *)laName {
    if (!_laName) {
        _laName = [[UILabel alloc]init];
        _laName.textColor = kACColorRGB(51, 51, 51);
        _laName.font = kBoldFontSize(15);
    }
    return _laName;
}

- (UIImageView *)imagevUserType {
    if (!_imagevUserType) {
        _imagevUserType = [[UIImageView alloc]init];
        _imagevUserType.image = [UIImage imageNamed:@"我的_企服者"];
    }
    return _imagevUserType;
}

- (UIImageView *)imagevUserEdit {
    if (!_imagevUserEdit) {
        _imagevUserEdit = [[UIImageView alloc]init];
        _imagevUserEdit.image = [UIImage imageNamed:@"我的_头像编辑"];
    }
    return _imagevUserEdit;
}

- (UILabel *)laVip {
    if (!_laVip) {
        _laVip = [[UILabel alloc]init];
        _laVip.textColor = kACColorRGB(153, 153, 153);
        _laVip.font = kFontSize(12);
    }
    return _laVip;
}

- (UILabel *)laIdAuthentication {
    if (!_laIdAuthentication) {
        _laIdAuthentication = [[UILabel alloc]init];
        _laIdAuthentication.textColor = kACColorRGB(153, 153, 153);
        _laIdAuthentication.font = kFontSize(12);
    }
    return _laIdAuthentication;
}

- (UIButton *)btnPayVip {
    if (!_btnPayVip) {
        _btnPayVip = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPayVip setImage:[UIImage imageNamed:@"我的_购买VIP"] forState:UIControlStateNormal];
        [_btnPayVip setImage:[UIImage imageNamed:@"我的_购买VIP"] forState:UIControlStateHighlighted];
        [_btnPayVip addTarget:self action:@selector(onClickPayVip) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPayVip;
}

- (UIView *)vLine {
    if (!_vLine) {
        _vLine = [[UIView alloc]init];
        _vLine.backgroundColor = kACColorRGB(242, 242, 242);
    }
    return _vLine;
}

- (UIView *)vLastLine {
    if (!_vLastLine) {
        _vLastLine = [[UIView alloc]init];
        _vLastLine.backgroundColor = kACColorRGB(242, 242, 242);
    }
    return _vLastLine;
}

- (UIView *)vRefreshBox {
    if (!_vRefreshBox) {
        _vRefreshBox = [[UIView alloc]init];
        _vRefreshBox.backgroundColor = kACColorWhite;
    }
    return _vRefreshBox;
}

- (UIView *)vRefreshCircular {
    if (!_vRefreshCircular) {
        _vRefreshCircular = [[UIView alloc]init];
        _vRefreshCircular.layer.borderColor = kACColorRGB(248, 124, 43).CGColor;
        _vRefreshCircular.layer.borderWidth = 2;
        [_vRefreshCircular addCornerRadiusWithRadius:45.0f];
    }
    return _vRefreshCircular;
}

- (UILabel *)laTipsSurplusrRefreshCount {
    if (!_laTipsSurplusrRefreshCount) {
        _laTipsSurplusrRefreshCount = [[UILabel alloc]init];
        _laTipsSurplusrRefreshCount.textColor = kACColorRGB(102, 102, 102);
        _laTipsSurplusrRefreshCount.font = kFontSize(11);
        _laTipsSurplusrRefreshCount.text = @"剩余刷新次数";
        _laTipsSurplusrRefreshCount.textAlignment = NSTextAlignmentCenter;
    }
    return _laTipsSurplusrRefreshCount;
}

- (UILabel *)laSurplusrRefreshCount {
    if (!_laSurplusrRefreshCount) {
        _laSurplusrRefreshCount = [[UILabel alloc]init];
        _laSurplusrRefreshCount.textColor = kACColorRGB(82, 74, 3);
        _laSurplusrRefreshCount.font = kFontSize(23);
        _laSurplusrRefreshCount.textAlignment = NSTextAlignmentCenter;
    }
    return _laSurplusrRefreshCount;
}

- (UILabel *)laTipsSurplusrRefresh {
    if (!_laTipsSurplusrRefresh) {
        _laTipsSurplusrRefresh = [[UILabel alloc]init];
        _laTipsSurplusrRefresh.textColor = kACColorRGB(102, 102, 102);
        _laTipsSurplusrRefresh.font = kFontSize(13);
        _laTipsSurplusrRefresh.text = @"每次刷新，您的商品都会更改排名提高曝光次数，提升发布效益。";
        _laTipsSurplusrRefresh.numberOfLines = 0;
    }
    return _laTipsSurplusrRefresh;
}

- (UIButton *)btnPayRefreshCount {
    if (!_btnPayRefreshCount) {
        _btnPayRefreshCount = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPayRefreshCount setTitle:@"购买刷新次数" forState:UIControlStateNormal];
        [_btnPayRefreshCount setTitleColor:kACColorWhite forState:UIControlStateNormal];
        _btnPayRefreshCount.backgroundColor = kACColorRGB(248, 124, 43);
        _btnPayRefreshCount.titleLabel.font = kFontSize(15);
        [_btnPayRefreshCount addCornerRadiusWithRadius:17.5f];
        [_btnPayRefreshCount addTarget:self action:@selector(onClickPayRefreshCount) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPayRefreshCount;
}

- (UIView *)vMyDynamic {
    if (!_vMyDynamic) {
        _vMyDynamic = [[UIView alloc]init];
        _vMyDynamic.backgroundColor = kACColorRGB(242, 242, 242);
    }
    return _vMyDynamic;
}

- (UILabel *)laDynamicTitle {
    if (!_laDynamicTitle) {
        _laDynamicTitle = [[UILabel alloc]init];
        _laDynamicTitle.textColor = kACColorRGB(51, 51, 51);
        _laDynamicTitle.font = kFontSize(15);
        _laDynamicTitle.text = @"我的动态";
        
    }
    return _laDynamicTitle;
}


- (NSArray *)arrItemImage{
    if (!_arrItemImage) {
        _arrItemImage = @[@"我的_我的企业",@"我的_身份认证",@"我的_我的订单",@"我的_账户余额",@"我的_访问记录",@"我的_邀请好友",@"我的_我的收藏",@"我的_每日签到"];
    }
    return _arrItemImage;
}

- (NSArray *)arrItemTitle{
    if (!_arrItemTitle) {
        _arrItemTitle = @[@"我的企业",@"身份认证",@"我的订单",@"账户余额",@"访问记录",@"邀请好友",@"我的收藏",@"每日签到"];
    }
    return _arrItemTitle;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = kACColorWhite;
        [_collectionView registerClass:[ETMineGridCollectionCell class] forCellWithReuseIdentifier:kETMineGridCollectionCell];
        
    }
    return _collectionView;
}

@end
