//
//  CommentTableView.m
//  SCQiushi
//
//  Created by Surwin on 13-7-4.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentTableCell.h"

@implementation CommentTableView

- (void) setupContentView
{
    //self.backgroundColor = RGBCOLOR(0xee, 0xee, 0xee);
}


- (void) setContentArray:(NSMutableArray *)contentArray
{
    [super setContentArray:contentArray];
    
    [self reloadData];
    
    //
    if (contentArray.count == 0) {
        [self setFrameHeight:0];
    }
    else {
        [self setFrameHeight:self.contentSize.height];
    }
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (CGFloat) computeHeight:(NSString *)content
{
    CGSize size = CGSizeMake(300, 2000);
    CGSize titleSize = [content sizeWithFont:SYSTEMFONT(15)
                           constrainedToSize:size
                               lineBreakMode:UILineBreakModeTailTruncation];
    
    return MAX(60, titleSize.height + 40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentItem *commentItem = [self.contentArray objectAtIndex:indexPath.row];
    return [self computeHeight:commentItem.content];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (!self.contentArray.count) ?  0 : self.contentArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalIdentifier = @"normalIdentifier";
    
    CommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:normalIdentifier];
    if (!cell){
        cell = [[CommentTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalIdentifier];
    }
    
    [cell updateCell:[self.contentArray objectAtIndex:indexPath.row]];
    
    return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 7.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *headerView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 7)] autorelease];
    headerView.image = IMAGENAMED(@"detail_comment_top");
    
    return headerView;
}*/

@end
