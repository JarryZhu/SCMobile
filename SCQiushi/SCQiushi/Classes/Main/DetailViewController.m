//
//  DetailViewController.m
//  SCQiushi
//
//  Created by Surwin on 13-7-2.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "DetailViewController.h"
#import "UIButton+WebCache.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"糗事真相";
    
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
 
    [_contentView addSubview:self.userIconImage];
    [_contentView addSubview:self.userNameLabel];
    [_contentView addSubview:self.timeLabel];
    [_contentView addSubview:self.contentLabel];
    [_contentView addSubview:self.contentImage];

    [self.view addSubview:self.contentView];
}

- (IBAction) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setItemData:(QiushiItem *)itemData
{
    _itemData = itemData;
    
    [self computerSize];
}

- (void) computerSize
{
    CGSize size = CGSizeMake(300, 2000);
    CGSize titleSize = [self.itemData.content sizeWithFont:BOLDSYSTEMFONT(15)
                                    constrainedToSize:size
                                        lineBreakMode:UILineBreakModeTailTruncation];
    [self.contentLabel setFrameHeight:titleSize.height];
    
    [self.contentLabel setText:self.itemData.content];
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%.1f", self.itemData.published_at]];
    
    if (self.itemData.anchor) {
        [self.userNameLabel setText:self.itemData.anchor];
        [self.userIconImage setImageWithURL:[NSURL URLWithString:self.itemData.iconURL]
                           placeholderImage:[UIImage imageNamed:@"default_icon.jpg"]];
        [self.timeLabel setHidden:YES];
    }
    else {
        [self.userNameLabel setHidden:YES];
        [self.userIconImage setHidden:YES];
        [self.timeLabel setHidden:NO];
    }
    
    if (self.itemData.imageMidURL) {
        [self.contentImage setFrameY:self.contentLabel.y+self.contentLabel.height+8];
        [self.contentImage setImageWithURL:[NSURL URLWithString:self.itemData.imageMidURL]
                          placeholderImage:nil];
    }
    else {
        [self.contentImage setHidden:YES];
    }
}

#pragma mark - Views Init

- (UIButton *) userIconImage
{
    if (!_userIconImage) {
        _userIconImage = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
        [_userIconImage setBackgroundImage:@"default_icon.jpg" hilighted:nil selectedImage:nil];
        
        _userIconImage.layer.masksToBounds = YES;
        _userIconImage.layer.cornerRadius = 3.0;
        
        //[_userIconImage addTarget:self action:@selector(iconClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userIconImage;
}

- (UILabel *) userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel  = [[UILabel alloc] init];
        _userNameLabel.frame = CGRectMake(50, 16, 250, 20);
        _userNameLabel.font = BOLDSYSTEMFONT(15);
        _userNameLabel.backgroundColor = CLEAR_COLOR;
        _userNameLabel.textColor = DARKGRAY_COLOR;
        _userNameLabel.text = @"Name";
    }
    return _userNameLabel;
}

- (UILabel *) timeLabel
{
    if (!_timeLabel) {
        _timeLabel  = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(10, 16, 300, 20);
        _timeLabel.font = BOLDSYSTEMFONT(15);
        _timeLabel.backgroundColor = CLEAR_COLOR;
        _timeLabel.textColor = GRAY_COLOR;
        _timeLabel.text = @"";
        [self.timeLabel setTextAlignment:UITextAlignmentLeft];
    }
    return _timeLabel;
}

- (UILabel *) contentLabel
{
    if (!_contentLabel) {
        _contentLabel  = [[UILabel alloc] init];
        _contentLabel.frame = CGRectMake(10, 50, 300, 40);
        _contentLabel.font = BOLDSYSTEMFONT(15.0f);//ARIALFONTSIZE(16.0f);
        _contentLabel.backgroundColor = CLEAR_COLOR;
        _contentLabel.textColor = DARKGRAY_COLOR;
        _contentLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _contentLabel.text = @"内容";
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

- (UIButton *) contentImage
{
    if (!_contentImage) {
        _contentImage = [[UIButton alloc] initWithFrame:CGRectMake(10, 8, 300, 280)];
        _contentImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
                
        //[_contentImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentImage;
}


@end
