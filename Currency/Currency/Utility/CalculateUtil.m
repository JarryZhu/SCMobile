//
//  CalculateUtil.m
//  Currency
//
//  Created by Surwin on 13-7-11.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "CalculateUtil.h"

@implementation CalculateUtil

+ (CalculateUtil *) instance
{
    static dispatch_once_t  onceToken;
    static CalculateUtil * instance;
    dispatch_once(&onceToken, ^{
        instance = [[CalculateUtil alloc] init];
    });
    return instance;
}


- (NSString *) inputOperator:(NSInteger)optId
{
    switch (optId) {
        case OPT_CLEAR:     // C
        {
            [self clearAll];
        }
            break;
            
        case OPT_DELETE:    // DEL
        {
            if (backOpen) {
                if (self.displayText.length <= 1) {
                    self.displayText = @"";
                }
                else {
                    self.displayText = [self.displayText substringToIndex:self.displayText.length -1];
                }
            }
        }
            break;
            
        // 双操作数运算
        case OPT_EQUAL:     // =
        case OPT_PLUS:      // +
        case OPT_SUB:       // -
        case OPT_MUL:       // x
        case OPT_DIV:       // ÷
        {
            if (self.displayText.length == 0) {
                break;
            }
            
            backOpen = NO;
            fstOperand = [self.displayText doubleValue];
            
            if(!bBegin) {
                
                if (operatorId == OPT_EQUAL) {  // =
                    sumOperand = fstOperand;
                }
                else if (operatorId == OPT_PLUS) { // +
                    sumOperand += fstOperand;
                }
                else if (operatorId == OPT_SUB) { // -
                    sumOperand -= fstOperand;
                }
                else if (operatorId == OPT_MUL) { // x
                    sumOperand *= fstOperand;
                }
                else if (operatorId == OPT_DIV) { // ÷
                    
                    if(fstOperand!= 0) {
                        sumOperand /= fstOperand;
                    }
                    else {
                        [self clearAll];
                        return @"nan";
                    }
                }
                
                self.displayText = [NSString stringWithFormat:@"%g",sumOperand];
                
                bBegin= YES;
            }
            
            operatorId = optId;
        }
            break;
            
        // 单操作数运算
        case OPT_PERCENT:   // %
        {
            if (self.displayText.length == 0) {
                break;
            }
            
            operatorId = optId;
            backOpen = NO;
            
            fstOperand = [self.displayText doubleValue];
            
            sumOperand = fstOperand / 100;
			self.displayText = [NSString stringWithFormat:@"%g",sumOperand];
            
            bBegin = YES;
        }
            break;
            
        // 小数点
        case NUMBER_DOT:   // .
        {
            if (bBegin) {
                self.displayText = [self.displayText stringByAppendingString:@"0."];
            }
            else {
                if (self.displayText.length == 0) {
                    self.displayText = [self.displayText stringByAppendingString:@"0."];
                }
                else if ([self.displayText rangeOfString:@"."].location == NSNotFound) {
                    self.displayText = [self.displayText stringByAppendingString:@"."];
                }
            }
            backOpen = YES;
            bBegin = NO;
        }
            break;
            
        // 数字输入
        case NUMBER_1:   // 1
        case NUMBER_2:   // 2
        case NUMBER_3:   // 3
        case NUMBER_4:   // 4
        case NUMBER_5:   // 5
        case NUMBER_6:   // 6
        case NUMBER_7:   // 7
        case NUMBER_8:   // 8
        case NUMBER_9:   // 9
        case NUMBER_0:   // 0
        {
            NSString *input = kIntToString((optId==NUMBER_0) ? 0 : optId);
            if(bBegin || [self.displayText isEqualToString:@"0"]) {
                self.displayText = input;
            }
            else {
                self.displayText = [self.displayText stringByAppendingString:input];
            }
            backOpen = YES;
            bBegin = NO;
        }
            break;
                        
        default:
            break;
    }
    
    return self.displayText;
}

- (void) clearAll
{
    self.displayText = @"";
    fstOperand = 0;
    sumOperand = 0;
    operatorId = OPT_EQUAL;
    bBegin = YES;
}

@end
