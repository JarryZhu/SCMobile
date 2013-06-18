//
//  ApiMethod.h
//  Surwin
//
//  Created by Surwin on 13-5-14.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#ifndef Surwin_ApiMethod_h
#define Surwin_ApiMethod_h

/**
 *  API接口方法定义
 */

#define     API_USER_AUTHOR         @"user/author.do"   //用户登录授权
#define     API_USER_REGISTER       @"user/regist.do"   //用户注册
#define     API_USER_DETAIL         @"user/detail.do"   //用户详情
#define     API_USER_EDIT           @"user/edit.do"     //用户资料修改
#define     API_USER_EDITHEAD       @"user/editHeadImg.do"  //用户头像修改
#define     API_USER_OLOGIN         @"user/ologin.do"   //第三方登录

#define     API_CONTENT_FIND        @"content/find.do"  //内容查询
#define     API_CONTENT_ADD         @"content/save.do"  //发布内容

#define     API_CTYPE_FIND          @"ctype/find.do"    //内容分类查询

#define     API_COMMENT_ADD         @"comment/save.do"  //发布评论/回复评论
#define     API_COMMENT_FIND        @"comment/find.do"  //评论查询

#define     API_COLLECT_ADD         @"collect/save.do"  //新增收藏
#define     API_COLLECT_FIND        @"collect/find.do"  //收藏查询
#define     API_COLLECT_DEL         @"collect/del.do"   //删除收藏

#define     API_LIKE_ADD            @"like/save.do"     //新增喜欢
#define     API_LIKE_FIND           @"like/find.do"     //喜欢查询

#define     API_SHARE_SAVE          @"share/save.do"    //分享记录

#define     API_SYSMSG_FIND         @"sysmsg/find.do"   //系统消息查询

#endif
