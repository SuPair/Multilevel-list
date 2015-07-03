//
//  SPTreeView.m
//  多级列表
//
//  Created by BiliSu on 15/7/1.
//  Copyright (c) 2015年 BiliSu. All rights reserved.
//

#import "SPTreeView.h"

@interface SPTreeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *treeSource; //数据源
@property (nonatomic, strong) NSMutableDictionary *tempStairSource; //一级数据源缓存
@property (nonatomic, strong) NSMutableDictionary *tempSecondSource; //二级数据源缓存
@end

@implementation SPTreeView

- (instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray *)dataSource{

    self = [super initWithFrame:frame];
    if (self) {
        //设置数据源
        self.treeSource = [dataSource mutableCopy];
        //添加视图
        self.containerView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        self.containerView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.containerView.delegate = self;
        self.containerView.dataSource = self;
        [self addSubview:self.containerView];
    }
    return self;
}

#pragma mark --------------------- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _treeSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *stairSource =  _tempStairSource[[NSString stringWithFormat:@"%ld",(long)section]];
    return _tempStairSource == nil ? 0 :stairSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.rootViewHeight > 0 ? self.rootViewHeight : 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.stairViewHeight > 0 ? self.stairViewHeight : 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000000000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = self.rootView != nil ? self.rootView(section,self.treeSource[section]) : [[UIView alloc] init];
    headerView.tag = 2536475 + section;
    //添加点击事件
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapClick:)];
    [headerView addGestureRecognizer:headerTap];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"treeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"treeCell"];
    }
    //设置一级列表视图
    if (self.stairView != nil) {
        UIView *contextView = self.stairView(indexPath.row, cell.bounds);
        [cell addSubview:contextView];
    }
    return cell;
}

#pragma mark ------------------ UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSInteger index = indexPath.row;
    if (self.stairPressed) {
        self.stairPressed(index, self.treeSource[indexPath.section][indexPath.row]);
    }
}

#pragma mark ------------------ UITapGestureRecognizer

- (void)headerTapClick:(UITapGestureRecognizer *)sender{
    //用tag传值判断
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIView *view = (UIView *)tap.view;
    NSInteger index = view.tag - 2536475;
    NSLog(@"得到的sectio %ld",(long)index);
    //设置一级节点的数据并刷新section
    if (_treeSource[index] != nil) {
        NSArray *stairSource = _treeSource[index];
        if (_tempStairSource == nil) {
            _tempStairSource = [NSMutableDictionary dictionary];
        }
        NSString *key = [NSString stringWithFormat:@"%ld",(long)index];
        if ([[_tempStairSource allKeys] containsObject:key]) {
            [_tempStairSource removeObjectForKey:key];
        }else{
            [_tempStairSource setObject:stairSource forKey:key];
        }
        //刷新当前section
        [_containerView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
