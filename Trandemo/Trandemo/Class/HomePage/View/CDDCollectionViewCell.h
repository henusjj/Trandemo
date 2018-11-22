//
//  CDDCollectionViewCell.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/19.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDZCollectionViewItem.h"
NS_ASSUME_NONNULL_BEGIN
@protocol collectionCellDelegate <NSObject>

-(void)deleCollectionCell:(UICollectionViewCell *)cell;

@end
@interface CDDCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)id <collectionCellDelegate>delegate;

@property(nonatomic,strong)CDZCollectionViewItem *item;
@end

NS_ASSUME_NONNULL_END
