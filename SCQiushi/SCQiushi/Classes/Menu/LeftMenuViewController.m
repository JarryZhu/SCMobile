//
//  LeftMenuViewController.m
//  SCQiushi
//
//  Created by Jarry on 13-6-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"
#import "AppDelegate.h"

static NSString *menuTitles[] = {@"谁能有我糗", @"精华连连看", @"有图有真相", @"穿越更精彩", @"我的收藏", @"精品应用", @"我的设置"};


@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self.view addBackgroundColor:@"left_menu_bg"];
        self.view.backgroundColor = CLEAR_COLOR;
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, 320, 37)];
        [titleView addBackgroundStretchableImage:@"left_menu_head_bg" leftCapWidth:0 topCapHeight:0];
        
        UILabel *titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 37)];
        titleLabel.font = FONTNAMEWITHSIZE(@"Helvetica-Oblique", 15); //SYSTEMFONT(15);
        titleLabel.backgroundColor = CLEAR_COLOR;
        titleLabel.textColor = WHITE_COLOR;
        titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        titleLabel.text = [NSString stringWithFormat:@"%@  v%@", @"糗事贴吧", APP_VERSION];
        titleLabel.shadowOffset = CGSizeMake(0.4f, 0.6f);
		titleLabel.shadowColor = BLACK_COLOR;
        [titleView addSubview:titleLabel];
        
        //
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 11, 15, 15)];
        iconImage.image = [UIImage imageNamed:@"icon"];
        iconImage.layer.masksToBounds = YES;
        iconImage.layer.cornerRadius = 2.0;
        //[titleView addSubview:iconImage];
        
        [self.view addSubview:titleView];
        
        [self.view addSubview:self.tableView];

    }
    return self;
}

- (void) dealloc
{
    //[adView removeFromSuperview];
    //adView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //创建广告 banner
    /*if (adView == nil) {
        adView = [AdSageView requestAdSageBannerAdView:self sizeType:AdSageBannerAdViewSize_320X50]; //设置广告显示位置
        adView.frame = CGRectMake(0, self.view.height - 50, 320, 50); //显示广告
    }
    [self.view addSubview:adView];*/

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, 320.0f, self.view.height-43.0f)
                                                  style:UITableViewStylePlain];
        [_tableView addBackgroundColor:@"left_menu_bg"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = CLEAR_COLOR;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

static int numbers[] = {4, 3};

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numbers[section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SideMenuCell";
    LeftMenuCell *cell = (LeftMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = menuTitles[indexPath.section*4+indexPath.row];
    
    if (indexPath.section == 0) {
        [cell setChecked:(selectIndex==indexPath.row)];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return (section==1) ? 20 : 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 20)];
        //[headerView addBackgroundColor:@"left_menu_head_bg"];
        [headerView addBackgroundStretchableImage:@"left_menu_head_bg" leftCapWidth:0 topCapHeight:0];
        
        return  headerView;
    }
        
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMenuCellHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [[AppDelegate sharedAppDelegate] switchMenu:indexPath.row animated:YES exData:menuTitles[indexPath.row]];
        //
        selectIndex = indexPath.row;
        [tableView reloadData];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            //[recmdView OpenAdSageRecmdModalView];
        }
        [[AppDelegate sharedAppDelegate] switchMenu:4+indexPath.row animated:YES exData:nil];
    }
    
}

/*
#pragma mark - AdSageDelegate
- (UIViewController *) viewControllerForPresentingModalView
{
    return [AppDelegate sharedAppDelegate].menuController;
}

- (void) adSageDidReceiveBannerAd:(AdSageView *)adSageView
{
}

- (void) adSageDidFailToReceiveBannerAd:(AdSageView *)adSageView
{
    ERRORLOG(@"-- LeftMenu -- adSageDidFailToReceiveBannerAd");
}
*/



@end
