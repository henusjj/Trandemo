//
//  HomeViewController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/13.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "CDDTableViewCell.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,CDDdelegateCell>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"home";
    
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_TabBar-Height_NavBar);
    self.tableview.estimatedRowHeight =100;
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    
}

//下拉刷新
-(void)headerRerefsh{
    
}
//上拉加载
-(void)footerRerefsh{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


/**
 tableview中的cell高度动态，cell中嵌套collectionview也是动态，此时cell不可fu 用

 @param tableView 1
 @param indexPath 用作cell的表示，表示各个cell，不会重复
 @return 1
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellid = [NSString stringWithFormat:@"cellif%ld",indexPath.row];
    CDDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[CDDTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
//    cell.textLabel.text = @"2";
    return cell;
}

-(void)didChangeCell:(UITableViewCell *)cell{
    [self.tableview reloadData];
    NSIndexPath *indepath = [self.tableview indexPathForCell:cell];
    [self.tableview scrollToRowAtIndexPath:indepath atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

@end
