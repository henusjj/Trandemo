//
//  bannerCell.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/12/5.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "bannerCell.h"

@interface bannerCell ()
@property(nonatomic,strong)UIPageControl *pageView;
@property(nonatomic,strong)UIImageView *imgview;
@end

@implementation bannerCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgview =[[UIImageView alloc]init];
        self.imgview.contentMode=UIViewContentModeScaleAspectFit;
        self.imgview.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.imgview];
        [self.imgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).offset(0);
            
        }];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic{
    [self.imgview sd_setImageWithURL:[NSURL URLWithString:dic[@"banner_img"]] placeholderImage:[UIImage imageNamed:@"发单-添加"]];
}
@end
