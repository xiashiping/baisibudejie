//
//  XSPTabBarController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/28.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPTabBarController.h"
#import "XSPEssenceViewController.h"
#import "XSPNewViewController.h"
#import "XSPFriendTrendsViewController.h"
#import "XSPMeViewController.h"
#import "XSPTabBar.h"
#import "XSPNavigationController.h"

@interface XSPTabBarController ()



@end

@implementation XSPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    // Do any additional setup after loading the view.
}

//当第一次使用这个类的时候会调用一次
+ (void)initialize
{
    //通过appearance统一设置所有UITabBarItem的文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *Selectattrs = [NSMutableDictionary dictionary];
    Selectattrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    Selectattrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:Selectattrs forState:UIControlStateSelected];
}

- (void)setUI
{
   
    
    
    [self setInitVC:[[XSPEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setInitVC:[[XSPNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setInitVC:[[XSPFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setInitVC:[[XSPMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换TabBar
    [self setValue:[[XSPTabBar alloc] init] forKeyPath:@"tabBar"];
    NSLog(@"%@",self.tabBar);
}

//初始化子控制器
- (void)setInitVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    XSPNavigationController *nc = [[XSPNavigationController alloc] initWithRootViewController:vc];
   
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault]; 全部的导航栏的背景
    [self addChildViewController:nc];
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
