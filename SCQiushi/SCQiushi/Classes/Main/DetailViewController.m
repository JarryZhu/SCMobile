//
//  DetailViewController.m
//  SCQiushi
//
//  Created by Surwin on 13-7-2.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.titleView addBackgroundColor:@"main_background"];
    [self.titleView addBottomShadow];
    [self.leftButton setNormalImage:@"top_btn_back" selectedImage:nil];
    
}

- (IBAction) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
