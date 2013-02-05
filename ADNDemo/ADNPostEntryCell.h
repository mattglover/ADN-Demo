//
//  ADNPostEntryCell.h
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADNPostEntry;
@interface ADNPostEntryCell : UITableViewCell

@property (nonatomic, strong) ADNPostEntry *adnPostEntry;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *adnTextLabel; // Cannot use textLabel

- (void)setADNPostEntry:(ADNPostEntry *)postEntry textLabel:(UILabel *)textLabel;

@end
