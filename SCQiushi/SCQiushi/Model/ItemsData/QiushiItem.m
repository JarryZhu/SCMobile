//
//  QiushiItem.m
//  SCQiushi
//
//  Created by Jarry on 13-7-1.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "QiushiItem.h"

@implementation QiushiItem

- (void) parseItemData:(NSDictionary *)dictionary
{
    self.tag = [dictionary objectForKey:@"tag"];
    self.qiushiID = [dictionary objectForKey:@"id"];
    self.content = [dictionary objectForKey:@"content"];
    self.published_at = [[dictionary objectForKey:@"published_at"] doubleValue];
    self.commentsCount = [[dictionary objectForKey:@"comments_count"] intValue];

    id image = [dictionary objectForKey:@"image"];
    if ((NSNull *)image != [NSNull null])
    {
        self.imageURL = [dictionary objectForKey:@"image"];
        
        NSString *newImageURL = [NSString stringWithFormat:@"http://img.qiushibaike.com/system/pictures/%@/small/%@",self.qiushiID,self.imageURL];
        NSString *newImageMidURL = [NSString stringWithFormat:@"http://img.qiushibaike.com/system/pictures/%@/medium/%@",self.qiushiID,self.imageURL];
        self.imageURL = newImageURL;
        self.imageMidURL = newImageMidURL;
    }

    NSDictionary *vote = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"votes"]];
    self.downCount = [[vote objectForKey:@"down"]intValue];
    self.upCount = [[vote objectForKey:@"up"]intValue];

    id user = [dictionary objectForKey:@"user"];
    if ((NSNull *)user != [NSNull null])
    {
        NSDictionary *user = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"user"]];
        self.anchor = [user objectForKey:@"login"];
        id icon = [user objectForKey:@"icon"];
        if ((NSNull *)icon != [NSNull null])
        {
            //self.iconURL =
        }
    }
}

@end
