//
//  ETEnterpriseServicesPopListTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesPopListTableViewCell.h"
#import "PopTableListView.h"
#import "ETEnterpriseServicesViewModel.h"
#import "PopView.h"
#import "OTButton.h"

static CGFloat const btnPopListViewMaxWidth = 280;

@interface ETEnterpriseServicesPopListTableViewCell ()<PopTableListViewDelegate>
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) OTButton *btnPopListView;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@end

@implementation ETEnterpriseServicesPopListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (void)makeETEnterpriseServicesPopListTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _mItem = mItem;
    _labTitle.text = mItem.title;
    if (mItem.content.length == 0) {
        mItem.content = mItem.arrListContent.count > 0 ? mItem.arrListContent.firstObject : @"";
    }
    [_btnPopListView setTitle:mItem.content forState:UIControlStateNormal];
    
    CGFloat titlewWidth = [_labTitle.text ak_sizeWithFontEX:_labTitle.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width;
    titlewWidth = titlewWidth > btnPopListViewMaxWidth ? btnPopListViewMaxWidth : titlewWidth;
    [_labTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titlewWidth);
    }];
    
    CGFloat btnPopListViewWidth = [_btnPopListView.titleLabel.text ak_sizeWithFontEX:_btnPopListView.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width + 10 + 12;
    btnPopListViewWidth = btnPopListViewWidth > btnPopListViewMaxWidth ? btnPopListViewMaxWidth : btnPopListViewWidth;
    [_btnPopListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnPopListViewWidth);
    }];
    _mItem.cellheight = 50;
}

- (void)createSubviews {
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    _btnPopListView = [[OTButton alloc] init];
    _btnPopListView.ot_marginWithImageViewAndLabel = 15;
    _btnPopListView.ot_styleWithImageViewAndLabelAlignment = OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft;
    _btnPopListView.titleLabel.font = kBoldFontSize(15);
    _btnPopListView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btnPopListView setTitleColor:kACColorRGB(51, 51, 51) forState:UIControlStateNormal];
    [_btnPopListView setImage:[UIImage imageNamed:@"fullarrow_down"] forState:UIControlStateNormal];
    [self.contentView addSubview:_btnPopListView];
    [_btnPopListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labTitle.mas_trailing).offset(40);
        make.width.mas_equalTo(10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    [_btnPopListView addTarget:self action:@selector(onClickBtnPopListView:) forControlEvents:UIControlEventTouchUpInside];
}

- (PopTableListView *)createPopViewWithArrayList:(NSArray<NSString *> *)arrList {
    PopTableListView *popListView = [[PopTableListView alloc] initWithTitles:arrList imgNames:nil type:@"1" maxWidth:_mItem.popTableMaxWidth];
    popListView.backgroundColor = [UIColor whiteColor];
    popListView.layer.cornerRadius = 5;
    popListView.delegate = self;
    return popListView;
}

- (void)onClickBtnPopListView:(UIButton *)sender {
    PopView *popView = [PopView popUpContentView:[self createPopViewWithArrayList:_mItem.arrListContent] direct:PopViewDirection_PopUpBottom onView:sender];
    popView.backgroundColor = [UIColor clearColor];
}

#pragma mark - PopTableListViewDelegate
- (void)selectType:(NSString *)name type:(NSString *)type {
    [PopView hidenPopView];
    _mItem.content = name;
    _mItem.value = name;
    [_btnPopListView setTitle:_mItem.content forState:UIControlStateNormal];
    CGFloat btnPopListViewWidth = [_btnPopListView.titleLabel.text ak_sizeWithFontEX:_btnPopListView.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width + 10 + 12;
    btnPopListViewWidth = btnPopListViewWidth > btnPopListViewMaxWidth ? btnPopListViewMaxWidth : btnPopListViewWidth;
    [_btnPopListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnPopListViewWidth);
    }];
    
    if ([_delegate respondsToSelector:@selector(enterpriseServicesPopListTableViewCell:selectPopViewListWithModel:)]) {
        [_delegate enterpriseServicesPopListTableViewCell:self selectPopViewListWithModel:_mItem];
    }
}

@end
