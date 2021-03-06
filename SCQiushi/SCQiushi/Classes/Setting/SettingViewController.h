//
//  SettingViewController.h
//  SCQiushi
//
//  Created by Surwin on 13-7-5.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "BaseTitleViewController.h"

@interface SettingViewController : BaseTitleViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property   (nonatomic, strong)     UITableView *tableView;

@property   (nonatomic, strong)     UILabel     *copyRightLabel;

@property   (nonatomic, copy)       NSString    *memorySize;

@end
