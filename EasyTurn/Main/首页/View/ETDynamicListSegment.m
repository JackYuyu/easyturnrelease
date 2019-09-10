//
//  ETDynamicListSegment.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETDynamicListSegment.h"

@interface NSString (ETStringSize)

+ (CGSize)sizeFromStr:(NSString *)string width:(CGFloat)width font:(UIFont *)font;

@end

@implementation NSString (ETStringSize)

+ (CGSize)sizeFromStr:(NSString *)string width:(CGFloat)width font:(UIFont *)font{
    UIFont *fontTemp = font;
    if(!font)
        fontTemp = [UIFont systemFontOfSize:17.];
    NSDictionary *attribute = @{NSFontAttributeName:fontTemp};
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return labelSize;
}

@end


@interface ETDynamicListSegItem ()
@property (nonatomic,strong) UIButton *btnReverse;
@property (nonatomic,strong) UIImageView *imvReverse;
@property (nonatomic,copy)  NSString *btnTitle;

@property (nonatomic,copy) void (^clickBlock)(NSInteger itemIndex);
@end
@implementation ETDynamicListSegItem

+ (instancetype)dynamicListSegItem:(NSString *)title isNeedImage:(BOOL)isNeedImage click:(void (^)(NSInteger))clickBlock{
    ETDynamicListSegItem *segItem = [[self alloc] init];
    segItem.btnTitle = title;
    segItem.clickBlock = clickBlock;
    [segItem setupSubs:isNeedImage];
    return segItem;
    
}

- (void)resetIsSubShow:(BOOL)isSubShow{
    WeakSelf(self);
    CGAffineTransform finalTrasform = CGAffineTransformIdentity;
    if (isSubShow) {
        finalTrasform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    }
    else{
        finalTrasform = CGAffineTransformIdentity;
    }
    if (self.imvReverse) {
        [UIView animateWithDuration:0.25 animations:^{
            
            weakself.imvReverse.transform = finalTrasform;
            
        } completion:^(BOOL finished) {
        }];
    }

}

- (void)resetSelectState:(BOOL)isSelect{
    self.isSelected = isSelect;
    WeakSelf(self);
    UIColor *finalColor = nil;
    if (isSelect) {
        finalColor = [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    }
    else{
        finalColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    if (self.imvReverse) {
        weakself.btnReverse.selected = isSelect;
        weakself.imvReverse.tintColor = finalColor;
    }
    else{
        self.btnReverse.selected = isSelect;
    }
}

- (void)resetBtnTitle:(NSString *)title{
    self.btnTitle = title;
    [self.btnReverse setTitle:title forState:UIControlStateNormal];
    [self.btnReverse setTitle:title forState:UIControlStateSelected];
    CGSize size = [NSString sizeFromStr:self.btnTitle width:MAXFLOAT font:self.btnReverse.titleLabel.font];
    if (self.imvReverse) {
        CGFloat totalW = size.width+10+self.imvReverse.image.size.width;
        self.btnReverse.frame = CGRectMake((self.frame.size.width-totalW)/2, 0, totalW, 40);
        self.imvReverse.frame = CGRectMake(CGRectGetMaxX(self.btnReverse.frame)-self.imvReverse.image.size.width, (40-self.imvReverse.image.size.height)/2, self.imvReverse.image.size.width, self.imvReverse.image.size.height);
    }
    else{
        self.btnReverse.frame = CGRectMake((self.frame.size.width-size.width)/2, 0, size.width, 40);
    }
}

- (void)setupSubs:(BOOL)isNeedImage{
    if (isNeedImage) {
        UIImageView* imvReverse = [[UIImageView alloc] init];
        UIImage *image = [[UIImage imageNamed:@"动态列表_分组"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imvReverse.tintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        imvReverse.image = image;
        imvReverse.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [self addSubview:imvReverse];
        self.imvReverse = imvReverse;
    }
    
    
    UIButton* btnReverse = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReverse.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [btnReverse addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [btnReverse setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnReverse setTitle:self.btnTitle forState:UIControlStateNormal];
    [btnReverse setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateSelected];
    [btnReverse setTitle:self.btnTitle forState:UIControlStateSelected];
    btnReverse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnReverse = btnReverse;
    [self addSubview:btnReverse];
    
    CGSize size = [NSString sizeFromStr:self.btnTitle width:MAXFLOAT font:btnReverse.titleLabel.font];
    if (self.imvReverse) {
        btnReverse.frame = CGRectMake(0, 0, size.width+10+self.imvReverse.image.size.width, 40);
        self.imvReverse.frame = CGRectMake(size.width+10, (40 -self.imvReverse.image.size.height)/2, self.imvReverse.image.size.width, self.imvReverse.image.size.height);
        self.frame = CGRectMake(0, 0, CGRectGetMaxX(self.imvReverse.frame), 40);
    }
    else{
        btnReverse.frame = CGRectMake(0, 0, size.width, 40);
        self.frame = CGRectMake(0, 0, CGRectGetMaxX(btnReverse.frame), 40);
    }
}

- (void)clickAction{
    if (self.clickBlock) {
        self.clickBlock(self.tag);
    }
}

@end

@interface ETDynamicListCityCell : UITableViewCell

@property (nonatomic,strong) UILabel *labelTitle;

@property (nonatomic,strong) UIImageView *imvLine;


@end

@implementation ETDynamicListCityCell

+ (CGFloat)cellHeight{
    return 50;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isNeedTapAnimate:(BOOL)isNeedTapAnimate{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSetupSubs];
    }
    return self;
}

- (void)initSetupSubs{
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.imvLine];
    
    CGFloat cellH = [ETDynamicListCityCell cellHeight];
    self.labelTitle.frame = CGRectMake(15, 0, Screen_Width-15*2, cellH);
    self.imvLine.frame = CGRectMake(0, cellH-1, Screen_Width, 1);
}

- (UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont systemFontOfSize:15];
        _labelTitle.textColor = [UIColor blackColor];
    }
    return _labelTitle;
}



- (UIImageView *)imvLine{
    if (!_imvLine) {
        _imvLine = [[UIImageView alloc] init];
        _imvLine.contentMode = UIViewContentModeScaleAspectFill;
        _imvLine.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    }
    return _imvLine;
}

+ (instancetype)dynamicListCityCell:(UITableView *)tableView city:(NSString *)city isSelect:(BOOL)isSelect{
    ETDynamicListCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETDynamicListCityCell"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ETDynamicListCityCell" isNeedTapAnimate:NO];
    }
    [cell resetData:city isSelect:isSelect];
    return cell;
}



- (void)resetData:(NSString *)string isSelect:(BOOL)isSelect{
    self.labelTitle.text = string;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return NO;
}



@end

@interface ETDynamicListSegment ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSMutableArray *arraySegItems;
@property (nonatomic,strong) NSArray *arrayDatas;
@property (nonatomic,strong) UIView *imvLineBot;
@property (nonatomic,strong) UIView *viewBack;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) ETDynamicListSegItem *selectSegItem;
@property (nonatomic,assign) NSInteger selectCityIndex;
@property (nonatomic,copy) void (^segClickBlock)(NSInteger segIndex,NSString *cityId);
@end

@implementation ETDynamicListSegment

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        self.frame = CGRectMake(0, 0, Screen_Width, 45);
        self.selectCityIndex = 0;
        [self setupSeg];
    }
    return self;
}


- (NSArray *)arrayDatas{
    if (!_arrayDatas) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dynamic_city.plist" ofType:nil]];
        if (dict) {
            dict = [dict objectForKey:@"data"];
            if (dict) {
                _arrayDatas = [dict objectForKey:@"list"];
            }
        }
        if (!_arrayDatas) {
            _arrayDatas = [NSArray array];
        }
        
    }
    return _arrayDatas;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40-200, Screen_Width, 200) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#if __IPHONE_OS_VERSION_MAX_ALLOWED>=__IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            [_tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
#endif
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.hidden = YES;
        
        [self insertSubview:_tableView atIndex:0];
    }
    return _tableView;
}


+ (instancetype)dynamicListSegmentWithClick:(void (^)(NSInteger, NSString * _Nonnull))clickBlock{
    ETDynamicListSegment *segView = [[self alloc] init];
    segView.segClickBlock = clickBlock;
    return segView;
}

- (void)setupSeg{
    WeakSelf(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.viewBack = [[UIView alloc] init];
    self.viewBack.frame = CGRectMake(0, 0, Screen_Width, 40);
    self.viewBack.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBack];
    NSArray *array = @[@"全部地区",@"企业流转",@"企业服务"];
    CGFloat itemTotalW = Screen_Width/3;
    CGFloat centerX = itemTotalW/2;
    UIImageView *imvLine = nil;
    self.arraySegItems = [NSMutableArray array];
    for (NSInteger i = 0; i<array.count; i++) {
        NSString *title = array[i];
        ETDynamicListSegItem *item = [ETDynamicListSegItem dynamicListSegItem:title isNeedImage:i==0 click:^(NSInteger itemIndex) {
            ETDynamicListSegItem *itemTemp = weakself.arraySegItems[i];
            if (weakself.selectSegItem == itemTemp) {
                if (i == 0) {
                    if (weakself.tableView.hidden) {
                        [weakself.tableView reloadData];
                        [weakself showDataView:YES];
                        [itemTemp resetIsSubShow:YES];
                    }
                    else{
                        [weakself showDataView:NO];
                        [itemTemp resetIsSubShow:NO];
                    }
                }
                else{
                    
                    if (weakself.segClickBlock) {
                        weakself.segClickBlock(i, nil);
                    }
                }
            }
            else{
                [weakself.selectSegItem resetSelectState:NO];
                [itemTemp resetIsSubShow:NO];
                weakself.selectSegItem = itemTemp;
                [weakself.selectSegItem resetSelectState:YES];
                if (i == 0) {
                    NSDictionary *dict = weakself.arrayDatas[weakself.selectCityIndex];
                    if (weakself.segClickBlock) {
                        weakself.segClickBlock(i, dict[@"cid"]);
                    }
                }
                else{
                    [weakself showDataView:NO];
                    if (weakself.segClickBlock) {
                        weakself.segClickBlock(i, nil);
                    }
                }
            }
            [UIView animateWithDuration:0.25 animations:^{
                weakself.imvLineBot.center = CGPointMake(weakself.selectSegItem.center.x, weakself.imvLineBot.center.y);
            }];
            
            
        }];
        item.tag = i;
        item.center = CGPointMake(centerX, item.center.y);
        if (imvLine) {
            [self insertSubview:item belowSubview:imvLine];
        }
        else{
            [self addSubview:item];
        }
        
        centerX = centerX+itemTotalW;
        [self.arraySegItems addObject:item];
        if (i == 0) {
            imvLine = [[UIImageView alloc] init];
            imvLine.frame = CGRectMake(0, 37, 45, 3);
            imvLine.backgroundColor = [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
            [self addSubview:imvLine];
            self.imvLineBot = imvLine;
            self.imvLineBot.center = CGPointMake(item.center.x, imvLine.center.y);
            [item resetSelectState:YES];
            self.selectSegItem = item;
        }
    }
    
    
}

- (void)tapAction{
    [self.selectSegItem resetIsSubShow:NO];
    [self showDataView:NO];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch locationInView:self].y>CGRectGetMaxY(self.tableView.frame)) {
        return YES;
    }
    return NO;
}

- (void)showDataView:(BOOL)isShow{
    [self.tableView reloadData];
    if (isShow && !self.tableView.hidden) {
        
        return;
    }
    if (isShow) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0];
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.viewBack.frame)-200, Screen_Width, 200);
        self.tableView.hidden = NO;
    }
    
    CGRect finalTableRect = self.tableView.frame;
    UIColor *finalBackColor = nil;
    CGRect finalSelfRect = self.frame;
    
    if (isShow) {
        finalTableRect.origin.y = CGRectGetMaxY(self.viewBack.frame);
        finalBackColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
        finalSelfRect.size.height = Screen_Height-[UIApplication sharedApplication].statusBarFrame.size.height-44;
        self.frame = finalSelfRect;
    }
    else{
        finalTableRect.origin.y = CGRectGetMaxY(self.viewBack.frame)-self.tableView.frame.size.height;
        finalBackColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        finalSelfRect.size.height = 45;
    }
    WeakSelf(self);
    [UIView animateWithDuration:0.25 animations:^{
        weakself.tableView.frame = finalTableRect;
        
        
    } completion:^(BOOL finished) {
        weakself.frame = finalSelfRect;
        weakself.backgroundColor = finalBackColor;
        if (!isShow) {
            weakself.tableView.hidden = YES;
        }
        
    }];
    
}

- (void)setupTable{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ETDynamicListCityCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *city = [self.arrayDatas objectAtIndex:indexPath.row];
    BOOL isSelect = NO;
    isSelect = (self.selectCityIndex == indexPath.row);
    return [ETDynamicListCityCell dynamicListCityCell:tableView city:city[@"name"] isSelect:isSelect];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectCityIndex = indexPath.row;
    [self.tableView reloadData];
    
    NSDictionary *dict = self.arrayDatas[indexPath.row];
    [self.selectSegItem resetBtnTitle:dict[@"name"]];
    if (self.segClickBlock) {
        NSString* a=dict[@"cid"];
        self.segClickBlock(self.selectSegItem.tag, dict[@"cid"]);
    }
    [self.selectSegItem resetIsSubShow:NO];
    [self showDataView:NO];
}
@end

