//
//  ViewController.m
//  多级列表
//
//  Created by BiliSu on 15/7/1.
//  Copyright (c) 2015年 BiliSu. All rights reserved.
//

#import "ViewController.h"
#import "SPTreeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置数据源
    SPTreeView *tree = [[SPTreeView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 300) DataSource:@[@[@"1",@"2"],@[@"3"],@[@"4",@"5",@"6"]]];
    tree.rootView = ^(NSInteger index, id obj){
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        vi.backgroundColor = [UIColor colorWithRed:0.3 green:0.2 * index blue:0.8 - 0.08 * index alpha:1];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        title.text = @"啦啦";
        [vi addSubview:title];
        return vi;
    };
    [self.view addSubview:tree];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 40;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 40;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    return cell;
//    
//}

@end
