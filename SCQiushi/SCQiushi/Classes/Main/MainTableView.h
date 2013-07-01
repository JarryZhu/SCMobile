//
//  MainTableView.h
//  SCQiushi
//
//  Created by Surwin on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseTableView.h"
#import "ListResponse.h"

@interface MainTableView : BaseTableView

@property   (nonatomic, strong)     ListResponse    *listResponse;

- (void) updateTableData:(ListResponse *)response isFirst:(BOOL)isFirst;
- (void) updateSelectCell:(QiushiItem *)itemData;

- (void) resetContent;

- (NSInteger) listCount;

@end
