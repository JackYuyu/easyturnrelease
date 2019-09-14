/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define TopHeight     (IPHONE_X?88:64)
#define Screen_Width [[UIScreen mainScreen]bounds].size.width
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define kIsFullScreenIPhone (Screen_Height == 812.f || Screen_Height == 896.f)
#define kSafeAreaBottomH ((kIsFullScreenIPhone) ? (34) : (0))
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#import "EaseConversationListViewController.h"

#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseMessageViewController.h"
#import "NSDate+Category.h"
#import "EaseLocalDefine.h"
#import "AFNetworking.h"
#import "EaseUserModel.h"
#import "Masonry.h"
@interface EaseConversationListViewController ()
@property (nonatomic,strong) NSMutableArray* system;
@property (nonatomic,strong) NSMutableArray* list;
@property(strong,nonatomic)NSString *touser;
@property(strong,nonatomic)NSString *touserAvat;
@property(strong,nonatomic)NSString *touserNick;
@property(strong,nonatomic)NSString *auroraname;
@property(strong,nonatomic)UIView *navigationView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic,assign) BOOL cart;
@property(strong,nonatomic)NSString *releaseId;
@property(strong,nonatomic)EaseMessageViewController *vc;
@property(nonatomic,strong)NSString* count;
@end

@implementation EaseConversationListViewController
-(void)getcount
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
   // 2.发送GET请求
    [mgr GET:[NSString stringWithFormat:@"%@/%@", @"https://app.yz-vip.cn", @"push/countPushInfo"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        _count=[NSString stringWithFormat:@"%d", [responseObject[@"data"] intValue] ];
        NSLog(@"");
        [self.tableView reloadData];

//        _touserAvat=responseObject[@"data"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)getavatr
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSDictionary *params = @{
                             @"auroraName" : _touser
                             };    // 2.发送GET请求
    [mgr GET:[NSString stringWithFormat:@"%@/%@", @"https://app.yz-vip.cn", @"user/getUserAvatar"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        _touserAvat=responseObject[@"data"];
        [self getNick];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

-(void)getNick
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSDictionary *params = @{
                             @"auroraName" : _touser
                             };    // 2.发送GET请求
    [mgr GET:[NSString stringWithFormat:@"%@/%@", @"https://app.yz-vip.cn", @"user/getJimUserFromAuroraName"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if ([responseObject[@"code"] isEqualToString:@"4011"]) {
            return;
        }

        _touserNick=responseObject[@"data"][@"username"];
        [self.tableView reloadData];
//        self.title=_touserNick;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}
- (id)filterNull:(id)obj{
    if (obj && ![obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    return nil;
}
- (void)getMsgToBuyer:(void(^)(BOOL cart, NSError *error))completion {
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSDictionary *params = @{
                             @"auroraName" : _auroraname
                             };    // 2.发送GET请求
    [mgr GET:[NSString stringWithFormat:@"%@/%@", @"https://app.yz-vip.cn", @"release/getMsgToBuyer"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        _touserAvat=responseObject[@"data"];
//        [self getNick];
        if (![responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            _cart=YES;
            NSString* a=responseObject[@"data"][@"releaseId"];
            _vc.releaseid=responseObject[@"data"][@"releaseId"];
            NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
            [ud setObject:responseObject[@"data"][@"forUserId"] forKey:@"foruserid"];
            if (completion) {
                completion(YES, nil);
            }
        }else{
            if (completion) {
                completion(NO, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO, error);
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self tableViewDidTriggerHeaderRefresh];
    [self registerNotifications];
    [self tableViewDidTriggerHeaderRefresh];
    _system=[NSMutableArray new];
    EaseMessageModel* m=[EaseMessageModel new];
    m.text=@"易转官方消息";
    m.address=@"有一条新的平台消息";
    [_system addObject:m];
    EaseMessageModel* m1=[EaseMessageModel new];
    m1.text=@"易转平台求购消息";
    m1.address=@"有一条求购消息";
    [_system addObject:m1];
    // Do any additional setup after loading the view.
    _list=[EaseMessageModel bg_findAll:@"EaseMessageModel"];
////    _system=[list mutableCopy];
//    [_system addObjectsFromArray:list];

    NSLog(@"");
    _navigationView.hidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
    _navigationView.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
//    self.navigationController.navigationBar.hidden=YES;
    _cart=NO;
    [self getcount];
//    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, TopHeight)];
//    _navigationView.backgroundColor = kACColorClear;
//    [self.view addSubview:_navigationView];
//    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _leftButton.frame = CGRectMake(15, StatusBarHeight+15, 30, 30);
//    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
//    [_leftButton setImage:[UIImage imageNamed:@"商品_分组 7"] forState:(UIControlStateNormal)];
//    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [_navigationView addSubview:_leftButton];
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, TopHeight)];
    _navigationView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:_navigationView];
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftButton.frame = CGRectMake(15, 22, 55, 45);
    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
    [_leftButton setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:(UIControlStateNormal)];
    
    UILabel *wxLab=[[UILabel alloc]initWithFrame:CGRectMake(15, TopHeight-40, 120, 40)];
    wxLab.text=@"消息列表";
    wxLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_navigationView addSubview:wxLab];
//    [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(57);
//        make.size.mas_equalTo(CGSizeMake(119, 21));
//    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(7, 22+7, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    _leftButton=btn;
    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [_navigationView addSubview:_leftButton];
//    [self.navigationController.view addSubview:_navigationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.title=@"消息";
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        if (_system.count>0) {
            return _system.count;
            
        }
        else
        {
            return 0;
        }
    }
    else {
        // Return the number of rows in the section.
        return [self.dataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
    EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            EaseMessageModel* msg=[_system objectAtIndex:indexPath.row];
            cell.titleLabel.text = msg.text;
            cell.avatarView.image=[UIImage imageNamed:@"WechatIMG222"];
            cell.avatarView.layer.cornerRadius = 20;
            cell.avatarView.layer.masksToBounds = YES;
            cell.detailLabel.text=msg.address;
//            if (_system.count>0) {
//                
//                EaseMessageModel* msg=[_list objectAtIndex:0];
//                cell.detailLabel.text=msg.address;
//            }
        }
        else{
            EaseMessageModel* msg=[_system objectAtIndex:indexPath.row];
            cell.titleLabel.text=msg.text;
            cell.avatarView.image=[UIImage imageNamed:@"WechatIMG111"];
            cell.avatarView.layer.cornerRadius = 20;
            cell.avatarView.layer.masksToBounds = YES;
            cell.detailLabel.text=msg.address;
            if ([_count intValue]>0) {

            UIImageView* bad=[UIImageView new];
            [bad setBackgroundColor:[UIColor redColor]];
            bad.layer.cornerRadius=10;
            bad.layer.masksToBounds=YES;
            
            UILabel* c=[UILabel new];
            c.text=_count;
            c.textColor=[UIColor whiteColor];
            c.font=[UIFont systemFontOfSize:10];
            [bad addSubview:c];
            
            [cell.contentView addSubview:bad];
            [bad mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.mas_right).mas_equalTo(-30);
                make.size.mas_equalTo(20,20);
                make.centerY.mas_equalTo(cell);
            }];
            
            [c mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(10,10);
                make.center.mas_equalTo(bad);
            }];
            }
            
            cell.avatarView.showBadge=YES;
            cell.avatarView.badge=10;
        }
    }
    else{
        if ([self.dataArray count] <= indexPath.row) {
            return cell;
        }
        
        id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row];
        cell.model = model;
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
            NSMutableAttributedString *attributedText = [[_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model] mutableCopy];
            [attributedText addAttributes:@{NSFontAttributeName : cell.detailLabel.font} range:NSMakeRange(0, attributedText.length)];
            cell.detailLabel.attributedText =  attributedText;
        } else {
            cell.detailLabel.attributedText =  [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:[self _latestMessageTitleForConversationModel:model]textFont:cell.detailLabel.font];
        }
        
        //
        _touser=model.title;
        NSDictionary* d=model.conversation.latestMessage.ext;
        NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"buddy"),bg_sqlValue(model.title)];
        
        NSArray * array1 = [EaseUserModel bg_find:@"EaseUserModel" where:where];        NSLog(@"");
        if (array1.count>0) {
            EaseUserModel* from=array1[0];
            model.title=from.nickname;
            model.avatarURLPath=from.avatarURLPath;
            cell.model=model;
            
        }
        else if(!_touserAvat)
        {
            [self getavatr];
        }
        else
        {
            model.title=_touserNick;
            model.avatarURLPath=_touserAvat;
            cell.model=model;
        }
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
            cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
        } else {
            cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
        }

        
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EaseConversationCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (self.block) {
            self.block(indexPath.row);
//            _navigationView.hidden=YES;
            return;
        }
//        EaseSystemController* s=[EaseSystemController new];
//        [self.navigationController pushViewController:sys animated:YES];
    }
//        _navigationView.hidden=YES;;
    if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:didSelectConversationModel:)]) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [_delegate conversationListViewController:self didSelectConversationModel:model];
    } else {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        _auroraname=model.conversation.conversationId;
        EaseMessageViewController *viewController = [[EaseMessageViewController alloc] initWithConversationChatter:model.conversation.conversationId conversationType:model.conversation.type];
        viewController.cartcontroller=_cart;
        
//        viewController.releaseid=_releaseId;
        viewController.block = ^(NSString *a) {
            if (self.block1) {
                self.block1(a);
            }
        };
        viewController.title = model.title;
        _vc=viewController;
        __weak typeof(self) weakself = self;
        [self getMsgToBuyer:^(BOOL cart, NSError *error) {
            weakself.vc.cartcontroller = cart;
            [weakself.navigationController pushViewController:weakself.vc animated:YES];
        }];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //在iOS8.0上，必须加上这个方法才能出发左划操作
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self setupCellEditActions:indexPath];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self setupCellEditActions:indexPath];
}

#pragma mark - Action

- (void)deleteCellAction:(NSIndexPath *)aIndexPath
{
    EaseConversationModel *model = [self.dataArray objectAtIndex:aIndexPath.row];
    [[EMClient sharedClient].chatManager deleteConversation:model.conversation.conversationId isDeleteMessages:YES completion:nil];
    [self.dataArray removeObjectAtIndex:aIndexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:aIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (id)setupCellEditActions:(NSIndexPath *)aIndexPath
{
    if ([UIDevice currentDevice].systemVersion.floatValue < 11.0) {
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"删除",@"删除") handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self deleteCellAction:indexPath];
        }];
        deleteAction.backgroundColor = [UIColor redColor];
        return @[deleteAction];
    } else {
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:NSLocalizedString(@"删除",@"删除") handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            [self deleteCellAction:aIndexPath];
        }];
        deleteAction.backgroundColor = [UIColor redColor];
        
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
        config.performsFirstActionWithFullSwipe = NO;
        return config;
    }
}


#pragma mark - data

-(void)refreshAndSortView
{
    if ([self.dataArray count] > 1) {
        if ([[self.dataArray objectAtIndex:0] isKindOfClass:[EaseConversationModel class]]) {
            NSArray* sorted = [self.dataArray sortedArrayUsingComparator:
                               ^(EaseConversationModel *obj1, EaseConversationModel* obj2){
                                   EMMessage *message1 = [obj1.conversation latestMessage];
                                   EMMessage *message2 = [obj2.conversation latestMessage];
                                   if(message1.timestamp > message2.timestamp) {
                                       return(NSComparisonResult)NSOrderedAscending;
                                   }else {
                                       return(NSComparisonResult)NSOrderedDescending;
                                   }
                               }];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:sorted];
        }
    }
    [self.tableView reloadData];
}

/*!
 @method
 @brief 加载会话列表
 @discussion
 @result
 */
- (void)tableViewDidTriggerHeaderRefresh
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
                       }];
    
    
    
    [self.dataArray removeAllObjects];
    for (EMConversation *converstion in sorted) {
        EaseConversationModel *model = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
            model = [self.dataSource conversationListViewController:self
                                               modelForConversation:converstion];

        }
        else{
            model = [[EaseConversationModel alloc] initWithConversation:converstion];
        }
        
        if (model) {
            [self.dataArray addObject:model];
        }
    }
    
    [self.tableView reloadData];
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
}

#pragma mark - EMGroupManagerDelegate

- (void)didUpdateGroupList:(NSArray *)groupList
{
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - private

/*!
 @method
 @brief 获取会话最近一条消息内容提示
 @discussion
 @param conversationModel  会话model
 @result 返回传入会话model最近一条消息提示
 */
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = @"[图片]";
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = @"[音频]";
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = @"[位置]";
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = @"[视频]";
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = @"[文件]";
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

/*!
 @method
 @brief 获取会话最近一条消息时间
 @discussion
 @param conversationModel  会话model
 @result 返回传入会话model最近一条消息时间
 */
- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
        NSDate* nd=[NSDate dateWithTimeIntervalSince1970:timeInterval];
        latestMessageTime=[nd formattedTime];
    }
    return latestMessageTime;
}

@end
