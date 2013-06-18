//
//  ImagePickerUtility.m
//  Surwin
//
//  Created by Surwin on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "ImagePickerUtility.h"

@interface ImagePickerUtility () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property   (nonatomic, assign)     UIViewController    *parentController;
@property   (nonatomic, copy)       idBlock             block;

@end

@implementation ImagePickerUtility

+ (ImagePickerUtility *) instance
{
    static dispatch_once_t  onceToken;
    static ImagePickerUtility * instance;
    dispatch_once(&onceToken, ^{
        instance = [[ImagePickerUtility alloc] init];
    });
    return instance;
}

- (void) showActionSheet:(UIViewController *)controller title:(NSString *)title block:(idBlock)block
{
    self.parentController = controller;
    self.block = block;
    
    UIActionSheet *actionSheet = nil;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[[UIActionSheet alloc] initWithTitle:title
                                                   delegate:self
                                          cancelButtonTitle:kCancelString
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:kChooseFromAlbumsString,nil] autorelease];
    }
    else
    {
        actionSheet = [[[UIActionSheet alloc] initWithTitle:title
                                                   delegate:self
                                          cancelButtonTitle:kCancelString
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:kChooseFromCameraString,kChooseFromAlbumsString, nil] autorelease];
    }
    
    [actionSheet showInView:controller.view];
}

- (void) startCamera:(UIViewController *)controller block:(idBlock)block
{
    if (block) {
        self.block = block;
    }
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imageController = [[[UIImagePickerController alloc] init] autorelease];
        imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imageController.delegate = self;
        imageController.allowsEditing = YES;
        [controller presentModalViewController:imageController animated:YES];
    }
}

- (void) showPhotosAlbum:(UIViewController *)controller block:(idBlock)block
{
    if (block) {
        self.block = block;
    }
    UIImagePickerController *imageController = [[[UIImagePickerController alloc] init] autorelease];
    imageController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imageController.delegate = self;
    imageController.allowsEditing = YES;
    [controller presentModalViewController:imageController animated:YES];
}

- (void) dealloc
{
    self.block = nil;
    [super dealloc];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            [self showPhotosAlbum:self.parentController block:nil];
        }
            break;
            
        case 0:
        {
            [self startCamera:self.parentController block:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获得编辑过的图片
    UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    if (image) {
        if (self.block) {
            self.block(image);
        }
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

@end
