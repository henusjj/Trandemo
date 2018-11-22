//
//  AppDelegate.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/8.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AppService.h"
#import "AppDelegate+RootController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化windown
    [self initWithRootView];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
 
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
