//
//  MainTabBarController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/13.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "MainTabBarController.h"
//view Controllers
#import "HomeViewController.h"
#import "MineViewController.h"
#import "OtherViewController.h"
#import "BaseNavController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

-(CYLTabBarController *)mainViewController{
    if (!_mainViewController) {
        UIEdgeInsets imagesInsets = UIEdgeInsetsZero;
        UIOffset titlePosition =UIOffsetZero;
        _mainViewController = [[CYLTabBarController alloc]initWithViewControllers:[self arryViewcontrollers] tabBarItemsAttributes:[self arrayAttributesItem] imageInsets:imagesInsets titlePositionAdjustment:titlePosition];
        [_mainViewController setTintColor:[UIColor colorWithHexString:@"00AE68"]];
    }
    return _mainViewController;
}

-(NSArray *)arryViewcontrollers{
    HomeViewController *homevc=[[HomeViewController alloc]init];
    UIViewController *homeNav = [[BaseNavController alloc]initWithRootViewController:homevc];
    
    MineViewController *minevc=[[MineViewController alloc]init];
    UIViewController *mineNav = [[BaseNavController alloc]initWithRootViewController:minevc];
    
    OtherViewController *othervc=[[OtherViewController alloc]init];
    UIViewController *otherNav=[[BaseNavController alloc]initWithRootViewController:othervc];
    
    NSArray *arryviews=@[homeNav,otherNav,mineNav];
    return arryviews;
}

- (NSArray *)arrayAttributesItem{
    NSDictionary *hometar = @{
                              CYLTabBarItemTitle:@"home",
                              CYLTabBarItemImage:@"icon_tabbar_onsite",
                              CYLTabBarItemSelectedImage:@"icon_tabbar_onsite_selected",
                              };
    NSDictionary *other = @{
                              CYLTabBarItemTitle:@"other",
                              CYLTabBarItemImage:@"icon_tabbar_merchant_normal",
                              CYLTabBarItemSelectedImage:@"icon_tabbar_merchant_selected",
                              };
    NSDictionary *mine = @{
                              CYLTabBarItemTitle:@"mine",
                              CYLTabBarItemImage:@"icon_tabbar_mine",
                              CYLTabBarItemSelectedImage:@"icon_tabbar_mine_selected",
                              };
    NSArray *arry = @[hometar,other,mine];
    return arry;
}

@end
