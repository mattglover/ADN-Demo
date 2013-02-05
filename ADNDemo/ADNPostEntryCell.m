//
//  ADNPostEntryCell.m
//  ADNDemo
//
//  Created by Matt Glover on 05/02/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "ADNPostEntryCell.h"
#import "ADNPostEntry.h"

#define NAME_LABEL_X 80.0f
#define NAME_LABEL_Y 10.0f

@implementation ADNPostEntryCell
@synthesize adnPostEntry = _adnPostEntry;
@synthesize avatarImageView = _avatarImageView;
@synthesize nameLabel = _nameLabel;
@synthesize adnTextLabel = _adnTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
   //   self.statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
   //   [self.contentView addSubview:self.statusImageView];
   //   [self.statusImageView setBackgroundColor:[UIColor whiteColor]];
      
      _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_LABEL_X, NAME_LABEL_Y, self.contentView.bounds.size.width - NAME_LABEL_X , 20)];
      [_nameLabel setTextColor:[UIColor darkTextColor]];
      [_nameLabel setBackgroundColor:[UIColor clearColor]];
      [_nameLabel setShadowColor:[UIColor whiteColor]];
      [_nameLabel setShadowOffset:CGSizeMake(0, 1)];
      [_nameLabel setTextAlignment:UITextAlignmentLeft];
      [_nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
      [_adnTextLabel setMinimumFontSize:14.0f];
      [self.contentView addSubview:_nameLabel];
 
      _adnTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 0, 0)];
      [_adnTextLabel setNumberOfLines:0];
      [_adnTextLabel setLineBreakMode:NSLineBreakByWordWrapping];
      [_adnTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
      [_adnTextLabel setMinimumFontSize:14.0f];
      [_adnTextLabel setBackgroundColor:[UIColor clearColor]];
      [self.contentView addSubview:_adnTextLabel];
    
    }
    return self;
}

- (void)setADNPostEntry:(ADNPostEntry *)postEntry textLabel:(UILabel *)textLabel {
  
  _adnPostEntry = postEntry;

  [self.adnTextLabel setFrame:CGRectMake(80, 30, textLabel.bounds.size.width, textLabel.bounds.size.height)];
  self.adnTextLabel.text = textLabel.text;
  
  [self.nameLabel setText:postEntry.name];
}

-(void)prepareForReuse {
  [self.nameLabel setText:@""];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
