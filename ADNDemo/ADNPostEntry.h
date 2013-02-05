//
//  ADNPostEntry.h
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADNPostEntry : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSDictionary *avatarImageDictionary;
@property (nonatomic, strong) NSDate *createdAt;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithName:(NSString *)name text:(NSString *)text username:(NSString *)username imageURL:(NSDictionary *)avatarImageDictionary createdAt:(NSDate *)createdAt;

@end
