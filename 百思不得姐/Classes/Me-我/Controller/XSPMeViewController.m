//
//  XSPMeViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/28.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPMeViewController.h"

@interface XSPMeViewController ()

@end

@implementation XSPMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    // Do any additional setup after loading the view.
}

- (void)setUI
{
    
    
    //设置导航栏的标题
    self.navigationItem.title = @"我的";
    //设置导航栏右边的按钮
    UIBarButtonItem *setbtn = [UIBarButtonItem ItemWithImage:@"mine-setting-icon" HighlightImage:@"mine-setting-icon-click" target:self action:@selector(setBtnClicked)];
    
    UIBarButtonItem *moonbtn = [UIBarButtonItem ItemWithImage:@"mine-moon-icon-click" HighlightImage:@"mine-sun-icon" target:self action:@selector(moomBtnClicked)];
    
    self.navigationItem.rightBarButtonItems = @[setbtn,moonbtn];
    
    //设置控制器的背景颜色
    self.view.backgroundColor = XSPBGColor(223, 223, 223);
}

- (void)setBtnClicked
{
    XSPLogFunc;
}

- (void)moomBtnClicked
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
