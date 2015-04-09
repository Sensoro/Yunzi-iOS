//
//  HomeViewController.m
//  yunzi
//
//  Created by 回特 on 14-10-13.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "HomeViewController.h"
#import "YunziGridCell.h"
#import "YunziViewController.h"

@interface HomeViewController ()<SBKBeaconManagerDelegate,UISearchBarDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =  NSLocalizedString(@"Yunzi", @"");
    
    
    self.navigationItem.titleView = [TitleView setTitleLabel:NSLocalizedString(@"Yunzi", @"")];
    [SBKBeaconManager sharedInstance].delegate = self;
    [self configSearchBar];
    [self configRightButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!self.dataArray)
    {
        [self refresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = UIColorFromRGB(0x222222);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColorFromRGB(0x222222);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = UIColorFromRGB(0x222222);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.tableView];
    
}

- (void)refresh
{
    self.dataArray = [NSMutableArray array];
    NSArray * array =  [[SBKBeaconManager sharedInstance] beaconsInRange];
    for (SBKBeacon * beacon in array) {
        [self.dataArray addObject:beacon];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return ceil(self.dataArray.count / (CGFloat)3);
    }
    else{
        return ceil(self.filteredArray.count / (CGFloat)3);
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        static NSString *CellIdentifier = @"YunziGridCell";
        YunziGridCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[YunziGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.tapBlock = ^(SBKBeacon *beacon) {
                YunziViewController * VC = [[YunziViewController alloc]init];
                VC.beacon = beacon;
                [self.navigationController pushViewController:VC animated:YES];
            };
        }
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSUInteger offset = indexPath.row * 3;
        for (NSUInteger i = 0; i < 3 && offset < self.dataArray.count; i++) {
            [array addObject:self.dataArray[offset++]];
        }
        cell.dataArray = array;
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"YunziGridCellForSearch";
        YunziGridCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[YunziGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.tapBlock = ^(SBKBeacon *beacon) {
                YunziViewController * VC = [[YunziViewController alloc]init];
                VC.beacon = beacon;
                [self.navigationController pushViewController:VC animated:YES];
            };
        }
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSUInteger offset = indexPath.row * 3;
        for (NSUInteger i = 0; i < 3 && offset < self.filteredArray.count; i++) {
            [array addObject:self.filteredArray[offset++]];
        }
        cell.dataArray = array;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YunziGridCell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - SBKBeaconManagerDelegate

- (void)beaconManager:(SBKBeaconManager *)beaconManager didRangeNewBeacon:(SBKBeacon *)beacon{
    
    if(!beacon.serialNumber)
    {
        return;
    }
    [self.dataArray addObject:beacon];
    [self.tableView reloadData];
    
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager beaconDidGone:(SBKBeacon *)beacon{
    
    if(!beacon.serialNumber)
    {
        return;
    }
    [self.dataArray removeObject:beacon];
    [self.tableView reloadData];
    
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager scanDidFinishWithBeacons:(NSArray *)beacons{

}

- (void)beaconManager:(SBKBeaconManager *)beaconManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

}

- (void)beaconManager:(SBKBeaconManager *)beaconManager didDetermineState:(SBKRegionState) state forRegion:(SBKBeaconID*) region
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    switch (state) {
        case SBKRegionStateEnter:
        {
            NSString * message = [NSString stringWithFormat:@"\U0001F603 进入:%@",region];
            notification.alertBody = message;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
            break;
        case SBKRegionStateLeave:
        {
            NSString * message = [NSString stringWithFormat:@"\U0001F603 离开:%@",region];
            notification.alertBody = message;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
            break;
        case SBKRegionStateUnknown:
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark - ConfigSearchBar
- (void)configSearchBar
{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,-kScreenHeight, kScreenWidth, kScreenHeight)];
    view.backgroundColor = UIColorFromRGB(0x222222);
    [self.tableView addSubview:view];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, -200.0f, 320.0f, 44.0f)];
    self.searchBar.tintColor = UIColorFromRGB(0x666666);

    [self.searchBar setBackgroundImage:[[UIImage imageWithColor:UIColorFromRGB(0x222222) andSize:CGSizeMake(10, 32)] stretchableImageWithLeftCapWidth:5 topCapHeight:5]  forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.searchBar.searchTextPositionAdjustment = UIOffsetMake(8.f, 0.f);
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.showsSearchResultsButton = NO;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = NSLocalizedString(@"Search-Tips", @"");
    self.tableView.tableHeaderView = _searchBar;
    
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    self.searchDC.searchResultsDataSource = self;
    self.searchDC.searchResultsDelegate = self;
    self.searchDC.searchResultsTableView.backgroundColor = UIColorFromRGB(0x222222);
    self.searchDC.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDC.searchResultsTableView.separatorColor = UIColorFromRGB(0xffffff);

}

- (void)configRightButton
{
    NSMutableArray * array = [NSMutableArray array];
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(6, 0, 0, 0)];
        [button setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateSelected];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateHighlighted];
        [button setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateSelected|UIControlStateHighlighted];
        [button addTarget:self action:@selector(goForMoreInfo) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString fontAwesomeIconStringForEnum:FAInfoCircle] forState:UIControlStateNormal];
        [array addObject:[[UIBarButtonItem alloc]initWithCustomView:button]];
    }
    
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(6, 0, 0, 0)];
        [button setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateSelected];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateHighlighted];
        [button setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateSelected|UIControlStateHighlighted];
        [button addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString fontAwesomeIconStringForEnum:FARefresh] forState:UIControlStateNormal];
        [array addObject:[[UIBarButtonItem alloc]initWithCustomView:button]];
    }
    
    self.navigationItem.rightBarButtonItems = array;
}

- (void)goForMoreInfo
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://sensoro.com"]];
}

#pragma mark - SearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText length] == 0) {
        return;
    }
    
    self.filteredArray = [NSMutableArray array];
    
    for (SBKBeacon * beacon in [[SBKBeaconManager sharedInstance] beaconsInRange]) {
        /*
        if(!beacon.serialNumber)
        {
            continue;
        }
        */
        NSString * string = [NSString stringWithFormat:@"%@%04X-%04X",beacon.serialNumber,[beacon.beaconID.major unsignedShortValue],[beacon.beaconID.minor unsignedShortValue]];
        if ([[string lowercaseString] rangeOfString:[searchText lowercaseString]].length) {
            [self.filteredArray addObject:beacon];
        }
    }
    [self.searchDC.searchResultsTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    return;
}


@end
