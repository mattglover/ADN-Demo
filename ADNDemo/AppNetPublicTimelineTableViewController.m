//
//  AppNetPublicTimelineTableViewController.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "AppNetPublicTimelineTableViewController.h"
#import "AppNetPublicTimelineDatasource.h"

@interface AppNetPublicTimelineTableViewController () <UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AppNetPublicTimelineDatasource *appNetPublicTimelineDatasource;
@end

@implementation AppNetPublicTimelineTableViewController
@synthesize tableView = _tableView;
@synthesize appNetPublicTimelineDatasource = _appNetPublicTimelineDatasource;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addButtonPressed:)];
  [self.navigationItem setRightBarButtonItem:addButton];
  
  self.appNetPublicTimelineDatasource = [[AppNetPublicTimelineDatasource alloc] init];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  [self.tableView setDelegate:self];
  [self.tableView setDataSource:self.appNetPublicTimelineDatasource];
  
  [self.view addSubview:self.tableView];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - TableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  // Ask Datasource for the height of this row's Cell
  return [self.appNetPublicTimelineDatasource calculatedHeightForCellAtIndexPath:indexPath];
}

#pragma mark - Navigation Bar Button ACTIONS
- (void)addButtonPressed:(UIBarButtonItem *)sender {
  
  [self.appNetPublicTimelineDatasource downloadLatestData];
  [self.tableView reloadData];
}

@end
