//
//  LeftMenuViewController.h
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "AdSageDelegate.h"
#import "AdSageView.h"

@interface LeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AdSageDelegate>
{
    AdSageView * adView;
}

@property   (nonatomic, retain)     UITableView     *tableView;

@end
