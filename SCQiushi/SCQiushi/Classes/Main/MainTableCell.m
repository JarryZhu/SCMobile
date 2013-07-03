//
//  MainTableCell.m
//  SCQiushi
//
//  Created by Surwin on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "MainTableCell.h"
#import "UIButton+WebCache.h"
#import "SCImageBrowserView.h"

@implementation MainTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RED_COLOR;

        [self addSubview:self.contentLabel];
        [self addSubview:self.contentImage];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    if (self.itemData && self.itemData.imageURL) {
        [self.contentLabel setFrameHeight:self.height-170];
        [self.contentImage setFrameY:self.height-140];
    }
    else {
        [self.contentLabel setFrameHeight:self.height-60];
    }
    [self.bottomView setFrameY:self.height-32];
}

- (void)drawRect:(CGRect)rect
{
    [super    drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    [RGBCOLOR(0xf9, 0xf9, 0xf9) set];
    CGContextFillRect(context, CGRectMake(8.0f, 8.0f, SCREEN_WIDTH-16.0f, self.height-8.0f));
}

- (void) updateCell:(QiushiItem *)itemData
{
    self.itemData = itemData;
    [self.contentLabel setText:itemData.content];
    
    [self.likeButton setText:kIntToString(itemData.upCount)];
    [self.againstButton setText:kIntToString(itemData.downCount)];
    
    if (itemData.imageURL) {
        [self.contentImage setHidden:NO];
        [self.contentImage setImageWithURL:[NSURL URLWithString:itemData.imageURL]
                          placeholderImage:[UIImage imageNamed:@"default_content_image"]];
    }
    else {
        [self.contentImage setHidden:YES];
    }
}

#pragma mark - Views Init

- (UILabel *) contentLabel
{
    if (!_contentLabel) {
        _contentLabel  = [[UILabel alloc] init];
        _contentLabel.frame = CGRectMake(18, 18, 292, 40);
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
        _contentImage = [[UIButton alloc] initWithFrame:CGRectMake(20, 8, 120, 100)];
        _contentImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
        //[_contentImage setBackgroundImage:kImageDefaultHead hilighted:nil selectedImage:nil];
        
        //_contentImage.layer.masksToBounds = YES;
        //_contentImage.layer.cornerRadius = 3.0;
        
        [_contentImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentImage;
}

- (UIView *) bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 400, 300, 32)];
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
        _likeButton.frame = CGRectMake(10, 0, 80, 30);
        [_likeButton setTitle:@"123" forState:UIControlStateNormal];
        
        [_likeButton setNormalImage:@"icon_like" selectedImage:@"icon_like"];
    }
    return _likeButton;
}

- (ImageCountButton *) againstButton
{
    if (!_againstButton) {
        _againstButton = [ImageCountButton buttonWithType:UIButtonTypeCustom];
        _againstButton.frame = CGRectMake(80, 0, 80, 30);
        [_againstButton setTitle:@"123" forState:UIControlStateNormal];
        
        [_againstButton setNormalImage:@"icon_against" selectedImage:@"icon_against"];
    }
    return _againstButton;
}

#pragma mark - Action

- (IBAction) imageClick:(id)sender
{
    [SCImageBrowserView showImage:_contentImage.imageView.image url:self.itemData.imageMidURL disappear:nil];
}

@end
