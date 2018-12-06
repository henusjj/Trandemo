//
//  APIManager.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/9.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "APIManager.h"
#import "Reachability.h"//网络监听
@interface APIManager()

@property(nonatomic,strong)AFHTTPSessionManager *managers;
@end
@implementation APIManager
+(APIManager *)manager{
    static APIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc]init];
    });
    return manager;
}
- (AFHTTPSessionManager *)managers{
    _managers = [AFHTTPSessionManager manager];
    _managers.requestSerializer = [AFHTTPRequestSerializer serializer];
    _managers.responseSerializer = [AFHTTPResponseSerializer serializer];
    _managers.requestSerializer.timeoutInterval = TimeOutInterval;
    _managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"text/json",@"text/javascript", nil];
    
    
    return _managers;
}

-(void)GET:(NSString *)url andWithParam:(NSMutableDictionary *)param{
        AFHTTPSessionManager * manager = self.managers;
//    AFHTTPSessionManager * managers = [AFHTTPSessionManager manager];
//    managers.requestSerializer = [AFHTTPRequestSerializer serializer];
//    managers.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //超时时间
//    managers.requestSerializer.timeoutInterval = TimeOutInterval;
//    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    //判断网络状态
    NetworkStatus netStatu = [self getNetworkStatus];
    if (netStatu == NotReachable) {
        return ;
    }
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
//        请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        请求成功
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSucesses:)]) {
                [self.delegate requestSucesses:dict];
            }
        } else {
           //windown 弹出提示框，暂无数据
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        请求失败
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestError:)]) {
            [self.delegate requestError:error];
        }
    }];
}


//Post
-(void)postWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter{
    AFHTTPSessionManager * manager = self.managers;
    //判断网络状态
    NetworkStatus netStatu = [self getNetworkStatus];
    if (netStatu == NotReachable) {
        return ;
    }
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        请求成功
        if(responseObject){
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSucesses:)]) {
                [self.delegate requestSucesses:dict];
            }
        } else {
            //windown 弹出提示框，暂无数据
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        请求失败
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestError:)]) {
            [self.delegate requestError:error];
        }
    }];

}

//上传图片单个图片
-(void)uploadFileWithUrl:(NSString *)url fileDataStream:(NSData *)fileData nameKey:(NSString *)nameKey fileName:(NSString *)fileName1 parameter:(NSMutableDictionary *)pareameter{
    AFHTTPSessionManager *manager = self.managers;
//    设置请求头类型
    [manager.requestSerializer setValue:@"from/data" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:nameKey fileName:nameKey mimeType:fileName1];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        NSLog(@"%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        请求成功
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestSucesses:)]) {
                [self.delegate requestSucesses:dict];
            }
        } else {
            //windown 弹出提示框，暂无数据
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        请求失败
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestError:)]) {
            [self.delegate requestError:error];
        }
    }];
}


//批量上传

-(void)uploadFileWithUrlMore:(NSString *)url fileDataArray:(NSArray *)imageDataArray nameKey:(NSString *)nameKey fileName:(NSString *)fileName parameter:(NSMutableDictionary *)pareameter{
    AFHTTPSessionManager *manager = self.managers;
    
    [manager POST:url parameters:pareameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma Mark 判断网络状态
-(NetworkStatus)getNetworkStatus{
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWiFi) {
        NSLog(@"是wifi");
        return ReachableViaWiFi;
    }else if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWWAN){
        NSLog(@"是手机自带网络");
        return ReachableViaWWAN;
        
    }else{
        NSLog(@"网络有问题");
        return NotReachable;
    }
}

#pragma mark 两个上载方式-一个下载方式
//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
- (void)upLoda2{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

//第一种方法是通过工程中的文件进行上传
- (void)upLoad1{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        UIImage *iamge = [UIImage imageNamed:@"123.png"];
        NSData *data = UIImagePNGRepresentation(iamge);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
}
/**
 *  AFN3.0 下载
 */
- (void)downLoad{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@""];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
        
    }];
    
    //开始启动任务
    [task resume];
    
}



@end
