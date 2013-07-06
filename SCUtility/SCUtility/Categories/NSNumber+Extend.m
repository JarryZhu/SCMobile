//
//  NSNumber+Extend.m
//  SCUtility
//
//  Created by Surwin on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "NSNumber+Extend.h"

@implementation NSNumber (Extend)

- (NSString *) byteKMGBString
{
    unsigned long long byte = [self unsignedLongLongValue];
    unsigned long long igb = (byte >> 30);
    unsigned long long imb = (byte >> 20);
    unsigned long long ikb = (byte >> 10);
    
    if (igb != 0)
    {
        double fmb = (imb - igb * 1024) / 1024.0;
        NSString *GBString = [[[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fG",(igb+fmb)]] autorelease];
        return GBString;
    }
    else if (imb != 0)
    {
        double fkb = (ikb - imb * 1024) / 1024.0;
        NSString *MBString = [[[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fM",(imb+fkb)]] autorelease];
        return MBString;
    }
    else if (ikb != 0)
    {
        float fb = (byte - ikb * 1024) / 1024.0;
        NSString *KBString = [[[NSString alloc] initWithString:[NSString stringWithFormat:@"%.2fK",(ikb+fb)]] autorelease];
        return KBString;
    }
    else
    {
        float fbyte = (float)byte;
        NSString *BString = [[[NSString alloc] initWithString:[NSString stringWithFormat:@"%.1fB",fbyte]] autorelease];
        return BString;
    }
    return @"0.0B";
}

@end
