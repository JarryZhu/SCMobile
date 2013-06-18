//
//  SCMessageUtility.m
//  SCUtility
//
//  Created by Surwin on 13-6-3.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCMessageUtility.h"
#import "SVProgressHUD.h"

@implementation SCMessageUtility

+ (SCMessageUtility *) instance
{
    static dispatch_once_t  onceToken;
    static SCMessageUtility * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SCMessageUtility alloc] init];
    });
    return sharedInstance;
}

+ (void) showSMSMessageView:(UIViewController *)controller
                 recipients:(NSArray *)recipients
                    smsBody:(NSString *)body
{
    [[SCMessageUtility instance] showSMSMessageView:controller recipients:recipients smsBody:body];
}

+ (void) showSMSMessageView:(UIViewController *)controller
                    toPhone:(NSString *)phone
                    smsBody:(NSString *)body
{
    [[SCMessageUtility instance] showSMSMessageView:controller
                                         recipients:[NSArray arrayWithObject:phone]
                                            smsBody:body];
}

+ (void) showEMailMessageView:(UIViewController *)controller
                      subject:(NSString *)subject
                   recipients:(NSArray *)toRecipients
                         body:(NSString *)body
{
    [[SCMessageUtility instance] showEMailMessageView:controller subject:subject recipients:toRecipients body:body];
}


#pragma mark - internal Methods

- (void) showSMSMessageView:(UIViewController *)controller
                 recipients:(NSArray *)recipients
                    smsBody:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * messagePicker = [[MFMessageComposeViewController alloc] init];
        messagePicker.navigationBar.tintColor = CLEAR_COLOR;
        messagePicker.recipients = recipients;
        messagePicker.body = body;
        messagePicker.messageComposeDelegate = self;
        
        [controller presentModalViewController:messagePicker animated:YES];
        //        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"SomethingElse"];//修改短信界面标题
        [messagePicker release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
}

- (void) showEMailMessageView:(UIViewController *)controller
                      subject:(NSString *)subject
                   recipients:(NSArray *)toRecipients
                         body:(NSString *)body
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
            mailPicker.navigationBar.tintColor = CLEAR_COLOR;
            mailPicker.mailComposeDelegate = self;
            //设置主题
            [mailPicker setSubject:subject];
            //添加接收者
            [mailPicker setToRecipients:toRecipients];
            //添加内容
            [mailPicker setMessageBody:body isHTML:YES];
            
            [controller presentModalViewController:mailPicker animated:YES];
            [mailPicker release];
        }
        else {
            [self launchMailAppOnDevice:subject recipients:toRecipients body:body];
        }
    }
    else {
        [self launchMailAppOnDevice:subject recipients:toRecipients body:body];
    }
}

- (void) launchMailAppOnDevice:(NSString *)subject
                    recipients:(NSArray *)toRecipients
                          body:(NSString *)body
{    
    NSString *email = [NSString stringWithFormat:@"mailto:%@&subject=%@&body=%@", [toRecipients objectAtIndex:0], subject, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

#pragma mark - MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate
- (void) messageComposeViewController:(MFMessageComposeViewController *)controller
                  didFinishWithResult:(MessageComposeResult)result
{
    switch ( result ) {
        case MessageComposeResultCancelled:
        {
            [SVProgressHUD showInfoWithStatus:@"已取消"];
        }
            break;
            
        case MessageComposeResultFailed:// send failed
        {
            [SVProgressHUD showErrorWithStatus:@"短信发送失败！"];
        }
            break;
            
        case MessageComposeResultSent:
        {
            [SVProgressHUD showSuccessWithStatus:@"短信发送成功！"];
        }
            break;
            
        default:
            break;
    }
    
    [controller dismissModalViewControllerAnimated:YES];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            [SVProgressHUD showInfoWithStatus:@"邮件发送取消！"];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [SVProgressHUD showInfoWithStatus:@"邮件保存成功！"];
        }
            break;
        case MFMailComposeResultSent:
        {
            [SVProgressHUD showSuccessWithStatus:@"邮件发送成功！"];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [SVProgressHUD showErrorWithStatus:@"邮件发送失败！"];
        }
            break;
        default:
            break;
    }
    
    [controller dismissModalViewControllerAnimated:YES];
}



@end
