//
//  BannerViewCell.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/30.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "BannerViewCell.h"
#import "bannerCell.h"

@interface BannerViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *bannerCollectionView;
@property(nonatomic,strong)UIPageControl *pageView;

@end

@implementation BannerViewCell
-(UICollectionView *)bannerCollectionView{
    if (!_bannerCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing =0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(ScreenWidth, self.contentView.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bannerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.contentView.bounds.size.height) collectionViewLayout:layout];
        _bannerCollectionView.backgroundColor = [UIColor whiteColor];
        _bannerCollectionView.showsHorizontalScrollIndicator = NO;
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.delegate=self;
        _bannerCollectionView.dataSource=self;
        [_bannerCollectionView registerClass:[bannerCell class] forCellWithReuseIdentifier:@"bannercell"];
    }
    return _bannerCollectionView;
}

-(UIPageControl *)pageView{
    if (!_pageView) {
        _pageView = [[UIPageControl alloc]init];
        _pageView.pageIndicatorTintColor = [UIColor blackColor];
        _pageView.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageView.backgroundColor = [UIColor redColor];
    }
    return _pageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bannerCollectionView];
        [self.bannerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).offset(0);
        }];
        [self.contentView addSubview:self.pageView];
        [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bannerCollectionView.mas_bottom).offset(0);
            make.height.equalTo(@20);
            make.left.right.equalTo(self.bannerCollectionView).mas_offset(0);
        }];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arryItem.count*2;
//    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    bannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannercell" forIndexPath:indexPath];
    cell.dic = _arryItem[indexPath.row];
    return cell;
}

-(void)setArryItem:(NSArray *)arryItem{
    _arryItem = arryItem;
    [self.bannerCollectionView reloadData];
    self.pageView.hidden = !_arryItem.count;
    self.pageView.numberOfPages = _arryItem.count;
    self.pageView.currentPage =0;
}


@end
