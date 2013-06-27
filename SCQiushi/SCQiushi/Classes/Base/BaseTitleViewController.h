//
//  BaseTitleViewController.h
//  Surwin
//
//  Created by jarry on 13-5-3.
//  Copyright (c) 2013年 jarry. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTitleViewController : BaseViewController

@property (nonatomic, retain)   UIView      *titleView;
@property (nonatomic, retain)   UILabel     *titleLabel;
@property (nonatomic, retain)   UIButton    *leftButton;
@property (nonatomic, retain)   UIButton    *rightButton;

- (IBAction) leftButtonAction:(id)sender;
- (IBAction) rightButtonAction:(id)sender;

@end
