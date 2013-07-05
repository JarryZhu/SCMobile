//
//  PagingRequest.h
//  Surwin
//
//  Created by Surwin on 13-5-20.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseRequest.h"

/**
 *  分页列表请求
 */
@interface PagingRequest : BaseRequest

@property   (nonatomic, assign)     NSInteger   pageNo;     // 页码
@property   (nonatomic, assign)     NSInteger   limit;      // 提取数据量

- (id) nextPage;
- (id) prevPage;

- (void) resetPage;

- (NSInteger) firstPage;
- (BOOL) isFristPage;


@end
