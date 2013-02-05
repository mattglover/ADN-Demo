//
//  AppNetPublicTimelineDatasource.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "AppNetPublicTimelineDatasource.h"

@interface AppNetPublicTimelineDatasource()
@property (nonatomic, strong) NSArray *posts;
@end

@implementation AppNetPublicTimelineDatasource
@synthesize posts = _posts;

- (id)init {
  self = [super init];
  
  if (self) {
    self.posts = @[@"Hello ... 1", @"Hello ... 2", @"Hello ... 3", @"Hello ... 4"];
  }
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
  
  [cell.textLabel setText:[self.posts objectAtIndex:indexPath.row]];
  
  return cell;
}

- (void)downloadLatestDataWithCompletion:(DownloadDataCompletionHandler)completion {
  
  NSMutableArray *mutablePosts = [self.posts mutableCopy];
  NSString *dummyPost = [NSString stringWithFormat:@"Hello ... %d", [self.posts count] + 1];
  [mutablePosts addObject:dummyPost];
  
  self.posts = mutablePosts;
  
  completion(YES, nil);
}

- (CGFloat)calculatedHeightForCellAtIndexPath:(NSIndexPath *)indexPath {
  
  CGFloat cellHeight = 100.0f;
  
  switch (indexPath.row) {
    case 2:
      cellHeight = 40;
      break;
      
    default:
      break;
  }
  
  return cellHeight;
}

@end