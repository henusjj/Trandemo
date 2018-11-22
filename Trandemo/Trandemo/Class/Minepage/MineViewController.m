//
//  MineViewController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/13.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "MineViewController.h"
#import "CeamerViewController.h"
#import "CeamerViewController2.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *arry;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"mine";
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_TabBar-Height_NavBar);
    [self.view addSubview:self.tableview];
    self.arry=[[NSMutableArray alloc]init];
    [self.arry addObject:@"相机相册"];
    [self.arry addObject:@"相机相册2"];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid =@"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.arry[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        CeamerViewController *vc = [[CeamerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        CeamerViewController2 *vc = [[CeamerViewController2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)headerRerefsh{
    [self.tableview.mj_header endRefreshing];
}

-(void)footerRerefsh{
    [self.tableview.mj_footer endRefreshing];
}
@end