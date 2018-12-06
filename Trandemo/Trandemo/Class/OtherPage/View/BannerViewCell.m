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
@end

@implementation BannerViewCell
-(UICollectionView *)bannerCollectionView{
    if (!_bannerCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing =0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(ScreenWidth, self.contentView.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bannerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.contentView.bounds.size.height) collectionViewLayout:layout];
        _bannerCollectionView.backgroundColor = [UIColor whiteColor];
        _bannerCollectionView.showsVerticalScrollIndicator = NO;
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.delegate=self;
        _bannerCollectionView.dataSource=self;
        [_bannerCollectionView registerClass:[bannerCell class] forCellWithReuseIdentifier:@"bannercell"];
    }
    return _bannerCollectionView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bannerCollectionView];
        [self.bannerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).offset(0);
        }];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arryItem.count;
//    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    bannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannercell" forIndexPath:indexPath];
    cell.dic = _arryItem[indexPath.row];
    return cell;
}

@end
