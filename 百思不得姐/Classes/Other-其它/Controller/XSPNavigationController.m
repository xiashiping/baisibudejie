//
//  XSPNavigationController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/29.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPNavigationController.h"


@interface XSPNavigationController ()

@end

@implementation XSPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //改变导航栏文字的颜色
//    self.navigationBar.tintColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    
    //设置导航栏的背景
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

//当第一次使用这个类的时候会调用一次
+ (void)initialize
{
    //设置导航栏的背景
    UINavigationBar *Bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [Bar setBackgroundImage:[UIImage imageNamed: @"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

//    XSPLogFunc;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    if (self.childViewControllers.count > 0)//如果push进来的不是第一个控制器就执行
    {
        UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbtn setTitle:@"返回" forState:UIControlStateNormal];
        [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [leftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftbtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        leftbtn.size = CGSizeMake(70, 30);
        //让按钮内部水平向左对齐
        leftbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //超出按钮向左移10
        leftbtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [leftbtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
        //隐藏push之后的TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
     [super pushViewController:viewController animated:animated];
}

- (void)leftBtnClicked
{
    [self popViewControllerAnimated:YES];
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
