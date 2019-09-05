//
//  STBaseModel.m
//  Stone
//
//  Created by GeWei on 2018/6/22.
//  Copyright © 2018年 song. All rights reserved.
//

#import "STBaseModel.h"
#import "STResponseModel.h"
#import "SSPayUtils.h"
/// 200：返回正确
static NSInteger const code200 = 200;
/// 1000：普通错误
static NSInteger const code1000 = 1000;
/// 1003：返回的data可解析为json对象
static NSInteger const code1003 = 1003;
/// 100：未登录
static NSInteger const code100 = 100;
/// 101：多端登录
static NSInteger const code101 = 101;
/// 1001：服务器报错
static NSInteger const code1001 = 1001;

@implementation STBaseModel


+ (void)POSTWithUrl:(NSString *)url param:(NSDictionary *)param success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure {
    

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    config.timeoutIntervalForRequest = 15.0;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/plain",@"text/xml",@"application/xml",@"image/jpeg", nil];
//    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    NSString *token = [UserInfoModel loadUserInfoModel].token;
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [manager POST:url
       parameters:param
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
              NSLog(@"请求服务器成功,%@",responseObject);
              [self handelResponseObjectWithTask:task responseObject:responseObject success:success];
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (error.code == -1001) {
                  [[ACToastView toastView]showErrorWithStatus:@"请求超时"];
              }else if (error.code == 503){
                  [[ACToastView toastView]showErrorWithStatus:@"请求超时"];
              }else if (error.code == 3840){
                  [[ACToastView toastView]showErrorWithStatus:kToastErrorServerNoErrorMessage];
              }else if (error.code == -1004){
                  [[ACToastView toastView]showErrorWithStatus:kToastErrorServerNoErrorMessage];
              }else if (error.code == -1009){
                  [[ACToastView toastView]showErrorWithStatus:@"当前网络不可用,请检查您的网络设置"];
              } else {
                  [[ACToastView toastView]showErrorWithStatus:kToastErrorServerNoErrorMessage];
              }
              NSLog(@"请求服务器失败,%@",error);
              // 请求失败
              if (failure) {
                  failure(task, error);
              }
              
          }];
    
}

+ (AFHTTPSessionManager *)dataWithDicPosturl:(NSDictionary *)dic andFileType:(NSString*)fileType andRequestName:(NSString *)requestName andRequestName:(NSData *)imagedata filename:(NSString*)filename andBlock:(void(^)(NSString *responeStr, NSMutableDictionary * responeDic, NSString *code))block success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure{
    NSString *urlStr = nil;
    urlStr = requestName;
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/plain",@"text/xml",@"application/xml",@"image/jpg", nil];
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imagedata name:fileType fileName:filename mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(nil, responseObject, @"1");
        [self handelResponseObjectWithTask:task responseObject:responseObject success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [[ACToastView toastView]showErrorWithStatus:kToastErrorServerNoErrorMessage];
        NSLog(@"请求服务器失败,%@",error);
        // 请求失败
        if (failure) {
            
            failure(task, error);
        }
    }];
    return manager;
}

+ (AFHTTPSessionManager *)updataVideoWithDicPosturl:(NSDictionary *)dic andFileType:(NSString*)fileType andRequestName:(NSString *)requestName andRequestName:(NSData *)imagedata filename:(NSString*)filename andBlock:(void(^)(NSString *responeStr, NSMutableDictionary * responeDic, NSString *code))block success:(STBaseModelRequestSuccess)success failure:(STBaseModelRequestFailure)failure{
    NSString *urlStr = nil;
    urlStr = requestName;
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/plain",@"text/xml",@"application/xml",@"image/jpg", nil];
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imagedata name:fileType fileName:filename mimeType:@"video/mpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(nil, responseObject, @"1");
        [self handelResponseObjectWithTask:task responseObject:responseObject success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[ACToastView toastView]showErrorWithStatus:kToastErrorServerNoErrorMessage];
        NSLog(@"请求服务器失败,%@",error);
        // 请求失败
        if (failure) {
            
            failure(task, error);
        }
    }];
    return manager;
}



+ (void)handelResponseObjectWithTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject success:(STBaseModelRequestSuccess)success {
    
    // 如果是有效的字典格式的
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        STResponseModel *mResponse = [STResponseModel mj_objectWithKeyValues:responseObject];
        if (mResponse) {
            // 有数据
            if (mResponse.data) {
                if ([mResponse.data isKindOfClass:[NSDictionary class]]) {
                    mResponse.data = [self.class mj_objectWithKeyValues:mResponse.data];
                }
                else if ([mResponse.data isKindOfClass:[NSArray class]]) {
                    mResponse.data = [self.class mj_objectArrayWithKeyValuesArray:mResponse.data];
                }
                if (success) {
                    success(task, mResponse, responseObject);
                }
            }else {
                // 只有code和msg
                if (success) {
                    success(task, mResponse, responseObject);
                    if (mResponse.code == code100) {
                        if ([[SSPayUtils shareUser].introduce isEqualToString:APP_VERSION]) {
                            [[NSNotificationCenter defaultCenter]postNotificationName:LoginBeOverdue object:nil];
                            
                        }else{
                            [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil];
                        }
                    }else if (mResponse.code == code101){
                        [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil];
                        [[ACToastView toastView]showInfoWithStatus:@"该账户已在其他设备上登录,请重新登录"];
                    }
                }
            }
        }
        else {
            // 没有返回正确数据结构
            if (success) {
                success(task, mResponse, responseObject);
            }
        }
    }
    else {
        // 非字典格式，主要获取图片等功能用
        STResponseModel *mResponse = [[STResponseModel alloc] init];
        mResponse.code = -1;
        
        if (success) {
            success(task, mResponse, responseObject);
        }
    }
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"baesId": @"id"};
}
@end
