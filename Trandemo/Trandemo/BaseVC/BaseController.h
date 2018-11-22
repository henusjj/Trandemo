//
//  BaseController.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/8.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseController : UIViewController

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UICollectionView *collectionview;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;
@end

NS_ASSUME_NONNULL_END
