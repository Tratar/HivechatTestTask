//
//  ChatGeoLocationMessageTableViewCell.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Message;

@interface ChatGeoLocationMessageTableViewCell : UITableViewCell

- (void)configureWithMessage:(Message *)message sentByCurrentUser:(BOOL)sentByCurrentUser;

@end
