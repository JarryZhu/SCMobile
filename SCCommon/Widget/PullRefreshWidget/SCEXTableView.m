//
//  SCEXTableView.m
//  SCUtility
//
//  Created by Jarry on 7/12/12.
//  Copyright (c) 2012 Jarry. All rights reserved.
//

#import "SCEXTableView.h"

#pragma mark -- SCEXTableView

@interface SCEXTableView() 
@property (nonatomic, retain) SCScrollViewDecorate *decoreate;
@end

@implementation SCEXTableView

@synthesize didReachTheEnd  = _didReachTheEnd;
@synthesize decoreate       = _decoreate;
@synthesize exDelegate      = _exDelegate;

- (id)initWithFrame:(CGRect)frame
{
    [NSException raise:@"Incomplete initializer" 
                format:@"SCEXTableView must be initialized with a delegate and a eViewType.\
                         Use the initWithFrame:style:type:delegate: method."];
    return nil;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id) theDelegate
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) 
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.decoreate = [[[SCScrollViewDecorate alloc] initWithFrame:frame with:self type:theType delegate:theDelegate] autorelease];
    }
    return self;
}

- (void)dealloc 
{
    [_decoreate release],   _decoreate   = nil;
    [super dealloc];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.decoreate setDecorateEnabled:!editing];
}

#pragma mark -- scrollDelegate

- (void) tableViewDidEndDragging:(UIScrollView *)scrollView
{
    if (self.editing) {
        return;
    }
    [_decoreate tableViewDidEndDragging:scrollView];
}

- (void) tableViewDidScroll:(UIScrollView *)scrollView
{
    if (self.editing) {
        return;
    }
    [_decoreate tableViewDidScroll:scrollView];
}

- (void) launchRefreshing 
{
    if (self.editing) {
        return;
    }
    [_decoreate launchRefreshing];
}

- (void)prepareRefreshing:(voidBlock)block
{
    if (self.editing) {
        return;
    }
    [_decoreate prepareRefreshing:block];
}

- (void)tableViewDidFinishedLoading 
{
    if (self.editing) {
        return;
    }
    [_decoreate tableViewDidFinishedLoading];
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg
{
    if (self.editing) {
        return;
    }
    [_decoreate tableViewDidFinishedLoadingWithMessage:msg];
}

- (void)setDidReachTheEnd:(BOOL)theDidReachTheEnd
{
    _didReachTheEnd = theDidReachTheEnd;
    _decoreate.didReachTheEnd = theDidReachTheEnd;
}
@end
