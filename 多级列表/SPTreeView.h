//
//  SPTreeView.h
//  多级列表
//
//  Created by BiliSu on 15/7/1.
//  Copyright (c) 2015年 BiliSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTreeView : UIView

@property (nonatomic, strong) UITableView *containerView; //容器视图
@property (nonatomic, assign) NSInteger rootViewHeight;     //根节点高度
@property (nonatomic, assign) NSInteger stairViewHeight;    //一级节点高度
@property (nonatomic, strong) UIView *(^rootView)(NSInteger index, id obj);  //根节点视图
@property (nonatomic, strong) UIView *(^stairView)(NSInteger index, CGRect bounds); //一级视图
@property (nonatomic, strong) void (^stairPressed)(NSInteger index, id obj); //一级节点点击事件

- (instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray *)dataSource;
@end
