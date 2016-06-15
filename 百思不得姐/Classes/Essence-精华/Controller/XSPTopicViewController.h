//
//  XSPTopicViewController.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/13.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XSPTopicViewController : UITableViewController

/** 帖子类型 (交给子类去实现)*/
@property (assign, nonatomic) XSPTopicType type;

@end
