//
//  BaseTitleViewController.m
//  SCQiushi
//
//  Created by jarry on 13-5-3.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "AppDelegate.h"
//#import "NSString+FontAwesome.h"

@implementation BaseTitleViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view addSubview:self.titleView];
    [self.titleView addSubview:self.leftButton];
}

- (void) setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.titleLabel.text = title;
}

- (UIView *) titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:HEADER_FRAME];
        //[_titleView addBackgroundStretchableImage:@"navigation_bg" leftCapWidth:0 topCapHeight:0];
        [_titleView addBackgroundColor:@"navigation_bg"];
        
        [_titleView addSubview:self.titleLabel];
        
        //[_titleView addBottomShadow];
    }
    return _titleView;
}

- (UILabel *) titleLabel
{
    if (!_titleLabel) {
        _titleLabel  = [[UILabel alloc] init];
        _titleLabel.frame = HEADER_TITLE_FRAME;
        _titleLabel.font = TNRFONTSIZE(20);
        _titleLabel.backgroundColor = CLEAR_COLOR;
        _titleLabel.textColor = RGBCOLOR(0xff, 0xf1, 0xcc);
        _titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.text = self.title;
        
        _titleLabel.shadowOffset = CGSizeMake(0.4f, 0.6f);
		_titleLabel.shadowColor = BLACK_COLOR;
        
//        UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleDidTapped:)] autorelease];
//        [_titleLabel addGestureRecognizer:gesture];
    }
    return _titleLabel;
}

- (UIButton *) leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(2, 3, 44, 38);
        
        [_leftButton setNormalImage:@"top_btn_menu" selectedImage:nil];
        
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *) rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(274, 3, 44, 38);
        
        _rightButton.titleLabel.font = BOLDSYSTEMFONT(14);
        _rightButton.titleLabel.textAlignment = UITextAlignmentCenter;
        
        [_rightButton setNormalImage:@"top_btn_back" selectedImage:nil];

        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (IBAction) leftButtonAction:(id)sender
{
    
}

- (IBAction) rightButtonAction:(id)sender
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end
