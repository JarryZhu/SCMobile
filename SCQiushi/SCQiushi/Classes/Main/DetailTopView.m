//
//  DetailTopView.m
//  SCQiushi
//
//  Created by Surwin on 13-7-3.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "DetailTopView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@implementation DetailTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = CLEAR_COLOR;
        
        [self addSubview:self.userIconImage];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.contentImage];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (void) dealloc
{
    [self.contentImage cancelCurrentImageLoad];
}

- (void) updateContent:(QiushiItem *)itemData
{
    [self.contentLabel setText:itemData.content];
    
    CGSize size = [self.contentLabel.text sizeWithFont:self.contentLabel.font constrainedToSize:CGSizeMake(305, CGFLOAT_MAX) lineBreakMode:UILineBreakModeTailTruncation];
    [self.contentLabel setFrameHeight:size.height];
    
    [self.likeButton setText:kIntToString(itemData.upCount)];
    [self.againstButton setText:kIntToString(itemData.downCount)];

    //[self.timeLabel setText:[NSString stringWithFormat:@"%.1f", self.itemData.published_at]];

    if (itemData.anchor) {
        [self.userNameLabel setText:itemData.anchor];
        [self.userIconImage setBackgroundImageWithURL:[NSURL URLWithString:itemData.iconURL]
                                     placeholderImage:[UIImage imageNamed:kDefaultIconImage]];
        [self.timeLabel setHidden:YES];
        [self.contentLabel setFrameY:48];
    }
    else {
        [self.userNameLabel setHidden:YES];
        [self.userIconImage setHidden:YES];
        [self.timeLabel setHidden:NO];
        [self.contentLabel setFrameY:40];
    }
    
    __block UIImage *curImage = nil;
    if (itemData.imageURL) {
        __weak DetailTopView *wSelf = self;
        [self.contentImage setFrameY:self.contentLabel.y+self.contentLabel.height+8];
        [self.contentImage setImageWithURL:[NSURL URLWithString:itemData.imageURL]
                          placeholderImage:nil success:^(UIImage *image)
         {
             curImage = image;
             DetailTopView *sSelf = wSelf;
             [sSelf setImage:image];
         } failure:nil];
    }
    else {
        [self.contentImage setHidden:YES];
        [self.bottomView setFrameY:self.contentLabel.y+self.contentLabel.height+8];
    }
    
    if (itemData.imageMidURL) {
        //获取大图
        [self performBlock:^{
            [self.contentImage setImageWithURL:[NSURL URLWithString:itemData.imageMidURL]
                              placeholderImage:curImage];
        } afterDelay:.5f];
    }
}

- (CGFloat) getViewHeight
{
    return self.bottomView.y + self.bottomView.height;
}

- (void) computeSize
{
    
}

- (void) setImage:(UIImage *)image
{
    if (!image) {
        return;
    }
    CGSize size = image.size;
    if (size.width > size.height) {
        [self.contentImage setFrameWidth:280.0f];
        CGFloat height = 280.0f * size.height/size.width;
        [self.contentImage setFrameHeight:height];
    }
    else {
        [self.contentImage setFrameHeight:280.0f];
        CGFloat width = 280.0f * size.width/size.height;
        [self.contentImage setFrameWidth:width];
    }
    
    [self.bottomView setFrameY:self.contentImage.y + self.contentImage.height+8];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"divider_line_bold"]] set];
    CGContextFillRect(context, CGRectMake(8.0f, [self getViewHeight]-2.0f, SCREEN_WIDTH-16.0f, 2.0f));
}


#pragma mark - Views Init

- (UIButton *) userIconImage
{
    if (!_userIconImage) {
        _userIconImage = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
        _userIconImage.imageView.contentMode = UIViewContentModeScaleToFill;
        [_userIconImage setBackgroundImage:kDefaultIconImage hilighted:nil selectedImage:nil];
        
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
        _userNameLabel.font = ARIALFONTSIZE(15);
        _userNameLabel.backgroundColor = CLEAR_COLOR;
        _userNameLabel.textColor = kUserNameColor;
        _userNameLabel.text = @"Name";
    }
    return _userNameLabel;
}

- (UILabel *) timeLabel
{
    if (!_timeLabel) {
        _timeLabel  = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(12, 12, 300, 20);
        _timeLabel.font = ARIALFONTSIZE(15);
        _timeLabel.backgroundColor = CLEAR_COLOR;
        _timeLabel.textColor = kUserNameColor;
        _timeLabel.text = @"2013-07-03 12:02:18";
        [self.timeLabel setTextAlignment:UITextAlignmentLeft];
    }
    return _timeLabel;
}

- (UILabel *) contentLabel
{
    if (!_contentLabel) {
        _contentLabel  = [[UILabel alloc] init];
        _contentLabel.frame = CGRectMake(10, 48, 302, 40);
        _contentLabel.font = BOLDSYSTEMFONT(15.0f);//ARIALFONTSIZE(16.0f);
        _contentLabel.backgroundColor = CLEAR_COLOR;
        _contentLabel.textColor = DARKGRAY_COLOR;
        _contentLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _contentLabel.text = @"内容";
        _contentLabel.numberOfLines = 0;
    }
    
    return _contentLabel;
}

- (UIImageView *) contentImage
{
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, 280, 280)];
        _contentImage.contentMode = UIViewContentModeScaleToFill;
    }
    return _contentImage;
}

- (UIView *) bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 320, 40)];
        //_bottomView.backgroundColor = RED_COLOR;
        
        [_bottomView addSubview:self.likeButton];
        [_bottomView addSubview:self.againstButton];
    }
    return _bottomView;
}

- (ImageCountButton *) likeButton
{
    if (!_likeButton) {
        _likeButton = [ImageCountButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(10, 2, 80, 30);
        [_likeButton setTitle:@"123" forState:UIControlStateNormal];
        
        [_likeButton setNormalImage:@"icon_like" selectedImage:@"icon_like"];
    }
    return _likeButton;
}

- (ImageCountButton *) againstButton
{
    if (!_againstButton) {
        _againstButton = [ImageCountButton buttonWithType:UIButtonTypeCustom];
        _againstButton.frame = CGRectMake(80, 2, 80, 30);
        [_againstButton setTitle:@"123" forState:UIControlStateNormal];
        
        [_againstButton setNormalImage:@"icon_against" selectedImage:@"icon_against"];
    }
    return _againstButton;
}

@end
