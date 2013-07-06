//
//  SettingViewController.m
//  SCQiushi
//
//  Created by Surwin on 13-7-5.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SettingViewController.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view addBackgroundColor:@"main_background"];
    self.title = @"设 置 ";
    self.memorySize = @"0.0B";
    
    [self.leftButton setHidden:YES];
    [self.rightButton setNormalImage:@"top_btn_close" selectedImage:nil];
    [self.rightButton setShowsTouchWhenHighlighted:YES];
    [self.titleView addSubview:self.rightButton];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.copyRightLabel];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        self.memorySize = [[[SDImageCache sharedImageCache] getSizeNumber] byteKMGBString];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [self.tableView reloadData];
        });
    });
}

- (IBAction) rightButtonAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)switchChanged:(UISwitch *)sender
{
    /*if (sender.tag == 0) {
        if ([[SinaWeiboUtility sharedInstance] isAuthValid]) {
            // 新浪微博解除绑定
            [[SinaWeiboUtility sharedInstance] logOut];
            //[sender setOn:NO animated:YES];
        }
        else {
            // 新浪微博授权绑定
            [[SinaWeiboUtility sharedInstance] doLogin:^(id content1, id content2)
             {
                 [SVProgressHUD dismiss];
                 
             } cancel:^(id content) {
                 [sender setOn:NO animated:YES];
             } failed:^(id content) {
                 [sender setOn:NO animated:YES];
             }];
        }
    }
    else if (sender.tag == 1) {
        if ([ShareSDKManager hasAuthorized:ShareTypeTencentWeibo]) {
            [ShareSDKManager doLogout:ShareTypeTencentWeibo];
        }
        else {
            [ShareSDKManager doLoginWithType:ShareTypeTencentWeibo
                                   compelete:^(id content)
             {
                 
             } failed:^(id content) {
                 [sender setOn:NO animated:YES];
             }];
        }
    }*/
}

#pragma mark - Views Init

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CONTENT_FRAME
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CLEAR_COLOR;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundView = nil;
    }
    return _tableView;
}

- (UILabel *) copyRightLabel
{
    if (!_copyRightLabel) {
        _copyRightLabel = [[UILabel alloc] init];
        _copyRightLabel.frame = CGRectMake(0, 345+kIPhone5Increase/2, 320, 45);
        _copyRightLabel.font = ARIALFONTSIZE(12);
        _copyRightLabel.backgroundColor = CLEAR_COLOR;
        _copyRightLabel.textColor = GRAY_COLOR;
        _copyRightLabel.textAlignment = UITextAlignmentCenter;
        _copyRightLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _copyRightLabel.text = @"v 1.0.0\nCopyright © 2013 Jarry. All Rights Reserved.\n糗事版权归糗事百科网站所有";
        _copyRightLabel.numberOfLines = 0;
        
        _copyRightLabel.shadowOffset = CGSizeMake(0.4f, 0.8f);
        _copyRightLabel.shadowColor = WHITE_COLOR;
    }
    
    return _copyRightLabel;
}

#pragma mark - UITableViewDataSource

static NSString *sectionTitles[] = {@"帐号绑定", @"其他", nil};
static NSString *cellTexts1[] = {@"新浪微博", @"腾讯微博"};
static NSString *cellTexts2[] = {@"清除缓存", @"去AppStore评价我们"};
//static NSString *cellIcons1[] = {@"icon_sina", @"icon_tx"};
static int numbers[] = {2, 2};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionTitles[section];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numbers[section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *UserCellIdentifier = @"UserCellIdentifier";
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:(indexPath.section==0 && indexPath.row==0) ? UserCellIdentifier : CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                        reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.font = ARIALFONTSIZE(15);
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.textColor = DARKGRAY_COLOR;
        cell.textLabel.font = BOLDSYSTEMFONT(16);
    }
    
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = cellTexts1[indexPath.row];
        
        UISwitch *switchControl = [[UISwitch alloc] init];
        switchControl.onTintColor = RGBCOLOR(0xAA, 0x80, 0x41);
        [switchControl addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        switchControl.tag = indexPath.row;
        if (indexPath.row == 0) {
            //switchControl.on = [[SinaWeiboUtility sharedInstance] isAuthValid];
        }
        else if (indexPath.row == 1) {
            //switchControl.on = [ShareSDKManager hasAuthorized:ShareTypeTencentWeibo];
        }
        cell.accessoryView = switchControl;
    }
    else if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.text = cellTexts2[indexPath.row];
        cell.accessoryView = nil;
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.memorySize;
        }
        else {
            cell.detailTextLabel.text = @"";
        }
    }
    
    /*if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = [[UserInfoManager getUserInfo] nickName];
            [cell.imageView setImageWithURL:[NSURL URLWithString:[UserDefaultsManager userIcon]]
                           placeholderImage:IMAGENAMED(kImageDefaultHead)
                                    success:nil failure:nil];
            cell.detailTextLabel.text = @"点击修改个人头像";
        }
        else {
            cell.textLabel.text = @"个人资料修改";
        }
    }
    
    else if (indexPath.section == 1) {
        cell.imageView.image = IMAGENAMED(cellIcons1[indexPath.row]);
        cell.textLabel.text = cellTexts1[indexPath.row];
        
        UISwitch *switchControl = [[[UISwitch alloc] init] autorelease];
        //        switchControl.onTintColor = COLOR_MENU_BG;
        [switchControl addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        switchControl.tag = indexPath.row;
        if (indexPath.row == 0) {
            switchControl.on = [[SinaWeiboUtility sharedInstance] isAuthValid];
        }
        else if (indexPath.row == 1) {
            switchControl.on = [ShareSDKManager hasAuthorized:ShareTypeTencentWeibo];
        }
        cell.accessoryView = switchControl;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    else if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = cellTexts2[indexPath.row];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.memorySize;
        }
    }
    
    else if (indexPath.section == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"注销帐号";
    }*/
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case eTableViewRowIndex00:  //清除缓存
            {
                [SVProgressHUD showWithStatus:@"清理缓存中..."];
                __block SettingViewController *blockSelf = self;
                dispatch_queue_t new_queue = dispatch_queue_create("Clean_Cache", nil);
                dispatch_async(new_queue , ^ {
                    [[SDImageCache sharedImageCache] clearMemory];
                    [[SDImageCache sharedImageCache] clearDisk];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showSuccessWithStatus:@"已成功清理缓存！"];
                        blockSelf.memorySize = [[[SDImageCache sharedImageCache] getSizeNumber] byteKMGBString];
                        [blockSelf.tableView reloadData];
                    });
                });
                dispatch_release(new_queue);
            }
                break;
                
            case eTableViewRowIndex01:
            {
                
            }
                break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
