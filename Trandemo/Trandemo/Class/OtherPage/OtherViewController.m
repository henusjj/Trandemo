//
//  OtherViewController.m
//  Trandemo
//
//  Created by GuoYanjun on 2018/11/13.
//  Copyright © 2018年 shiyujin. All rights reserved.
//

#import "OtherViewController.h"
#import "upLoadImageController.h"
#import "CaCheViewController.h"

@interface OtherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *arry;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"other";
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_TabBar-Height_NavBar);
    [self.view addSubview:self.tableview];
    self.arry=[[NSMutableArray alloc]init];
    
    [self.arry addObject:@"上传图片"];
    [self.arry addObject:@"数据缓存"];
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
        upLoadImageController *vc = [[upLoadImageController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.row == 1){
        CaCheViewController *vc = [[CaCheViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)headerRerefsh{
    [self.tableview.mj_header endRefreshing];
}

-(void)footerRerefsh{
    [self.tableview.mj_footer endRefreshing];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
