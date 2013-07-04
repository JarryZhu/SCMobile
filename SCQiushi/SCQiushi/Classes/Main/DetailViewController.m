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
    
    self.titleLabel.textColor = RGBCOLOR(0x83, 0x60, 0x3b);
    self.titleLabel.shadowColor = WHITE_COLOR;
    
    [self.titleView addBackgroundColor:@"main_background"];
    [self.titleView addBottomShadow];
    [self.leftButton setNormalImage:@"top_btn_back" selectedImage:nil];
    
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.commentListView];
    [self.contentView addSubview:self.emptyView];
    [self.view addSubview:self.contentView];
    
    //创建广告 banner
    [self performBlock:^{
        
        if (self.adView == nil) {
            self.adView = [AdSageView requestAdSageBannerAdView:self sizeType:AdSageBannerAdViewSize_320X50]; //设置广告显示位置
            self.adView.frame = CGRectMake(0, self.view.height - 50, 320, 50); //显示广告
        }
        [self.view addSubview:self.adView];
        
    } afterDelay:1.0f];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //
    if (self.itemData.commentsCount > 0) {
        GCD_DEFAULT(^ {
            [self requestCommentsList];
        });
    }

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
    //CGFloat commentHeight = 200;// (self.itemData.commentCount > 0) ? self.commentListView.height : 10;
    CGFloat topHeight = [self.topView getViewHeight];
    //[self.topView setFrameHeight:topHeight];
    [self.commentListView setFrameY:topHeight];
    
    if (self.itemData.commentsCount > 0) {
        
        
    }
    else {
        [self.emptyView setHidden:NO];
        [self.emptyView setFrameY:topHeight];
    }
    
    CGFloat height = self.commentListView.y + self.commentListView.height;
    [self.contentView setContentSize:CGSizeMake(320, height)];
}

- (void) requestCommentsList
{
    //
    [NetServiceFace requestCommentList:self.itemData.qiushiID
                                onSuc:^(id content)
     {
         CommentResponse *response = [[CommentResponse alloc] initWithDictionary:content];
         [self.commentListView setContentArray:response.result];
         
         GCD_MAIN(^{
             [self computerSize];
         });
         
     } onFailed:^(id content) {
     } onError:^(id content) {
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
        textLabel.font = SYSTEMFONT(14.0f);
        textLabel.backgroundColor = CLEAR_COLOR;
        textLabel.textColor = DARKGRAY_COLOR;
        textLabel.text = @"亲，还没有评论哦~~";
        [_emptyView addSubview:textLabel];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 49, 300, 1.0f)];
        [line addBackgroundColor:@"divider_line"];
        [_emptyView addSubview:line];
        
        _emptyView.hidden = YES;
    }
    return _emptyView;
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
    [self.contentView setFrameHeight:BOUNDS_HEIGHT-NAVIGATION_HEIGHT-50];
}

- (void) adSageDidFailToReceiveBannerAd:(AdSageView *)adSageView
{
    ERRORLOG(@"Detail -- adSageDidFailToReceiveBannerAd");
}

@end
