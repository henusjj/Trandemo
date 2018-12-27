//
//  TableViewCell.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/12/10.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "TableViewCell.h"
#import "CDDCollectionViewCell.h"
#import "CDZCollectionViewItem.h"
@interface TableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionview;
@property(nonatomic,strong)NSArray *itemsArray;
@property(nonatomic,assign)int bum;

@end
@implementation TableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    self.itemsArray =[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
    [self.contentView addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.contentView);
        //        低优先级
        make.height.equalTo(@200);
        
    }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //载入数据，如图片等
    CDZCollectionViewItem *item = [CDZCollectionViewItem new];
    item.image = [UIImage imageNamed:@"example"];
//    if ((indexPath.row == self.itemsArray.count - 1)) {
//        [self.itemsArray insertObject:item atIndex:self.itemsArray.count - 1];
//    }
//    else{
//        self.itemsArray[indexPath.row] = item;
//    }
//    [self reloadCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _bum;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CDDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
//    cell.delegate=self;
//    cell.item = self.itemsArray[indexPath.row];
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
- (void)setArry:(NSArray *)arry{
    _bum = 6;
    [self.collectionview reloadData];
    [self.collectionview mas_updateConstraints:^(MASConstraintMaker *make) {
 make.height.equalTo(@(self.collectionview.collectionViewLayout.collectionViewContentSize.height)).priorityHigh();
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        
    }];
}
-(void)reloadCell{
    [self.collectionview reloadData];
    [self.collectionview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.collectionview.collectionViewLayout.collectionViewContentSize.height));
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
