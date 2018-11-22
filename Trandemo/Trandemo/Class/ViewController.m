//
//  ViewController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/9.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<responseDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self loadData];
    
//    plist文件写入
    [self inputPlist];
}

-(void)loadData{
    
    NetRequest.delegate =self;
    [NetRequest LoginRequest];
}

-(void)inputPlist{
    NSDictionary *addDic = @{@"name" : @"dev",
                            @"age" : @"24"};
    //将字典保存到document文件->获取appdocument路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //要创建的plist文件名 -> 路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"cityPlist.plist"];
    //将字典写入文件
    [addDic writeToFile:filePath atomically:YES];
    //读取文件
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    DLog(@"%@",plistDic);
    
}



@end
