//
//  ViewController.m
//  WechatMenuView
//
//  Created by yh on 15/11/25.
//  Copyright © 2015年 yh. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"
@interface ViewController ()<MenuViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(50, 50, 30, 30);
    [btn addTarget:self action:@selector(btnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnDown
{
    MenuView *menu = [[MenuView alloc] initWithTitleArray:@[@"附近学校", @"联赛流程", @"其他联赛", @"校内群聊", @"邀请好友"] imageArray:@[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png", @"item_share.png"] origin:CGPointMake(50, 80) width:125 rowHeight:22 Direct:kLeftTriangle];
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)MenuItemDidSelected:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}

@end
