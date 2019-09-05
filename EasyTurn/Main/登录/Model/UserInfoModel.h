//
//  STLoginViewModel.h
//  Stone
//
//  Created by song on 2018/6/22.
//  Copyright © 2018年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBaseModel.h"
@class NewsDispatchModel;
typedef NS_ENUM(NSUInteger, RequestThirdType) {
    ///qq
    RequestThirdTypeQQ,
    ///微信
    RequestThirdTypeWinxin,
    ///微博
    RequestThirdTypeWeibo
};
@interface UserInfoModel : STBaseModel
///微信
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *headimgurl;


@property (nonatomic, copy) NSString *vip;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *auroraName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *vipExpiryDate;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *authed;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *refreshCount;
@property (nonatomic, copy) NSString *vipDesc;
@property (nonatomic, copy) NSString *name;
///绑定第三方回调标识
@property (nonatomic, assign) NSInteger openIdType;

@property (nonatomic, copy) NSString *wechatName;
@property (nonatomic, copy) NSString *wechatPhotourl;

///第三方登录返回数据参数
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionId;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *thirdName;
@property (nonatomic, copy) NSString *iconurl;
@property (nonatomic, copy) NSString *invitationCodeUtilMe;
///腾讯云IM返回参数
@property (nonatomic, strong) NewsDispatchModel *newsDispatch;

@property (nonatomic, copy) NSString *isChecked;
@property (nonatomic, copy) NSString *isSign;

@property (nonatomic, copy) NSString *company;

/**
 发送短信验证码
 
 @param phoneNumber 手机号
 */
+ (void)requestRegisterDataWithPhoneNum:(NSString *)phoneNumber
                                success:(STBaseModelRequestSuccess)success
                                failure:(STBaseModelRequestFailure)failure;


/**
 验证码登录接口
 
 @param userName 用户名
 @param securityCode 验证码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestLoginDataWithPhoneNum:(NSString *)userName
                    WithSecurityCode:(NSString *)securityCode
                            WithType:(NSInteger )type
                             success:(STBaseModelRequestSuccess)success
                             failure:(STBaseModelRequestFailure)failure;


/**
 绑定邀请码
 
 @param invitationCode 邀请码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestBindingUsername:(NSString *)username
            WithInvitationCode:(NSString *)invitationCode
                       success:(STBaseModelRequestSuccess)success
                       failure:(STBaseModelRequestFailure)failure;

/**
 获取修改密码短信验证码
 
 @param phoneNumber 手机号
 */
+ (void)requestConfirmForgetWithPhoneNum:(NSString *)phoneNumber
                                 success:(STBaseModelRequestSuccess)success
                                 failure:(STBaseModelRequestFailure)failure;

/**
 修改密码
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestConfirmForgetWithPhoneNum:(NSString *)userName
                            WithPassWord:(NSString *)passWord
                        WithSecurityCode:(NSString *)securityCode
                                 success:(STBaseModelRequestSuccess)success
                                 failure:(STBaseModelRequestFailure)failure;

/**
 用户退出登录接口
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestLoginOutWithSuccess:(STBaseModelRequestSuccess)success
                           failure:(STBaseModelRequestFailure)failure;

/**
 第三方登录回调
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestThirdLoginWithOpenId:(NSString *)openId
               WithRequestThirdType:(RequestThirdType )requestThirdType
                            Success:(STBaseModelRequestSuccess)success
                            failure:(STBaseModelRequestFailure)failure;

/**
 第三方绑定用户
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestThirdBindingWithUserName:(NSString *)username
                        WithTHirdOpenId:(NSString *)openId
                          WithTHirdCode:(NSString *)code
                      WithTHirdPhotoURL:(NSString *)photoURL
                          WithTHirdName:(NSString *)name
                         WithOpenIdType:(NSInteger )openIdType
                                Success:(STBaseModelRequestSuccess)success
                                failure:(STBaseModelRequestFailure)failure;

/**
 绑定系统推荐码
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestBindingDefaultInvitationWithphoneNumber:(NSString *)phoneNumber
                                               Success:(STBaseModelRequestSuccess)success
                                               failure:(STBaseModelRequestFailure)failure;

/**
 获取腾讯云userSig
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestGetUserSigWithStatus:(NSString *)status
                            Success:(STBaseModelRequestSuccess)success
                            failure:(STBaseModelRequestFailure)failure;


#pragma mark - 本地数据
/**
 保存用户登录信息
 
 @param mUser 用户信息
 */
+ (void)saveUserInfoModel:(UserInfoModel *)mUser;

/**
 获取用户登录信息
 
 @return UserInfoModel
 */
+ (UserInfoModel *)loadUserInfoModel;

/**
 清除保存的用户信息
 
 @return 是否成功
 */
+ (BOOL)delelteUserInfoModel;


@end

@interface NewsDispatchModel : STBaseModel

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *userSig;

@end
