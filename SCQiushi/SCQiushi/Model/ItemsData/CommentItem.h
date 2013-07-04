//
//  CommentItem.h
//  SCQiushi
//
//  Created by Surwin on 13-7-4.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseItemData.h"

@interface CommentItem : BaseItemData

@property (nonatomic,copy)  NSString    *commentID;     //id
@property (nonatomic,copy)  NSString    *content;       //内容
@property (nonatomic,copy)  NSString    *anchor;        //作者
@property (nonatomic,copy)  NSString    *iconURL;       //作者头像链接地址

@property (nonatomic,assign)    NSInteger   floorNum;

@end
