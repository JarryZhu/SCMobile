//
//  ImagePickerUtility.h
//  Surwin
//
//  Created by Surwin on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  拍照 或 照片读取 工具类
 **/
@interface ImagePickerUtility : NSObject

+ (ImagePickerUtility *) instance;

- (void) showActionSheet:(UIViewController *)controller title:(NSString *)title block:(idBlock)block;

- (void) startCamera:(UIViewController *)controller block:(idBlock)block;
- (void) showPhotosAlbum:(UIViewController *)controller block:(idBlock)block;

@end
