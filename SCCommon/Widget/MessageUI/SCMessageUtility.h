//
//  SCMessageUtility.h
//  SCUtility
//
//  Created by Surwin on 13-6-3.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <MessageUI/MessageUI.h>

/**
 *  MessageUI 调用短信和邮件 封装
 *
 *  Link：MessageUI.framework
 *
 **/
@interface SCMessageUtility : NSObject <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

+ (SCMessageUtility *) instance;


/**
 *  调用短信发送
 */
+ (void) showSMSMessageView:(UIViewController *)controller
                 recipients:(NSArray *)recipients
                    smsBody:(NSString *)body;

+ (void) showSMSMessageView:(UIViewController *)controller
                    toPhone:(NSString *)phone
                    smsBody:(NSString *)body;

/**
 *  调用邮件发送
 */
+ (void) showEMailMessageView:(UIViewController *)controller
                      subject:(NSString *)subject
                   recipients:(NSArray *)toRecipients
                         body:(NSString *)body;

@end
