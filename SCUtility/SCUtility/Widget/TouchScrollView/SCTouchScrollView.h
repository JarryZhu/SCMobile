//
//  SCTouchScrollView.h
//  SCUtility
//
//  Created by Surwin on 13-5-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCScrollViewTouchesDelegate
-( void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *) event whichView:( id)scrollView;
@end

@interface SCTouchScrollView : UIScrollView

@property(nonatomic,assign)  id<SCScrollViewTouchesDelegate> touchesdelegate;

@end
