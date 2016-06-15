//
//  XSPTopicViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/7.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPTopicViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIImageView+WebCache.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "XSPTopic.h"
#import "XSPTopicCell.h"

@interface XSPTopicViewController ()
//帖子数据
@property (nonatomic, strong)NSMutableArray *topics;
//当前页码
@property (nonatomic, assign)NSInteger page;
//当加载下一页数据时需要这个参数
@property (nonatomic, copy)NSString *maxtime;
//上一次的请求参数
@property (nonatomic, strong)NSDictionary *params;
@end

@implementation XSPTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics)
    {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //初始化表格
    [self setUpTableview];
    
    //添加刷新控件
    [self setUpRefresh];
}

//初始化表格
static NSString *const XSPTopicCellID = @"topic";
- (void)setUpTableview
{
    //设置内边距
    CGFloat buttom = self.tabBarController.tabBar.height;
    CGFloat top = XSPtitlesViewY + XSPtitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, buttom, 0);
    //滚动条的内边距(scrollIndicatorInsets)
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XSPTopicCell class]) bundle:nil] forCellReuseIdentifier:XSPTopicCellID];
}




- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //automaticallyChangeAlpha:自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //一进来就进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark - 数据处理
//加载新的帖子数据
- (void)loadNewTopics
{
    //结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        
        //        XSPLog(@"%@",responseObject);
        //        [responseObject writeToFile:@"/Users/xiashiping/DeskTop/duanzi.plist" atomically:YES];
        //存储maxtime(要知道下一页有什么内容，先存储上一页的内容)
        
        if (self.params != params)
        {
            return ;
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组转模型数组
        self.topics = [XSPTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //清空页码(下拉刷新成功后,页码会初始化为0)
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params)
        {
            return ;
        }
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

//加载更多帖子数据
- (void)loadMoreTopics
{
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        
        //        XSPLog(@"%@",responseObject);
        //        [responseObject writeToFile:@"/Users/xiashiping/DeskTop/duanzi.plist" atomically:YES];
        
        if (self.params != params)
        {
            return ;
        }
        
        //存储maxtime(要知道下一页有什么内容，先存储上一页的内容)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组转模型数组
        NSArray *newTopics = [XSPTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params)
        {
            return ;
        }
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    XSPLog(@"%lu",(unsigned long)self.topics.count);
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSPTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XSPTopicCellID];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出帖子模型
    XSPTopic *topic = self.topics[indexPath.row];
    
    
    return topic.cellHeight;
}

//在分类方法的时候加前缀(sd:代表是别人的框架)以示区分

@end
