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
@property (nonatomic, strong) UIButton *btn_confirm;
@property (nonatomic, strong) UILabel *lb_update;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ETEnterpriseServicesPopListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (void)makeETEnterpriseServicesPopListTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem indexPath:(nonnull NSIndexPath *)indexPath{
    _mItem = mItem;
    _labTitle.text = mItem.title;
    _indexPath = indexPath;
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
    if ([mItem.title isEqualToString:@"求购事项"] && [mItem.content isEqualToString:@"变更"]) {
        if (_mItem.updates.count) {
            WeakSelf(self)
            _lb_update.hidden = NO;
            _lb_update.text = [NSString stringWithFormat:@"您所要变更的事项:\n%@",[_mItem.updates componentsJoinedByString:@";"]];
//            self.contentView.backgroundColor = [UIColor greenColor];
            
            CGFloat update_h = [_lb_update sizeThatFits:CGSizeMake(SCREEN_WIDTH - 30, MAXFLOAT)].height;
            [_lb_update mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(15);
                make.trailing.mas_equalTo(-15);
                make.top.equalTo(weakself.labTitle.mas_bottom);
                make.height.mas_equalTo(update_h);
            }];
            
            _mItem.cellheight = 50 + update_h;
        }else{
            _mItem.cellheight = 50;
            _lb_update.hidden = YES;
//            self.contentView.backgroundColor = [UIColor whiteColor];
        }
        _btn_confirm.hidden = NO;
    }else{
        _mItem.cellheight = 50;
        _btn_confirm.hidden = YES;
        _lb_update.hidden = YES;
//        self.contentView.backgroundColor = [UIColor whiteColor];
    }
//    _labTitle.backgroundColor = [UIColor redColor];
//    _lb_update.backgroundColor = [UIColor orangeColor];
}

- (void)createSubviews {
    WeakSelf(self)
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
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
        make.leading.equalTo(weakself.labTitle.mas_trailing).offset(40);
        make.width.mas_equalTo(10);
        make.centerY.equalTo(weakself.labTitle);
        make.height.mas_equalTo(15);
    }];
    [_btnPopListView addTarget:self action:@selector(onClickBtnPopListView:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn_confirm = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn_confirm setTitle:@"确定" forState:(UIControlStateNormal)];
    _btn_confirm.titleLabel.font = [UIFont systemFontOfSize:16];
    [_btn_confirm setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    [_btn_confirm addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_btn_confirm];
    [_btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(weakself.labTitle);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    _lb_update = [UILabel new];
    _lb_update.font = kFontSize(15);
    _lb_update.textColor = kACColorRGB(51, 51, 51);
    _lb_update.text = @"您所要变更的事项:";
    _lb_update.numberOfLines = 0;
    [self.contentView addSubview:_lb_update];
    [_lb_update mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.top.equalTo(weakself.labTitle.mas_bottom);
        make.height.mas_equalTo(15);
    }];
}

- (void)confirm:(UIButton *)btn{
    _mItem.updates = [[[MySingleton sharedMySingleton] updates] copy];
    NSLog(@"%@",_mItem.updates);
    _lb_update.text = [NSString stringWithFormat:@"您所要变更的事项:\n%@",[_mItem.updates componentsJoinedByString:@";"]];
    if ([_delegate respondsToSelector:@selector(enterpriseServicesPopListTableViewCell:selectPopViewListWithModel:indexPath:update:)]) {
        [_delegate enterpriseServicesPopListTableViewCell:self selectPopViewListWithModel:_mItem indexPath:_indexPath update:YES];
    }
}

- (PopTableListView *)createPopViewWithArrayList:(NSArray<NSString *> *)arrList {
    PopTableListView *popListView = [[PopTableListView alloc] initWithTitles:arrList imgNames:nil type:@"1" maxWidth:_mItem.popTableMaxWidth];
    popListView.backgroundColor = [UIColor whiteColor];
    popListView.layer.cornerRadius = 5;
    popListView.delegate = self;
    return popListView;
}

- (void)onClickBtnPopListView:(UIButton *)sender {
    [self.ak_viewController.view endEditing:YES];
    PopView *popView = [PopView popUpContentView:[self createPopViewWithArrayList:_mItem.arrListContent] direct:PopViewDirection_PopUpBottom onView:sender];
    popView.backgroundColor = [UIColor clearColor];
}

#pragma mark - PopTableListViewDelegate
- (void)selectType:(NSString *)name type:(NSString *)type {
    [self.ak_viewController.view endEditing:YES];
    [PopView hidenPopView];
    _mItem.content = name;
    _mItem.value = name;
    [_btnPopListView setTitle:_mItem.content forState:UIControlStateNormal];
    CGFloat btnPopListViewWidth = [_btnPopListView.titleLabel.text ak_sizeWithFontEX:_btnPopListView.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width + 10 + 12;
    btnPopListViewWidth = btnPopListViewWidth > btnPopListViewMaxWidth ? btnPopListViewMaxWidth : btnPopListViewWidth;
    [_btnPopListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnPopListViewWidth);
    }];
    
    if ([_delegate respondsToSelector:@selector(enterpriseServicesPopListTableViewCell:selectPopViewListWithModel:indexPath:update:)]) {
        [_delegate enterpriseServicesPopListTableViewCell:self selectPopViewListWithModel:_mItem indexPath:_indexPath update:NO];
    }
}

@end
