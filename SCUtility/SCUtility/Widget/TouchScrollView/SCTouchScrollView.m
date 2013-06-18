//
//  SCTouchScrollView.m
//  SCUtility
//
//  Created by Surwin on 13-5-25.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCTouchScrollView.h"

@implementation SCTouchScrollView

- ( void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging) {
        // run at ios5 ,no effect;
        [self.nextResponder touchesEnded:touches withEvent:event];
        if (_touchesdelegate!=nil) {
            [_touchesdelegate scrollViewTouchesEnded:touches withEvent:event whichView:self];
        }
        //NSLog( @" UITouchScrollView nextResponder touchesEnded ");
    }
    
    [super touchesEnded:touches withEvent:event]; 
}

@end
