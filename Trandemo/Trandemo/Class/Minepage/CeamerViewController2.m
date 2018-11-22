//
//  CeamerViewController2.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/20.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "CeamerViewController2.h"
#import "PickerManager.h"
@interface CeamerViewController2 ()<UIActionSheetDelegate>
@property(nonatomic,strong)UIButton *imgBtn;

@end

@implementation CeamerViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"相机相册封装展示";
    
    UIButton *btn = [[UIButton alloc]init];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius =200/2;
    btn.layer.borderColor=[UIColor redColor].CGColor;
    btn.layer.borderWidth = 0.3;
    [btn addTarget:self action:@selector(changImg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.imgBtn = btn;
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.width.equalTo(@200);
    }];
}

-(void)changImg{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    WeakSelf(self);
    PickerManager *manager = [PickerManager shareInstance];
    
    [manager presentPicker:buttonIndex
                        target:self
                 callBackBlock:^(NSDictionary *infoDict, BOOL isCancel) {
                     
                    UIImage *image = [infoDict valueForKey:UIImagePickerControllerOriginalImage];
                     [weakself.imgBtn setImage:image forState:UIControlStateNormal];
                 }];
}

@end
