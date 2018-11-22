//
//  CDDCollectionViewCell.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/19.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "CDDCollectionViewCell.h"

@interface CDDCollectionViewCell ()
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UIButton *delebt;

@end
@implementation CDDCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.img = [[UIImageView alloc]init];
    self.img.image=[UIImage imageNamed:@"发单-添加"];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.delebt =[[UIButton alloc]init];
    [self.delebt setImage:[UIImage imageNamed:@"发单-关闭"] forState:UIControlStateNormal];
    self.delebt.clipsToBounds = YES;
    self.delebt.layer.cornerRadius= 5;
    [self.delebt addTarget:self action:@selector(deleclick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.delebt];
    [self.delebt mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.contentView.mas_right).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.width.equalTo(@50);
    }];
    
}
-(void)deleclick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleCollectionCell:)]) {
        [self.delegate deleCollectionCell:self];
    }
}

-(void)setItem:(CDZCollectionViewItem *)item{
    self.img.image=item.image;
    self.delebt.hidden = item.delBtnHidden;
}
@end
