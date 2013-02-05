//
//  ADNHTTPClient.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "ADNHTTPClient.h"
#import "AFJSONRequestOperation.h"

#define BASE_URL @"https://alpha-api.app.net"

@interface ADNHTTPClient ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ADNHTTPClient
@synthesize dateFormatter = _dateFormatter;

+ (ADNHTTPClient *)sharedClient {
  static ADNHTTPClient *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedClient = [[ADNHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
  });
  
  return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  if (self) {
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
  }
  
  self.dateFormatter = [[NSDateFormatter alloc] init];
  [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
  
  return self;
}

#pragma mark - Download Methods
- (void)downloadADNPublicTimelineWithCompletion:(HTTPClientRequestCompletionHandler)completion {
  
  NSString *path = @"/stream/0/posts/stream/global";
  
  [self getPath:path
     parameters:nil
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
          NSArray *adnPostDictionarys = [responseDictionary objectForKey:@"data"];
          
          // Cycle through each adnPostDictionary and create ADNPost object
          NSMutableArray *adnPosts = [[NSMutableArray alloc] initWithCapacity:[adnPostDictionarys count]];
          for (NSDictionary *adnPostDictionary in adnPostDictionarys) {
            
          }
          
          completion(adnPosts, nil);
          
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          completion(nil, error);
        }];
}

@end
