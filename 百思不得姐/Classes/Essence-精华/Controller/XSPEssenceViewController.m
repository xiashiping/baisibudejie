//
//  XSPEssenceViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/28.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPEssenceViewController.h"
#import "XSPRecommendTableViewController.h"
#import "XSPTopicViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface XSPEssenceViewController ()<UIScrollViewDelegate>
//标签栏底部的红色指示器
@property (nonatomic, weak)UIView *indicatyorView;
//当前选中的按钮
@property (nonatomic, weak)UIButton *selectedButton;
//底部的所有标签
@property (nonatomic, weak)UIView *titlesView;
//底部的所有内容
@property (nonatomic, weak)UIScrollView *contentView;

@end

@implementation XSPEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    
    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部的标签栏
    [self setupTiltesView];
    
    //底部的scrollview
    [self setUpContentview];
    
   
    
    // Do any additional setup after loading the view.
}

//设置顶部的标签栏
- (void)setupTiltesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.width = self.view.width;
    titlesView.height = XSPtitlesViewH;
    titlesView.y = XSPtitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatyorView = indicatorView;

    
    //内部的子标签

    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < self.childViewControllers.count; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
//        [button layoutIfNeeded];  //强制布局(强制更新子空件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(TitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0)
        {
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit]; //让按钮内部的label根据文字的内容来计算尺寸
            self.indicatyorView.width = button.titleLabel.width;
            self.indicatyorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

- (void)TitleClicked:(UIButton *)button
{
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatyorView.width = button.titleLabel.width;
        self.indicatyorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}


//底部的scrollview
- (void)setUpContentview
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


//初始化子控制器
- (void)setupChildVces
{
    XSPTopicViewController *All = [[XSPTopicViewController alloc] init];
    All.title = @"全部";
    All.type = XSPtopicTypeAll;
    [self addChildViewController:All];
    
    XSPTopicViewController *Video = [[XSPTopicViewController alloc] init];
    Video.title = @"视频";
    Video.type = XSPtopicTypeVideo;
    [self addChildViewController:Video];
    
    XSPTopicViewController *Voice = [[XSPTopicViewController alloc] init];
    Voice.title = @"声音";
    Voice.type = XSPtopicTypeVoice;
    [self addChildViewController:Voice];
    
    XSPTopicViewController *Picture = [[XSPTopicViewController alloc] init];
    Picture.title = @"图片";
    Picture.type = XSPtopicTypePicture;
    [self addChildViewController:Picture];
    
    XSPTopicViewController *Word = [[XSPTopicViewController alloc] init];
    Word.title = @"段子";
    Word.type = XSPtopicTypeWord;
    [self addChildViewController:Word];
}


//设置导航栏
- (void)setupNav
{
    //设置导航栏的标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
 
    //设置导航栏左边的按钮
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    //currentBackgroundImage：按钮上显示当前的背景图片
    leftbtn.size = leftbtn.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:@"MainTagSubIcon" HighlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    //设置控制器的背景颜色
    self.view.backgroundColor = XSPBGColor(223, 223, 223);
    
    
}

- (void)tagClick
{
    //推荐标签
    XSPRecommendTableViewController *recommend = [[XSPRecommendTableViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}


#pragma mark - UIScrollViewDelegate
//当scrollview的动画结束后调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    //添加自控制器的view
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;  //修改控制器view的Y值为0（默认是20）
    //设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];

}

//停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self TitleClicked:self.titlesView.subviews[index]];
   
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
