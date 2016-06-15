//
//  XSPLoginViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/3.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPLoginViewController.h"

@interface XSPLoginViewController ()

//登录框距离左边边框的间距
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation XSPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//让当前控制器对应的状态栏是白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//
- (IBAction)returnBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)LoginRegisterBtn:(UIButton *)sender
{
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0)
    {
        //显示注册界面
        self.loginViewLeftMargin.constant = -self.view.width;//移一个view的宽度
        [sender setTitle:@"已有账号" forState:UIControlStateNormal];
    }
    else
    {
        //显示登入界面
        self.loginViewLeftMargin.constant = 0;
         [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];  //马上更新布局
    }];
}


//点击收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
