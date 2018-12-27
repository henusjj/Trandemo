//
//  CaCheViewController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/29.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "CaCheViewController.h"
#import "BannerViewCell.h"
@interface CaCheViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,responseDelegate>
@property(nonatomic,strong)NSMutableDictionary *responseDate;
@end

@implementation CaCheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    UICollectionViewFlowLayout *flayLaout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionview.collectionViewLayout = flayLaout;
    flayLaout.minimumLineSpacing=1;
    flayLaout.minimumInteritemSpacing = 10;
    flayLaout.itemSize = CGSizeMake(ScreenWidth, 235);
//    flayLaout.estimatedItemSize = CGSizeMake(100, 100);//预估cell高度，使cell自适应
    self.collectionview.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_StatusTabBar-Height_NavBar);
    
//    轮播cell
    [self.collectionview registerClass:[BannerViewCell class] forCellWithReuseIdentifier:@"banner"];
    
//    广告cell
    
//     header
    
//    商品cell
    
    [self.view addSubview:self.collectionview];
//    请求数据
    [self getDate];
}
-(void)getDate{
    NetRequest.delegate=self;
    [NetRequest IndexDateRequest:@"https://ywdev.youngworld.com.cn/ywapi/server.php/sy_back"];
}

#pragma mark 数据请求成功
-(void)requestSucesses:(NSMutableDictionary *)responseData{
    self.responseDate =[[NSMutableDictionary alloc]init];
    self.responseDate = responseData;
    if ([self.responseDate[@"code"] isEqualToString:@"10000"]) {
//        请求数据成功
        [self.collectionview reloadData];
    }
}

#pragma mark 数据请求失败
-(void)requestError:(NSError *)error{
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"banner" forIndexPath:indexPath];
    NSDictionary *dic = self.responseDate[@"data"];
    cell.arryItem =dic[@"bannner"];
    return cell;
}

@end
