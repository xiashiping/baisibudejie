//
//  XSPleftTableViewCell.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/30.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <UIKit/UIKit.h>

//引入模型
@class XSPrecommend;

@interface XSPleftTableViewCell : UITableViewCell

//左侧的类别模型
@property (nonatomic, assign)XSPrecommend *category;

@end
