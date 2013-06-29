//
//  LeftMenuViewController.m
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"

static NSString *menuTitles[] = {@"随便看看", @"精华", @"有图有真相", @"穿越", @"设置"};


@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view addBackgroundColor:@"left_menu_bg"];
        
        [self.view addSubview:self.tableView];

    }
    return self;
}

- (void) dealloc
{
    [adView removeFromSuperview];
    adView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //创建广告 banner
    if (adView == nil) {
        adView = [AdSageView requestAdSageBannerAdView:self sizeType:AdSageBannerAdViewSize_320X50]; //设置广告显示位置
        adView.frame = CGRectMake(0, self.view.height - 50, 320, 50); //显示广告
    }
    [self.view addSubview:adView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.height)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = CLEAR_COLOR;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SideMenuCell";
    LeftMenuCell *cell = (LeftMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = menuTitles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 33;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 33)];
    [headerView addBackgroundColor:@"left_menu_head_bg"];
        
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMenuCellHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //[[AppDelegate sharedAppDelegate] switchMenu:indexPath.row animated:YES exData:nil];
    
}

#pragma mark - AdSageDelegate
- (UIViewController *) viewControllerForPresentingModalView
{
    return self; //[AppDelegate sharedAppDelegate].menuController;
}

- (void) adSageDidReceiveBannerAd:(AdSageView *)adSageView
{
}

- (void) adSageDidFailToReceiveBannerAd:(AdSageView *)adSageView
{
    ERRORLOG(@"-- LeftMenu -- adSageDidFailToReceiveBannerAd");
}

@end
