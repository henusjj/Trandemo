//
//  upLoadModel.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/27.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface upLoadModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *path;

@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)BOOL upload;

@end

NS_ASSUME_NONNULL_END
