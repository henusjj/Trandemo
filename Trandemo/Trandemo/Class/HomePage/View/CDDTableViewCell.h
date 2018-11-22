//
//  CDDTableViewCell.h
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/19.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CDDdelegateCell <NSObject>

-(void)didChangeCell:(UITableViewCell *)cell;

@end
@interface CDDTableViewCell : UITableViewCell
@property(nonatomic,weak)id <CDDdelegateCell>delegate;
@end

NS_ASSUME_NONNULL_END
