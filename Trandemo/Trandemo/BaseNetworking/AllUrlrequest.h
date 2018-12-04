//
//  AllUrlrequest.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/9.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"
#import "upLoadModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol responseDelegate <NSObject>
@optional
-(void)requestSucesses:(id)responseData;
-(void)requestError:(NSError *)error;
@end

@interface AllUrlrequest : NSObject<responseDelegates>

@property(nonatomic,weak)id <responseDelegate> delegate;

+(AllUrlrequest *)Network;
//首页请求


/**
 1.登录请求示例，

 @param url 请求url
 @param param 请求参数
 */
-(void)LoginPostWithUrl:(NSString *)url andParam:(NSDictionary *)param;


/**
 2.登录请求示例二，参数，url，本类配置，避免外泄
 */
-(void)LoginRequest;


/**
 3.单张r图片上传
 */
-(void)upLoadImageRequestWithMode:(upLoadModel *)mode andWithURL:(NSString *)url;





@end

NS_ASSUME_NONNULL_END
