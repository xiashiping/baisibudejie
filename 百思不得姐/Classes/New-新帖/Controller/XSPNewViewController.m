//
//  XSPNewViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/28.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPNewViewController.h"

@interface XSPNewViewController ()

@end

@implementation XSPNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    // Do any additional setup after loading the view.
}

- (void)setUI
{
    //设置导航栏的标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:@"MainTagSubIcon" HighlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    //设置控制器的背景颜色
    self.view.backgroundColor = XSPBGColor(223, 223, 223);
}

- (void)tagClick
{
    XSPLogFunc;
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
