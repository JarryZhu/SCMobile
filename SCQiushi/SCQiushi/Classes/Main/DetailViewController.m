//
//  DetailViewController.m
//  SCQiushi
//
//  Created by Surwin on 13-7-2.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "DetailViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "NetServiceFace.h"
#import "CommentResponse.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"糗事真相";
    self.pageViewId = self.title;
    
    self.titleLabel.textColor = RGBCOLOR(0x83, 0x60, 0x3b);
    self.titleLabel.shadowColor = WHITE_COLOR;
    
    [self.titleView addBackgroundColor:@"main_background"];
    [self.titleView addBottomShadow];
    [self.leftButton setNormalImage:@"top_btn_back" selectedImage:nil];
    
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.commentListView];
    [self.contentView addSubview:self.emptyView];
    [self.contentView addSubview:self.spinningCircle];
    [self.view addSubview:self.contentView];
    
    //
    //if (self.itemData.commentsCount > 0) {
        self.spinningCircle.isAnimating = YES;
        GCD_DEFAULT(^ {
            [self requestCommentsList];
        });
    //}
    
#if kAdEnabled
    //创建广告 banner
    [self performBlock:^{
        if (self.adView == nil) {
            self.adView = [AdSageView requestAdSageBannerAdView:self sizeType:AdSageBannerAdViewSize_320X50]; //设置广告显示位置
            self.adView.frame = CGRectMake(0, self.view.height - 50, 320, 50); //显示广告
        }
        [self.view addSubview:self.adView];
        
    } afterDelay:.5f];
#endif
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewDidUnload
{
    [NetServiceFace cancelServiceMethod:kAPI_Comments];

#if kAdEnabled
    if (self.adView) {
        [self.adView removeFromSuperview];
        self.adView = nil;
    }
#endif
}

- (IBAction) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) setItemData:(QiushiItem *)itemData
{
    _itemData = itemData;
    
    [self.topView updateContent:itemData];
    [self computerSize];
    
}

- (void) computerSize
{
    //
    CGFloat commentHeight = (self.commentListView.contentArray.count > 0) ? self.commentListView.height : 50;
    CGFloat topHeight = [self.topView getViewHeight];
    //[self.topView setFrameHeight:topHeight];
    [self.commentListView setFrameY:topHeight];
    [self.spinningCircle setFrameOrigin:CGPointMake(140, topHeight+12)];

    [self.emptyView setFrameY:topHeight];
//    if (self.itemData.commentsCount == 0) {
//        [self.emptyView setHidden:NO];
//    }
    
    CGFloat height = topHeight + commentHeight + 52;
    [self.contentView setContentSize:CGSizeMake(320, height)];
}

- (void) requestCommentsList
{
    //
    [NetServiceFace requestCommentList:self.itemData.qiushiID
                                onSuc:^(id content)
     {
         CommentResponse *response = [[CommentResponse alloc] initWithDictionary:content];
         GCD_MAIN(^{
             [self.commentListView setContentArray:response.result];
             self.itemData.commentsCount = response.count;
             
             self.spinningCircle.isAnimating = NO;
             if (response.result.count == 0) {
                 [self.emptyView setHidden:NO];
             }
             [self computerSize];
         });
         
     } onFailed:^(id content) {
         self.spinningCircle.isAnimating = NO;
     } onError:^(id content) {
         self.spinningCircle.isAnimating = NO;
     }];
}

#pragma mark - Views Init

- (DetailTopView *) topView
{
    if (!_topView) {
        _topView = [[DetailTopView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}

- (UIScrollView *) contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CONTENT_FRAME];
        _contentView.contentSize = _contentView.bounds.size;
        _contentView.bounces = YES;
        _contentView.alwaysBounceVertical = YES;
        _contentView.delegate = self;
        _contentView.showsVerticalScrollIndicator = NO;
    }
    return _contentView;
}

- (CommentTableView *) commentListView
{
    if (!_commentListView) {
        _commentListView = [[CommentTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)
                                                             style:UITableViewStylePlain
                                                              type:eTypeNone
                                                          delegate:nil];
    }
    return _commentListView;
}

- (UIView *) emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        _emptyView.backgroundColor = CLEAR_COLOR;
        
        UILabel *textLabel  = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 320, 50)];
        textLabel.font = SYSTEMFONT(15.0f);
        textLabel.backgroundColor = CLEAR_COLOR;
        textLabel.textColor = DARKGRAY_COLOR;
        textLabel.text = @"亲，还没有糗友评论哦~~";
        [_emptyView addSubview:textLabel];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 49, 300, 1.0f)];
        [line addBackgroundColor:@"divider_line"];
        [_emptyView addSubview:line];
        
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (MBSpinningCircle *) spinningCircle
{
    if (!_spinningCircle) {
        _spinningCircle = [MBSpinningCircle circleWithSize:NSSpinningCircleSizeSmall color:RGBCOLOR(0xED, 0xE4, 0xD5)];
        //[_spinningCircle setFrameOrigin:CGPointMake(120, 200)];
    }
    return _spinningCircle;
}

#pragma mark - DetailViewDelegate
- (void) imageLoadFinished:(DetailTopView *)view
{
    [self computerSize];
}

#pragma mark - AdSageDelegate
- (UIViewController *) viewControllerForPresentingModalView
{
    return [AppDelegate sharedAppDelegate].menuController;
}

- (void) adSageDidReceiveBannerAd:(AdSageView *)adSageView
{
    //[self.contentView setFrameHeight:BOUNDS_HEIGHT-NAVIGATION_HEIGHT-50];
}

- (void) adSageDidFailToReceiveBannerAd:(AdSageView *)adSageView
{
    ERRORLOG(@"Detail -- adSageDidFailToReceiveBannerAd");
}

@end
