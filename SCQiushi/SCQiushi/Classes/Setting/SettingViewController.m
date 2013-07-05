//
//  SettingViewController.m
//  SCQiushi
//
//  Created by Surwin on 13-7-5.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view addBackgroundColor:@"main_background"];
    self.title = @"设 置 ";
    
    [self.leftButton setHidden:YES];
    [self.rightButton setNormalImage:@"top_btn_close" selectedImage:nil];
    [self.rightButton setShowsTouchWhenHighlighted:YES];
    [self.titleView addSubview:self.rightButton];
    
}

- (IBAction) rightButtonAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
