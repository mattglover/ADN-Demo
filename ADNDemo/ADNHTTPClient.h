//
//  ADNHTTPClient.h
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void(^HTTPClientRequestCompletionHandler)(id responseObject, NSError *error);

@interface ADNHTTPClient : AFHTTPClient

+ (ADNHTTPClient *)sharedClient;
- (id)initWithBaseURL:(NSURL *)url;

- (void)downloadADNPublicTimelineWithCompletion:(HTTPClientRequestCompletionHandler)completion;

@end
