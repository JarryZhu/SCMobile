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
    
    self.contentView = [[UIScrollView alloc] initWithFrame:CONTENT_FRAME];
    _contentView.contentSize = _contentView.bounds.size;
    _contentView.bounces = YES;
    _contentView.alwaysBounceVertical = YES;
    _contentView.delaysContentTouches = YES;
    _contentView.delegate = self;
    _contentView.showsVerticalScrollIndicator = NO;
 
    [_contentView addSubview:self.topView];

    [self.view addSubview:self.contentView];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    //CGFloat commentHeight = (self.itemData.commentCount > 0) ? self.commentListView.height : 10;
    CGFloat topHeight = [self.topView getViewHeight];
    //CGFloat height = self.contentImage.y + self.contentImage.height;
    //[self.commentListView setFrameY:topHeight-5];
    [self.contentView setContentSize:CGSizeMake(320, topHeight+50)];
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

@end
