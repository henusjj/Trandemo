//
//  CDDTableViewCell.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/19.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "CDDTableViewCell.h"
#import "CDDCollectionViewCell.h"
#import "CDZCollectionViewItem.h"
@interface CDDTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,collectionCellDelegate>

@property(nonatomic,strong)UICollectionView *collectionview;
@property (strong, nonatomic) NSMutableArray<CDZCollectionViewItem *>*itemsArray;
@end

@implementation CDDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    CDZCollectionViewItem *item = [CDZCollectionViewItem new];
    item.delBtnHidden = YES;
    _itemsArray = [NSMutableArray arrayWithObject:item];

    
    [self.contentView addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.with.bottom.with.left.with.right.mas_equalTo(self.contentView);
//        低优先级
        make.height.mas_equalTo(@100).priorityLow();

    }];
    
}
-(void)deleCollectionCell:(UICollectionViewCell *)cell{
    NSIndexPath *indexpath = [self.collectionview indexPathForCell:cell];
    [self.itemsArray removeObjectAtIndex:indexpath.row];
    [self reloadCell];
}

-(void)reloadCell{
    [self.collectionview reloadData];
    [self.collectionview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.collectionview.collectionViewLayout.collectionViewContentSize.height)).priorityHigh();
        
    }];
    [self.delegate didChangeCell:self];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //载入数据，如图片等
    CDZCollectionViewItem *item = [CDZCollectionViewItem new];
    item.image = [UIImage imageNamed:@"example"];
    if ((indexPath.row == self.itemsArray.count - 1)) {
        [self.itemsArray insertObject:item atIndex:self.itemsArray.count - 1];
    }
    else{
        self.itemsArray[indexPath.row] = item;
    }
    [self reloadCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CDDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    cell.delegate=self;
    cell.item = self.itemsArray[indexPath.row];
    return cell;
}



-(UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout.alloc init];
        layout.itemSize = CGSizeMake(125, 100);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionview = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionview.backgroundColor = [UIColor clearColor];
//        [_collectionView registerNib:[UINib nibWithNibName:@"CDZCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
//        注册cell
        [_collectionview registerClass:[CDDCollectionViewCell class] forCellWithReuseIdentifier:@"collectioncell"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
    }
    return _collectionview;
}





//xib
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
