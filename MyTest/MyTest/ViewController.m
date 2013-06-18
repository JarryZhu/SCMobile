//
//  ViewController.m
//  MyTest
//
//  Created by Jarry on 12-11-5.
//  Copyright (c) 2012年 Jarry. All rights reserved.
//

#import "ViewController.h"
#import "SCCategory.h"
#import "WebViewController.h"
#import "DDLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    DEBUGLOG(@"%@", @"debugdebugdebugdebugdebug");
//    ERRORLOG(@"errorerrorerrorerrorerror");
//    INFOLOG(@"infoinfoinfoinfoinfoinfo");
    
	//NSLog(XCODE_COLORS_ESCAPE @"fg0,0,255;" @"Blue text" XCODE_COLORS_RESET);


    if (getenv("NSZombieEnabled")) {
        WARNLOG(@"NSZombieEnabled: %s", getenv("NSZombieEnabled"));
    }
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButton.frame = CGRectMake(20, 50, 100, 40);
    [testButton setTitle:@"Test1" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testButton];

    UIButton *testButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButton2.frame = CGRectMake(20, 150, 100, 40);
    [testButton2 setTitle:@"Doc Test" forState:UIControlStateNormal];
    [testButton2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testButton2];

    UIButton *testButton3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButton3.frame = CGRectMake(20, 250, 100, 40);
    [testButton3 setTitle:@"Xls Test" forState:UIControlStateNormal];
    [testButton3 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testButton3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)loginAction:(id)sender
{
    WebViewController *webViewController = [[[WebViewController alloc] init] autorelease];
    [webViewController setRequestURL:@"http://ad.zj-zcl.com/testOffice.jsp"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)buttonAction:(id)sender
{
    WebViewController *webViewController = [[[WebViewController alloc] init] autorelease];
    [webViewController setRequestURL:@"http://ad.zj-zcl.com/readme.docx"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)button2Action:(id)sender
{
    WebViewController *webViewController = [[[WebViewController alloc] init] autorelease];
    [webViewController setRequestURL:@"http://ad.zj-zcl.com/readme.xlsx"];
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
