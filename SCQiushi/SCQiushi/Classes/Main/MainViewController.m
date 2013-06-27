//
//  MainViewController.m
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = WHITE_COLOR;
    [self.view addBackgroundColor:@"main_background"];
    
}

- (IBAction) leftButtonAction:(id)sender
{
    [[AppDelegate sharedAppDelegate].menuController showLeftPanelAnimated:YES];
}

@end
