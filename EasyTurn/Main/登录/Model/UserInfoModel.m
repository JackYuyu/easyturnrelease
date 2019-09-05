//
//  STLoginViewModel.m
//  Stone
//
//  Created by song on 2018/6/22.
//  Copyright © 2018年 song. All rights reserved.
//

#import "UserInfoModel.h"
#import "SSCacheManager.h"
#import "AHKeychain.h"
#define kAPPAuth_Identifier       @"APPAuth_Identifier"
//新的用户信息缓存目录
#define kCacheACUserInfoModel @"kCacheACUserInfoModel"
//新的用户信息缓存目录
#define kCacheUserInfoModel @"kCacheUserInfoModel"
@implementation UserInfoModel

+ (void)requestRegisterDataWithPhoneNum:(NSString *)phoneNumber success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure {
    NSDictionary *param = @{
                            @"phoneNumber":phoneNumber
                            
                            };
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/sMSCode"];
    [self POSTWithUrl:url param:param success:success failure:failure];
}

+ (void)requestLoginDataWithPhoneNum:(NSString *)userName WithSecurityCode:(NSString *)securityCode WithType:(NSInteger )type success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure{
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/login"];
    
    NSDictionary *dicParams = @{
                                @"mobile" : userName,
                                @"code" : securityCode,
                                @"type" : @(type)
                                };
//    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:dicParams success:success failure:failure];
}



+ (void)requestBindingUsername:(NSString *)username
            WithInvitationCode:(NSString *)invitationCode
                       success:(STBaseModelRequestSuccess)success
                       failure:(STBaseModelRequestFailure)failure{
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/bindingUserCode"];
    
    NSDictionary *dicParams = @{
                                @"mobile" : username,
                                @"userCode" : invitationCode
                                };
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}



+ (void)requestConfirmForgetWithPhoneNum:(NSString *)phoneNumber success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure{
    
    NSDictionary *param = @{
                            @"phoneNumber":phoneNumber
                            
                            };
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/updatePasswordSMSCode"];
    [self POSTWithUrl:url param:param success:success failure:failure];
}


+ (void)requestConfirmForgetWithPhoneNum:(NSString *)userName WithPassWord:(NSString *)passWord WithSecurityCode:(NSString *)securityCode  success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure{
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/updatePassword"];
    
    NSDictionary *dicParams = @{
                                @"mobile" : userName,
                                @"password" : passWord,
                                @"code" : securityCode
                                };
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
    
}

+ (void)requestLoginOutWithSuccess:(STBaseModelRequestSuccess)success
                           failure:(STBaseModelRequestFailure)failure{
    
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/logout"];
    
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:nil];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}

/**
 第三方登录回调
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestThirdLoginWithOpenId:(NSString *)openId
               WithRequestThirdType:(RequestThirdType )requestThirdType
                            Success:(STBaseModelRequestSuccess)success
                            failure:(STBaseModelRequestFailure)failure{
    NSString *url = nil;
    if (requestThirdType == RequestThirdTypeWinxin) {
        url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/wechat"];
        
    }else if (requestThirdType == RequestThirdTypeQQ){
        url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/tencent"];
        
    }else if (requestThirdType == RequestThirdTypeWeibo){
        url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/sina"];
    }
    
    NSDictionary *dicParams = @{
                                @"openId" : openId,
                                };
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}

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
                         WithOpenIdType:(NSInteger )openId_type
                                Success:(STBaseModelRequestSuccess)success
                                failure:(STBaseModelRequestFailure)failure{
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/bindingUser"];
    NSDictionary *dicParams = @{
                                @"mobile": username,
                                @"openId" : openId,
                                @"code" : code,
                                @"photoUrl" : photoURL,
                                @"nickName" : name,
                                @"openIdType": @(openId_type)
                                };
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
    
    
}

/**
 绑定系统推荐码
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestBindingDefaultInvitationWithphoneNumber:(NSString *)phoneNumber
                                               Success:(STBaseModelRequestSuccess)success
                                               failure:(STBaseModelRequestFailure)failure{
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathUser file:@"/defaultInvitation"];
    NSDictionary *dicParams = @{
                                @"phoneNumber" : phoneNumber
                                };
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}

/**
 获取腾讯云userSig
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestGetUserSigWithStatus:(NSString *)status
                            Success:(STBaseModelRequestSuccess)success
                            failure:(STBaseModelRequestFailure)failure{
    
    NSString *url = [STApiHelper urlWithHost:devHost_Http_App path:pathMyInformation file:@"/getUserSig"];
    NSDictionary *dicParams = @{
                                @"status" : status
                                };
    NSDictionary *mDic = [STApiHelper signNeedOptionParams:dicParams];
    [self POSTWithUrl:url param:mDic success:success failure:failure];
}

#pragma mark - 本地数据

static UserInfoModel *_mUserInfo = nil;

+ (void)saveUserInfoModel:(UserInfoModel *)mUser {
    NSDictionary *dictUserInfo = mUser.mj_keyValues;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dictUserInfo forKey:kCacheUserInfoModel];
    [userDefaults synchronize];
}

+ (UserInfoModel *)loadUserInfoModel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults objectForKey:kCacheUserInfoModel];
    NSData *data = [userDefaults objectForKey:kCacheUserInfoModel];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        UserInfoModel *mUserInfo = [UserInfoModel mj_objectWithKeyValues:dict];
        return mUserInfo;
        
    }else if ([data isKindOfClass:[NSData class]]) {
        //兼容老用户,1.0.4之前保存的字典类型是NSData
        NSDictionary *dict = data ? [NSKeyedUnarchiver unarchiveObjectWithData:data] : nil;
        UserInfoModel *mUserInfo = [UserInfoModel mj_objectWithKeyValues:dict];
        return mUserInfo;
    } else{
        //兼容老用户,1.0.2之前保存到NSCachesDirectory
        NSData *data = [[SSCacheManager sharedCacheManagerForApp] loadCacheWithDirName:kCacheDataDir fileName:kCacheACUserInfoModel];
        NSDictionary *dict = data ? [NSKeyedUnarchiver unarchiveObjectWithData:data] : nil;
        UserInfoModel *mUserInfo = [UserInfoModel mj_objectWithKeyValues:dict];
        return mUserInfo;
    }
    
}

+ (BOOL)delelteUserInfoModel {
    [SSUserLoginModel deleteLoginInfo];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userDefaultsData = [userDefaults objectForKey:kCacheUserInfoModel];
    if (userDefaultsData) {
        [userDefaults removeObjectForKey:kCacheUserInfoModel];
        [userDefaults synchronize];
        return YES;
    }else{
        BOOL success = [[SSCacheManager sharedCacheManagerForApp] clearCacheFileWithDirName:kCacheDataDir fileName:kCacheACUserInfoModel];
        if (success) {
            _mUserInfo = nil;
            //删除自动登录信息 （钥匙串信息）
            [SSUserLoginModel deleteLoginInfo];
        }
        return success;
    }
    return YES;
}


@end

@implementation NewsDispatchModel

@end
