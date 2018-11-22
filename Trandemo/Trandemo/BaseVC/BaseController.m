//
//  BaseController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/8.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "BaseController.h"
#import "AllUrlrequest.h"
@interface BaseController ()

@end

@implementation BaseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
//    是否显示返回按钮
    self.isShowLiftBack = YES;
//  self.view的Y从导航栏下面开始计算
    self.edgesForExtendedLayout =UIRectEdgeNone;
    

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

/**
 是否显示返回按钮

 @param isShowLiftBack isShowLiftBack description
 */
- (void)setIsShowLiftBack:(BOOL)isShowLiftBack{
    _isShowLiftBack = isShowLiftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLiftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked)];
        self.navigationItem.leftBarButtonItem = left;
        self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];

    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}
- (void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark lazy
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        if (@available(iOS 11.0, *)) {
            self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.scrollsToTop = YES;
        _tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        
//        头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRerefsh)];
        header.automaticallyChangeAlpha =YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableview.mj_header = header;
        
//        底部刷新
        _tableview.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRerefsh)];
        _tableview.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        
    
        
    }
    return _tableview;
}

-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        if (@available(iOS 11.0, *)) {
            self.collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _collectionview.scrollsToTop = YES;
        //        头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRerefsh)];
        header.automaticallyChangeAlpha =YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _collectionview.mj_header = header;
        
        //        底部刷新
        _collectionview.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRerefsh)];
        _collectionview.mj_footer.ignoredScrollViewContentInsetBottom = 30;
        
    }
    return _collectionview;
}

-(void)headerRerefsh{
    [self.tableview.mj_header endRefreshing];
    [self.collectionview.mj_header endRefreshing];
}

-(void)footerRerefsh{
    [self.tableview.mj_footer endRefreshing];
    [self.collectionview.mj_footer endRefreshing];
}
@end
