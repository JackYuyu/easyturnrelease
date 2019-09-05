//
//  ETMineVIew.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/19.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol AccountBindingDelegate <NSObject>
- (void)imgjumpWeb:(UIImageView*)sender;
- (void)putjumpWeb:(UIButton*)sender;
- (void)jumpWebVC:(UIButton*)sender;
- (void)jumpWebVC1:(UIButton*)sender;
- (void)jumpWebVC2:(UIButton*)sender;
- (void)jumpWebVC3:(UIButton*)sender;
- (void)jumpWebVC4:(UIButton*)sender;
- (void)jumpWebVC5:(UIButton*)sender;
@end
@interface ETMineVIew : UIView
@property (nonatomic, weak) id<AccountBindingDelegate> delegate;

@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)UIImageView * img;

@property(nonatomic,strong)UIImageView * photoImg;
@property(nonatomic,strong)UIImageView * bianjiImg;
@property(nonatomic,strong)UILabel * nameLab;

@property(nonatomic,strong)UILabel * companyLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView * cImg;
@property(nonatomic,strong)UIImageView * entpriseImg;
@property(nonatomic,strong)UILabel *renzhengLab;
@property(nonatomic,strong)UIButton * signBtn;
@property(nonatomic,strong)UIButton *huiyuanBtn;
@property(nonatomic,strong)UIButton * putBtn;
@property(nonatomic,strong)UIView *xiaobiaoView;
@property(nonatomic,strong)UIButton *memberv;
@property(nonatomic,strong)UIImageView * qifuheImg;
@property(nonatomic,strong)UIImageView *memberi;

@property(nonatomic,strong)UILabel *memberLab;

@property(nonatomic,strong)UIButton *statusv;

@property(nonatomic,strong)UIImageView *statusi;

@property(nonatomic,strong)UILabel *statusLab;

@property(nonatomic,strong)UIButton *meinv;

@property(nonatomic,strong)UIImageView *meini;

@property(nonatomic,strong)UILabel *meinLab;

@property(nonatomic,strong)UIButton *accountv;

@property(nonatomic,strong)UIImageView *accounti;

@property(nonatomic,strong)UILabel *accountLab;

@property(nonatomic,strong)UIView *grayView1;

@property(nonatomic,strong)UIView *orangeView;

@property(nonatomic,strong)UILabel *surLab;

@property(nonatomic,strong)UILabel *numLab;

@property(nonatomic,strong)UILabel*speedLab;

@property(nonatomic,strong)UIButton *buyBtn;

@property(nonatomic,strong)UIView *grayView2;

@property(nonatomic,strong)UIButton *sellBtn;

@property(nonatomic,strong)UIButton *giveBtn;

@property(nonatomic,strong)UIButton *wantBtn;

@property(nonatomic,strong)UIButton *wholeBtn;

@property(nonatomic,strong)NSMutableArray*viewArray;

@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)UIImage* port;
//界面

@property(copy, nonatomic)void (^block)(NSString* a );
@property (nonatomic, strong) NSMutableArray *buttons;
- (void)postUI;
@end

NS_ASSUME_NONNULL_END
