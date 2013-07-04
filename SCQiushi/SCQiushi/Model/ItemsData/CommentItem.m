//
//  CommentItem.m
//  SCQiushi
//
//  Created by Surwin on 13-7-4.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem

- (void) parseItemData:(NSDictionary *)dictionary
{
    self.commentID = [dictionary objectForKey:@"id"];
    self.content = [dictionary objectForKey:@"content"];
    self.floorNum = [[dictionary objectForKey:@"floor"] integerValue];

    id user = [dictionary objectForKey:@"user"];
    if ((NSNull *)user != [NSNull null])
    {
        NSDictionary *user = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"user"]];
        self.anchor = [user objectForKey:@"login"];
        NSString *uId = [user objectForKey:@"id"];
        id icon = [user objectForKey:@"icon"];
        if ((NSNull *)icon != [NSNull null])
        {
            self.iconURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/avtnew/%@/%@/thumb/%@", kIntToString(uId.intValue/10000), uId, [user objectForKey:@"icon"]];
            WARNLOG(@"-- %@", self.iconURL);
        }
    }
}

@end
