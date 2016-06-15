//
//  XSPGonst.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    XSPtopicTypeAll = 1,
    XSPtopicTypePicture = 10,
    XSPtopicTypeWord = 29,
    XSPtopicTypeVoice = 31,
    XSPtopicTypeVideo = 41
} XSPTopicType;


/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const XSPtitlesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const XSPtitlesViewY;



/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const XSPTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const XSPTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const XSPTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const XSPTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度，就是用Break */
UIKIT_EXTERN CGFloat const XSPTopicPictureBreakH;

