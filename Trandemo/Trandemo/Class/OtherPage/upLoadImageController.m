//
//  upLoadImageController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/27.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "upLoadImageController.h"
#import "PickerManager.h"
#import "upLoadModel.h"
#define PhotoCachePath   [NSTemporaryDirectory() stringByAppendingPathComponent:@"photoCache"]


@interface upLoadImageController ()<responseDelegate>
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)NSMutableArray *upLoadImage;

@end

@implementation upLoadImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传图片";
    self.upLoadImage = [NSMutableArray array];

    self.imageView = [[UIImageView alloc]init];
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 100;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
    self.imageView.layer.borderWidth = 0.2;
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.width.mas_equalTo(@200);
    }];
    
//    添加手势
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chosImage)];
//    点击几次响应事件，默认是1
    click.numberOfTapsRequired = 1;
//    需要几个手指，默认是1
    click.numberOfTouchesRequired =1;
    [self.imageView addGestureRecognizer:click];
}

-(void)chosImage{
//    弹出提示框
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    PickerManager *manager = [PickerManager shareInstance];
    WeakSelf(self);
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [manager presentPicker:1 target:self callBackBlock:^(NSDictionary * _Nonnull infoDict, BOOL isCancel) {
            UIImage *image = [infoDict valueForKey:UIImagePickerControllerOriginalImage];
            weakself.imageView.image=image;
//            将照片存入缓存目录
            [weakself saveImage:image toPath:PhotoCachePath];
            
        }];
        
    }];
    
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [manager presentPicker:0 target:self callBackBlock:^(NSDictionary * _Nonnull infoDict, BOOL isCancel) {
            UIImage *image = [infoDict valueForKey:UIImagePickerControllerOriginalImage];
            weakself.imageView.image=image;
//            获取图片名称
            NSString *name=[weakself getImageNameBaseCurrentTime];
//            将照片存入缓存目录
            [weakself saveImage:image toPath:[PhotoCachePath stringByAppendingString:name]];
            
            upLoadModel *model = [[upLoadModel alloc]init];
            model.name=name;
            model.type=@"image";
            model.path=[PhotoCachePath stringByAppendingString:name];
            model.upload=NO;
            [weakself.upLoadImage addObject:model];
//            上传
            [weakself upLoadImageBaseMode:model];
            

        }];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alter addAction:actionOne];
    [alter addAction:actionTwo];
    [alter addAction:cancle];
    
    [self presentViewController:alter animated:YES completion:nil];
}

#pragma mark --以当前时间整合图片名称
-(NSString *)getImageNameBaseCurrentTime{
    NSDateFormatter *dateTime = [[NSDateFormatter alloc]init];
    [dateTime setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *name = [dateTime stringFromDate:[NSDate date]];
    return [name stringByAppendingString:@".JPG"];//ii.jpg
}

#pragma mark ---将图片存到缓存中
-(void)saveImage:(UIImage *)image toPath:(NSString *)path{
    NSData *data =UIImageJPEGRepresentation(image, 1);//将图片压缩成比例为1的二进制流
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path]) {
        NSLog(@"存在文件夹路径");
    }else{
//        不存在文件夹路径，创建
        [fileManage createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
//    写入
    [data writeToFile:path atomically:YES];
}
#pragma mark --- 上传图片
-(void)upLoadImageBaseMode:(upLoadModel *)mode{
    NetRequest.delegate=self;
    [NetRequest upLoadImageRequestWithMode:mode andWithURL:@""];
}

-(void)requestSucesses:(id)responseData{
//    请求成功
}

-(void)requestError:(NSError *)error{
//    请求失败
    
}


@end
