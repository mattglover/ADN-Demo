//
//  ADNPostEntry.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "ADNPostEntry.h"

@implementation ADNPostEntry
@synthesize name = _name;
@synthesize text = _text;
@synthesize username = _username;
@synthesize avatarImageDictionary = _avatarImageDictionary;
@synthesize createdAt = _createdAt;

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (self) {
    _text = [dictionary objectForKey:@"text"];
    NSDictionary *user = [dictionary objectForKey:@"user"];
    _name = [user objectForKey:@"name"];
    _username = [user objectForKey:@"username"];
    _avatarImageDictionary = [user objectForKey:@"avatar_image"];
    
  }
  return self;
}

- (id)initWithName:(NSString *)name text:(NSString *)text username:(NSString *)username imageURL:(NSDictionary *)avatarImageDictionary createdAt:(NSDate *)createdAt {
  self = [super init];
  if (self) {
    _name = name;
    _text = text;
    _username = username;
    _avatarImageDictionary = avatarImageDictionary;
    _createdAt = createdAt;
  }
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Name:%@, Username:%@, Text:%@, Date:%@", self.name, self.username, self.text, self.createdAt];
}

- (NSString *)name {
  // If No "name" is available then present Username
  NSString *name = _name;
  if (!_name) {
    name = self.username;
  }
  
  return name;
}

- (NSString *)avatarURL {
  return [self.avatarImageDictionary objectForKey:@"url"];
}

@end
