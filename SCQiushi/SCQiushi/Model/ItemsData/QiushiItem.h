//
//  QiushiItem.h
//  SCQiushi
//
//  Created by Jarry on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseItemData.h"

@interface QiushiItem : BaseItemData

@property (nonatomic,copy)  NSString    *imageURL;      //小图片链接地址
@property (nonatomic,copy)  NSString    *imageMidURL;   //大图片链接地址
@property (nonatomic,copy)  NSString    *tag;           //标签
@property (nonatomic,copy)  NSString    *qiushiID;      //糗事id
@property (nonatomic,copy)  NSString    *content;       //内容
@property (nonatomic,copy)  NSString    *anchor;        //作者
@property (nonatomic,copy)  NSString    *iconURL;       //作者头像链接地址
@property (nonatomic,assign) NSTimeInterval published_at; //发布时间
@property (nonatomic,assign) NSInteger    commentsCount;  //评论数量
@property (nonatomic,assign) NSInteger    downCount;    //顶的数量
@property (nonatomic,assign) NSInteger    upCount;      //踩的数量

@end
