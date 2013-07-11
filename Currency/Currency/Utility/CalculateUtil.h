//
//  CalculateUtil.h
//  Currency
//
//  Created by Surwin on 13-7-11.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

// 
#define     NUMBER_1        1
#define     NUMBER_2        2
#define     NUMBER_3        3
#define     NUMBER_4        4
#define     NUMBER_5        5
#define     NUMBER_6        6
#define     NUMBER_7        7
#define     NUMBER_8        8
#define     NUMBER_9        9
#define     NUMBER_0        10
#define     NUMBER_DOT      11

#define     OPT_CLEAR       20      // C
#define     OPT_DELETE      21      // D
#define     OPT_PLUS        22      // +
#define     OPT_SUB         23      // -
#define     OPT_MUL         24      // x
#define     OPT_DIV         25      // ÷
#define     OPT_EQUAL       26      // =
#define     OPT_PERCENT     27      // %
#define     OPT_DOLLOR      28      // $


@interface CalculateUtil : NSObject
{
    BOOL backOpen;  //是否能退格
    BOOL bBegin;    //是否开始输入数字

    double fstOperand;
	double sumOperand;

    NSInteger   operatorId;
}

@property   (nonatomic, copy)   NSString    *displayText;


+ (CalculateUtil *) instance;


- (NSString *) inputOperator:(NSInteger)optId;




@end
