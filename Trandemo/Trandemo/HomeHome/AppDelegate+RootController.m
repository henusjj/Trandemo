//
//  AppDelegate+RootController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/8.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "AppDelegate+RootController.h"

@implementation AppDelegate (RootController)
-(void)initWithRootView{
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    MainTabBarController *vc =[[MainTabBarController alloc]init];
    CYLTabBarController *tabVc = vc.mainViewController;
    self.window.rootViewController=tabVc;
    [self.window makeKeyAndVisible];
}
@end
