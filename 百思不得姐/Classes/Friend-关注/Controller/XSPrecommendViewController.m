//
//  XSPrecommendViewController.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/29.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPrecommendViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "XSPleftTableViewCell.h"
#import "XSPRightTableViewCell.h"
#import "XSPrecommend.h"
#import "XSPRightPrecemmend.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>



#define XSPselectedLeftTable self.dataArr[self.lefttable.indexPathForSelectedRow.row];

@interface XSPrecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

//左边的数据
@property (nonatomic, strong)NSArray *dataArr;

//左边的表格
@property (strong, nonatomic) IBOutlet UITableView *lefttable;
//右边的表格
@property (strong, nonatomic) IBOutlet UITableView *righttable;

//请求参数
@property (nonatomic, strong)NSMutableDictionary *params;

//AFN的请求管理者
@property (nonatomic, strong)AFHTTPSessionManager *manager;

@end

//XSPleftTableViewCell.xib的ID：@"lefttable"
static NSString * const XSPcategoryID = @"lefttable";
static NSString * const XSUserID = @"RightTable";

@implementation XSPrecommendViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTableView];
    [self requestdata];
    [self setFresh];
    
       // Do any additional setup after loading the view from its nib.
}

- (void)setupTableView
{
    //注册
    [self.lefttable registerNib:[UINib nibWithNibName:NSStringFromClass([XSPleftTableViewCell class]) bundle:nil] forCellReuseIdentifier:XSPcategoryID];
    [self.righttable registerNib:[UINib nibWithNibName:NSStringFromClass([XSPRightTableViewCell class]) bundle:nil] forCellReuseIdentifier:XSUserID];
    
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.lefttable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.righttable.contentInset = self.lefttable.contentInset;
    self.righttable.rowHeight = 70; //设置右边tableview的行号
    
    self.title = @"推荐关注";
    //设置控制器的背景颜色
    self.view.backgroundColor = XSPBGColor(223, 223, 223);

}

//添加刷新控件
- (void)setFresh
{
    self.righttable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadUpMoreFresh)];
    self.righttable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDownNewFresh)];
//    self.righttable.mj_footer.hidden = YES;
}

//加载新数据(下拉刷新)
- (void)loadDownNewFresh
{
    XSPrecommend *precod = XSPselectedLeftTable;
    //设置当前页码为1
    precod.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *marr = [NSMutableDictionary dictionary];
    marr [@"a"] = @"list";
    marr [@"c"] = @"subscribe";
    marr [@"category_id"] = @(precod.ID);
    marr [@"page"] = @(precod.currentPage);
    self.params = marr;
    
    //发送请求给服务器，创建右边的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:marr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != marr)
        {
            return;  //如果最后保存的请求参数不等于当前的参数，就结束本次操作
        }
        
        
        //字典数组转成模型数组
        NSArray *rightArr = [XSPRightPrecemmend mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSLog(@"%ld",rightArr.count);
        
        //清除所有旧数据
        [precod.users removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [precod.users addObjectsFromArray:rightArr];
        XSPLog(@"%ld",precod.users.count);
        
        //保存总数
        precod.total = [responseObject[@"total"] integerValue];
        
        //刷新右侧的表格
        [self.righttable reloadData];
        
        //结束刷新(头部刷新)
        [self.righttable.mj_header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != marr)
        {
            return;
        }
        
        //提示
        [SVProgressHUD showErrorWithStatus:@"用户加载数据失败"];
        
        //结束刷新
        [self.righttable.mj_header endRefreshing];
        
        
        XSPLog(@"%@",error);
    }];

}




//加载更多数据（上拉刷新）
- (void)loadUpMoreFresh
{
     XSPrecommend *categoey = XSPselectedLeftTable;
    
    
    //请求参数
    NSMutableDictionary *marr = [NSMutableDictionary dictionary];
    marr [@"a"] = @"list";
    marr [@"c"] = @"subscribe";
    marr [@"category_id"] = @(categoey.ID);
    marr [@"page"] = @(++categoey.currentPage);
    self.params = marr;
    
    //发送请求给服务器，加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:marr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != marr)
        {
            return;
        }
        
        
        //字典数组转成模型数组
        NSArray *rightArr = [XSPRightPrecemmend mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [categoey.users addObjectsFromArray:rightArr];
        //刷新右侧的表格
        [self.righttable reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != marr)
        {
            return;
        }
        
        //提示
        [SVProgressHUD showErrorWithStatus:@"用户加载数据失败"];

        //结束刷新
        [self.righttable.mj_header endRefreshing];
    
        XSPLog(@"%@",error);
    }];
}



#pragma mark - 请求数据（加载左侧的类别数据)
- (void)requestdata
{
       //SVProgressHUDMaskTypeBlack:当还在加载状态不能点击返回按钮
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters [@"a"] = @"category";
    parameters [@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        //服务器返回JSON数据
        self.dataArr = [XSPrecommend mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //        XSPLog(@"%@",responseObject[@"list"]);
        
        //刷新数据
        [self.lefttable reloadData];
        
        // 默认选中首行
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
       [self.lefttable selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户数据进入下拉刷新状态
        [self.righttable.mj_footer beginRefreshing]; 

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //显示失败提示
        [SVProgressHUD showErrorWithStatus:@"加载信息失败!"];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    XSPrecommend *rc = XSPselectedLeftTable;
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.righttable.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total)
    { // 全部数据已经加载完毕
        [self.righttable.mj_footer endRefreshingWithNoMoreData];
    }
    else
    { // 还没有加载完毕
        [self.righttable.mj_footer endRefreshing];
    }
}



#pragma mark - tableview的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.lefttable)
    {
        return self.dataArr.count;
    }
    else
    {
        
        [self checkFooterState];
        
        //左边被选中的类别模型（点击左边的哪个类型显示右边的什么内容）
        XSPrecommend *categoey = XSPselectedLeftTable;
        NSInteger count = categoey.users.count;
        return count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.lefttable)
    {
        XSPleftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XSPcategoryID];
        cell.category = self.dataArr[indexPath.row];
        return cell;
    }
    else
    {
        XSPRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XSUserID];
        XSPrecommend *category =XSPselectedLeftTable;
        cell.user = category.users[indexPath.row];

        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.righttable.mj_header endRefreshing];
    [self.righttable.mj_footer endRefreshing];
    
    XSPrecommend *precommed = self.dataArr[indexPath.row];
    
    [self.righttable.mj_footer endRefreshingWithNoMoreData];
    
    if (precommed.users.count)
    {
        //显示曾经的数据 (刷新数据)
        [self.righttable reloadData];
    }
    else
    {
        //刷新表格（马上显示当前lefttable的用户数据，不让用户看见残留数据）
        [self.righttable reloadData];
        
        //进入下拉刷新状态
        [self.righttable.mj_header beginRefreshing];
    }
    
}


#pragma mark - 控制器的销毁（点击返回的时候）
- (void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

/**
 *存在的三个问题 
 *1.重复发送请求
 *2.目前只能显示1页数据
 *3.网络慢带来的细节问题
 */

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
