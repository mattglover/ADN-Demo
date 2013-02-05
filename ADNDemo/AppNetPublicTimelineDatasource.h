//
//  AppNetPublicTimelineDatasource.h
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadDataCompletionHandler)(BOOL success, NSError *error);

@interface AppNetPublicTimelineDatasource : NSObject <UITableViewDataSource>

- (void)downloadLatestDataWithCompletion:(DownloadDataCompletionHandler)completion;
- (CGFloat)calculatedHeightForCellAtIndexPath:(NSIndexPath *)indexPath;

@end
