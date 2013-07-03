//
//  MainTableView.m
//  SCQiushi
//
//  Created by Jarry on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "MainTableView.h"
#import "MainTableCell.h"

#define kBoundsHeight   (kIPhone5Increase + SCREEN_HEIGHT * 3/2)

@implementation MainTableView

- (void) setupContentView
{
}

- (void) resetContent
{
    self.listResponse = nil;
    [self showEmptyView:NO];
    [self reloadData];
}

- (NSInteger) listCount
{
    if (self.listResponse) {
        return self.listResponse.result.count;
    }
    return 0;
}

- (void) updateTableData:(ListResponse *)response isFirst:(BOOL)isFirst
{
    if (isFirst) {
        self.listResponse = response;
    }
    else {
        if (!self.listResponse) {
            self.listResponse = response;
        }
        else {
            [self.listResponse addResultList:response.result];
        }
    }
    
    [self setDidReachTheEnd:[self.listResponse didReachTheEnd]];
    
    if (self.listResponse.result.count == 0) {
        [self showEmptyView:YES];
    }
    
    [self reloadData];
}

- (void) updateSelectCell:(QiushiItem *)itemData
{
    if (!itemData) {
        return;
    }
}

- (void)tableViewDidStartRefreshing:(SCScrollViewDecorate *)tableView
{
    [self showEmptyView:NO];
    
    if (self.refreshBlock)
    {
        self.refreshBlock(nil);
    }
}

- (void)tableViewDidStartLoading:(SCScrollViewDecorate *)tableView
{
    [self showEmptyView:NO];
    
    if (self.loadMoreBlock && self.listResponse)
    {
        self.loadMoreBlock(nil);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listResponse ? self.listResponse.result.count : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    MainTableCell *cell = (MainTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MainTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.listResponse) {
        //cell.cellIndex = indexPath.row;
        QiushiItem *itemData = [self.listResponse.result objectAtIndex:indexPath.row];
        [cell updateCell:itemData];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) computeHeight:(NSString *)content
{
    CGSize size = CGSizeMake(300, 2000);
    CGSize titleSize = [content sizeWithFont:BOLDSYSTEMFONT(15)
                           constrainedToSize:size
                               lineBreakMode:UILineBreakModeTailTruncation];
    
    return titleSize.height + 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QiushiItem *item = [self.listResponse.result objectAtIndex:indexPath.row];
    return (item.imageURL==nil) ? [self computeHeight:[item shortContent]] : [self computeHeight:[item shortContent]]+110;
    //return [self computeHeight:[item shortContent]]+120;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selectIndex = indexPath.row;
    if (self.itemBlock)
    {
        QiushiItem *itemData = [self.listResponse.result objectAtIndex:indexPath.row];
        self.itemBlock(itemData);
    }
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
