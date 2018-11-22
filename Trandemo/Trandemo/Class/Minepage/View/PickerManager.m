//
//  PickerManager.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/20.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "PickerManager.h"

@interface PickerManager ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController     *_imgPickC;
    UIViewController            *_vc;
    CallBackBlock                _callBackBlock;

}

@end

@implementation PickerManager
+ (instancetype)shareInstance
{
    static dispatch_once_t once;
    static PickerManager *pickManager;
    dispatch_once(&once, ^{
        pickManager = [[PickerManager alloc] init];
    });
    
    return pickManager;
}
- (instancetype)init
{
    if([super init]){
        if(!_imgPickC){
            _imgPickC = [[UIImagePickerController alloc] init];  // 初始化 _imgPickC
        }
    }
    
    return self;
}

- (void)presentPicker:(PickType)pickerType target:(UIViewController *)vc callBackBlock:(CallBackBlock)callBackBlock
{
    _vc = vc;
    _callBackBlock = callBackBlock;
    if(pickerType == PickType_Camera){
        // 拍照
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            _imgPickC.delegate = self;
            _imgPickC.sourceType = UIImagePickerControllerSourceTypeCamera;
            _imgPickC.allowsEditing = YES;
            _imgPickC.showsCameraControls = YES;
            UIView *view = [[UIView  alloc] init];
            view.backgroundColor = [UIColor grayColor];
            _imgPickC.cameraOverlayView = view;
            [_vc presentViewController:_imgPickC animated:YES completion:nil];
        }else{
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"相机不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alertV show];
        }
    }
    
    else if(pickerType == PickType_Photo){
        // 相册
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            _imgPickC.delegate = self;
            _imgPickC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            _imgPickC.allowsEditing = YES;
            [_vc presentViewController:_imgPickC animated:YES completion:nil];
        }else{
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"相册不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alertV show];
        }
        
    }
}



#pragma mark ---- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [_vc dismissViewControllerAnimated:YES completion:^{
        _callBackBlock(info, NO); // block回调
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_vc dismissViewControllerAnimated:YES completion:^{
        _callBackBlock(nil, YES); // block回调
    }];
}


@end
