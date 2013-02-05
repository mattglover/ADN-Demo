//
//  AppNetPublicTimelineDatasource.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "AppNetPublicTimelineDatasource.h"
#import "ADNHTTPClient.h"
#import "ADNPostEntry.h"
#import "ADNPostEntryCell.h"

#define TEXT_LABEL_MAX_WIDTH 230.0f // Want to allow space for VericalScroller (previously 240.0f
#define CELL_MINIMUM_HEIGHT 100.0f // Image might be bigger than Name and ADN Text

@interface AppNetPublicTimelineDatasource()
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSMutableArray *textLabels;
@end

@implementation AppNetPublicTimelineDatasource
@synthesize posts = _posts;
@synthesize textLabels = _textLabels;

- (id)init {
  self = [super init];
  
  if (self) {
    _posts = @[];
    _textLabels = [NSMutableArray array];
  }
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"ADNPostEntryCustomCell";
  
  ADNPostEntryCell *cell = (ADNPostEntryCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil){
		cell = [[ADNPostEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
  
  ADNPostEntry *postEntry = [self.posts objectAtIndex:indexPath.row];
  UILabel *textLabel = [self.textLabels objectAtIndex:indexPath.row];
  [cell setADNPostEntry:postEntry textLabel:textLabel];
  
  return cell;
}

- (void)downloadLatestDataWithCompletion:(DownloadDataCompletionHandler)completion {
  
  ADNHTTPClient *adnHTTPClient = [ADNHTTPClient sharedClient];
  
  [adnHTTPClient downloadADNPublicTimelineWithCompletion:^(id responseObject, NSError *error) {
    if (responseObject) {
      self.posts = responseObject;
      [self populateTextLabels];
      completion(YES, nil);
    } else {
      completion(YES, error);
    }
  }];
}

- (void)populateTextLabels {
  
  [self.textLabels removeAllObjects];
  
  for (ADNPostEntry *postEntry in self.posts) {
    UILabel *adnTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, TEXT_LABEL_MAX_WIDTH, 0)];
    [adnTextLabel setNumberOfLines:0];
    [adnTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [adnTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [adnTextLabel setMinimumFontSize:14.0f];
    [adnTextLabel setBackgroundColor:[UIColor clearColor]];
    [adnTextLabel setText:postEntry.text];
    [adnTextLabel sizeToFit];
    
    CGRect textLabelBounds = adnTextLabel.bounds;
    textLabelBounds.size.width = MAX(textLabelBounds.size.width, TEXT_LABEL_MAX_WIDTH);
    [adnTextLabel setBounds:textLabelBounds];
    
    [self.textLabels addObject:adnTextLabel];
  }
}

- (CGFloat)calculatedHeightForCellAtIndexPath:(NSIndexPath *)indexPath {
  
  UILabel *adnTextLabel = [self.textLabels objectAtIndex:indexPath.row];
  CGFloat calculatedHeight = adnTextLabel.bounds.size.height + adnTextLabel.frame.origin.y + 10; // 10 for some bottom-padding
  return MAX(CELL_MINIMUM_HEIGHT, calculatedHeight);
}

@end