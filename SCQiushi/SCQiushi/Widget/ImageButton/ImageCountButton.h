//
//  ImageCountButton.h
//  Surwin
//
//  Created by Jarry on 13-5-14.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义 图片＋数字 的按钮
 */
@interface ImageCountButton : UIButton

@property (nonatomic, assign)   CGSize  imageSize;

- (void) setText:(NSString *)text;

@end
