//
//  CeamerViewController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/20.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "CeamerViewController.h"

@interface CeamerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePicker;
@property(nonatomic,strong)UIButton *imgBtn;
@end

@implementation CeamerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"相机相册";
    
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
//    创建UIImagePickerController对象，并设置代理和可编辑
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate=self;
    self.imagePicker.allowsEditing=YES;
    
    
}

-(void)changImg{
    
//    系统弹出框
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    WeakSelf(self);
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakself.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        weakself.imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        // 将mediaTypes设为所有支持的多媒体类型
//        weakself.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        // 设置拍摄照片/视频
        weakself.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        跳转到impaker控制的的相机
        [weakself presentViewController:weakself.imagePicker animated:YES completion:nil];
    }];
    
    //相册选项
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //选择相册时，设置UIImagePickerController对象相关属性
        weakself.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [weakself presentViewController:weakself.imagePicker animated:YES completion:nil];
    }];
    
    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //添加各个按钮事件
    [alter addAction:camera];
    [alter addAction:photo];
    [alter addAction:cancel];
    
    
    
    //弹出sheet提示框
    [self presentViewController:alter animated:YES completion:nil];
}


#pragma mark - imagePickerController delegate
// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    /*
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     */
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片(枚举)
    
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [self.imgBtn setImage:image forState:UIControlStateNormal];
    
}

#pragma mark - 当用户取消时，调用该方法

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
