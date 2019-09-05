//
//  STBaseModel.h
//  Stone
//
//  Created by GeWei on 2018/6/22.
//  Copyright © 2018年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STResponseModel.h"
@class STResponseModel;
typedef void(^STBaseModelRequestSuccess)(id request, STResponseModel *response, id resultObject);
typedef void(^STBaseModelRequestFailure)(id request, NSError *error);

@interface STBaseModel : NSObject

/**
 POST请求
 
 @param url 服务器地址
 @param param 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTWithUrl:(NSString *)url param:(NSDictionary *)param success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure;


/**
 图片上传

 @param dic 传入参数
 @param fileType 服务器对应图片的key : imagFile
 @param requestName 服务器地址
 @param imagedata 图片数据
 @param filename 图片名称
 @param block 回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (AFHTTPSessionManager *)dataWithDicPosturl:(NSDictionary *)dic andFileType:(NSString*)fileType andRequestName:(NSString *)requestName andRequestName:(NSData *)imagedata filename:(NSString*)filename andBlock:(void(^)(NSString *responeStr, NSMutableDictionary * responeDic, NSString *code))block success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure;

/**
 视频上传
 
 @param dic 传入参数
 @param fileType 服务器对应图片的key : imagFile
 @param requestName 服务器地址
 @param imagedata 图片数据
 @param filename 图片名称
 @param block 回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (AFHTTPSessionManager *)updataVideoWithDicPosturl:(NSDictionary *)dic andFileType:(NSString*)fileType andRequestName:(NSString *)requestName andRequestName:(NSData *)imagedata filename:(NSString*)filename andBlock:(void(^)(NSString *responeStr, NSMutableDictionary * responeDic, NSString *code))block success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure;
@end
