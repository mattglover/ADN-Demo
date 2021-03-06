//
//  AppNetPublicTimelineTableViewController.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "AppNetPublicTimelineTableViewController.h"
#import "AppNetPublicTimelineDatasource.h"
#import "SSPullToRefresh.h"

@interface AppNetPublicTimelineTableViewController () <UITableViewDelegate, SSPullToRefreshViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AppNetPublicTimelineDatasource *appNetPublicTimelineDatasource;
@property (nonatomic, strong) SSPullToRefreshView *pullToRefreshView;
@property (nonatomic, assign, getter = hasInitialLoad) BOOL initialLoad;
@end

@implementation AppNetPublicTimelineTableViewController
@synthesize tableView = _tableView;
@synthesize appNetPublicTimelineDatasource = _appNetPublicTimelineDatasource;
@synthesize pullToRefreshView = _pullToRefreshView;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setTitle:@"Public Timeline"];
  
  self.appNetPublicTimelineDatasource = [[AppNetPublicTimelineDatasource alloc] init];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
  [self.tableView setDelegate:self];
  [self.tableView setDataSource:self.appNetPublicTimelineDatasource];
  [self.view addSubview:self.tableView];
  
  self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableView
                                                                  delegate:self];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
 
  if (![self hasInitialLoad]) {
    self.initialLoad = YES;
    [self.pullToRefreshView startLoadingAndExpand:YES animated:YES];
  }
}

#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  // Ask Datasource for the height of this row's Cell
  return [self.appNetPublicTimelineDatasource calculatedHeightForCellAtIndexPath:indexPath];
}


#pragma mark - PullToRefresh Delegate

- (BOOL)pullToRefreshViewShouldStartLoading:(SSPullToRefreshView *)view {
  return YES;
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
  
  [self.appNetPublicTimelineDatasource downloadLatestDataWithCompletion:^(BOOL success, NSError *error) {
    if (success) {
      [self.pullToRefreshView finishLoading];
    }
    
    if (error) {
      // Present Alert to user
    }
    
  }];
}

- (void)pullToRefreshViewDidFinishLoading:(SSPullToRefreshView *)view {
  [self.tableView reloadData];
}

- (NSDate *)pullToRefreshViewLastUpdatedAt:(SSPullToRefreshView *)view {
  return [NSDate date];
}

@end
