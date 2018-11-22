//
//  PickerManager.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/20.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//定义一个枚举是相册还是拍照


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PickType)
{
    PickType_Camera = 0, // 拍照
    PickType_Photo, // 照片
};

//typedef <#returnType#>(^<#name#>)(<#arguments#>);

//定义一个bolock 回调图片数据
typedef void(^CallBackBlock)(NSDictionary *infoDict, BOOL isCancel);  // 回调

@interface PickerManager : NSObject

+(instancetype) shareInstance;
- (void)presentPicker:(PickType)pickerType target:(UIViewController *)vc callBackBlock:(CallBackBlock)callBackBlock;

@end

NS_ASSUME_NONNULL_END
