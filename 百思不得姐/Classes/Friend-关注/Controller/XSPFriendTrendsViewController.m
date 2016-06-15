//
//  XSPFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/28.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPFriendTrendsViewController.h"
#import "XSPrecommendViewController.h"
#import "XSPLoginViewController.h"

@interface XSPFriendTrendsViewController ()

@end

@implementation XSPFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    // Do any additional setup after loading the view.
}

- (void)setUI
{
    //设置导航栏的标题
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:@"friendsRecommentIcon" HighlightImage:@"friendsRecommentIcon-click" target:self action:@selector(tagClick)];
    //设置控制器的背景颜色
    self.view.backgroundColor = XSPBGColor(223, 223, 223);
}

- (void)tagClick
{
    XSPrecommendViewController *rvc = [[XSPrecommendViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}


//登入界面
- (IBAction)Login
{
    XSPLoginViewController *login = [[XSPLoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
