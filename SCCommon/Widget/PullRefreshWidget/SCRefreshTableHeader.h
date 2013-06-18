//
//  SCSRefreshTableHeader.h
//  SCUtility
//
//  Created by Jarry on 8/17/12.
//  Copyright (c) 2012 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SpinnerView.h"

#define kRefreshOffsetY                 60.f
#define kReloadOffsetY                  40.f
#define kRefreshAnimationDuration       .28f

#define CONTENT_TEXT_COLOR              RGBCOLOR(87.0, 108.0, 137.0)
#define CONTENT_BORDER_COLOR            RGBCOLOR(87.0, 108.0, 137.0)


typedef enum 
{
    eTypeNone       = 0,
    eTypeHeader     = 1<<0,
    eTypeHeaderImage= 1<<1,
    eTypeFooter     = 1<<2,
    eTypeFooterImage= 1<<3,
}eViewType;

typedef enum
{
    /*Header enum values*/
	eHeaderRefreshPulling   = 0,
	eHeaderRefreshNormal    = 1<<0,
	eHeaderRefreshLoading   = 1<<1,
    
    /*Footer enum values*/
	eFooterReloadPulling    = 1<<2,
    eFooterReloadNormal     = 1<<3,
    eFooterReloadLoading    = 1<<4,
    eFooterReloadReachEnd   = 1<<5,
    
} eRefreshAndReloadState;

@interface SCRefreshTableHeader : UIView

@property(nonatomic,assign) eRefreshAndReloadState state;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
//@property (nonatomic, retain) SpinnerView   *spinner;
@property (nonatomic, assign) eViewType     viewType;

- (id) initWithFrame:(CGRect) frame type:(eViewType) theType;

- (void)setCurrentDate;

@end