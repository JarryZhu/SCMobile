//
//  BaseViewController.m
//  SCQiushi
//
//  Created by jarry on 13-4-24.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "BaseViewController.h"
#import "SVProgressHUD.h"

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = WHITE_COLOR;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self reduceMemory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    WARNLOG(@"-- memory warning ! -- %@", self.title);
    [self reduceMemory];
}

- (void) dealloc
{
    [self reduceMemory];
}

- (void) setupContent
{
    
}

- (void) reduceMemory
{
    self.pageViewId = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // DataTracker
    [[DataTracker sharedInstance] beginTrackPage:self.pageViewId];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // DataTracker
    [[DataTracker sharedInstance] endTrackPage:self.pageViewId];
    
    [self finishProgress];
}

- (void) startProgress:(NSString *)text
{
    [SVProgressHUD showWithStatus:text];
}

- (void) finishProgress
{
    [SVProgressHUD dismiss];
}

@end
