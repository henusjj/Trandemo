//
//  APIManager.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/9.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <Foundation/Foundation.h>

//AFN有网络监听-AFNetworkReachabilityManager

#define TimeOutInterval 10  //请求超时时间

//请求成功或是失败的回调
@protocol responseDelegates <NSObject>

-(void)requestSucesses:(id)responseData;
-(void)requestError:(NSError *)error;



@end

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject
@property(nonatomic,weak)id <responseDelegates> delegate;
+(APIManager *)manager;

//get请求
-(void)GET:(NSString *)url andWithParam:(NSMutableDictionary *)param;
//post请求
-(void)postWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter;

/**
 上传文件(图片时pareameter可为nil，视频时需要添加mimeType,suffix，value值设置文件类型和文件名后缀)
 
 @param url 服务器url
 @param fileData 文件数据流
 @param namekey 文件数据对应的name
 @param fileName1 文件在服务器存储时的名字
 @param pareameter 包含文件类型(mimeType)，名字后缀(suffix),默认是 image/jepg,jepg
 */
-(void)uploadFileWithUrl:(NSString *)url fileDataStream:(NSData *)fileData nameKey:(NSString *)nameKey fileName:(NSString *)fileName1 parameter:(NSMutableDictionary *)pareameter;



/**
 批量上传文件
 @param url 地址url
 @param imageDataArray 文件数据流数组
 @param nameKey 文件名称
 @param fileName 文件在服务器存储时的名字
 @param pareameter pareameter description

 */
-(void)uploadFileWithUrlMore:(NSString *)url fileDataArray:(NSArray *)imageDataArray nameKey:(NSString *)nameKey fileName:(NSString *)fileName parameter:(NSMutableDictionary *)pareameter;



//下载

@end

NS_ASSUME_NONNULL_END
