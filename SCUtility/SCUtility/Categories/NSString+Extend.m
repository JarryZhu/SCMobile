//
//  NSString+Extend.m
//  SCUtility
//
//  Created by Jarry on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>
#import "SCLog.h"

@implementation NSString (Extend)

+ (NSString *) MD5:(NSString *)targetStr
{
    const char *cStr = [targetStr UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],   result[3],
            result[4],  result[5],  result[6],   result[7],
            result[8],  result[9],  result[10],  result[11],
            result[12], result[13], result[14],  result[15] ];
    
}

- (NSString *) trim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *) numericValue
{
    return [NSNumber numberWithInt:[self intValue]];
}

+ (void) printFontAndFamilyName
{
    NSArray *familyNames =[[[NSArray alloc] initWithArray:[UIFont familyNames]] autorelease];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    NSMutableString *debugStr = [NSMutableString string];
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        [debugStr appendFormat:@"Family name: %@", [familyNames objectAtIndex:indFamily]];
        //DEBUGLOG(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]] autorelease];
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
            [debugStr appendFormat:@"\n  Font name: %@",[fontNames objectAtIndex:indFont]];
            //DEBUGLOG(@" Font name: %@",[fontNames objectAtIndex:indFont]);
        }
        [debugStr appendString:@"\n\n"];
    }
    DEBUGLOG(@"%@", debugStr);
}

@end
