//
//  ViewController.m
//  Currency
//
//  Created by Jarry on 13-6-18.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "ViewController.h"
#import "NetServiceFace.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*[NetServiceFace requestCurrencyConvertFrom:@"HKY"
                                    toCurrency:@"CNY"
                                         onSuc:^(id content)
    {
        
        
    } onFailed:^(id content) {
        
    }];*/
    
    
    [NetServiceFace requestStockQuote:@"600000.SS" onSuc:nil onFailed:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
