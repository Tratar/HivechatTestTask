//
//  ChatTextMessageTableViewCell.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "ChatTextMessageTableViewCell.h"

#import "Message+CoreDataClass.h"
#import "Participant+CoreDataClass.h"

@interface ChatTextMessageTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *textMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leadingTextConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *trailingTextConstraint;

@end

@implementation ChatTextMessageTableViewCell

- (void)awakeFromNib {
    self.textMessageLabel.layer.cornerRadius = 10.0;
    self.textMessageLabel.layer.masksToBounds = YES;
    
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithMessage:(Message *)message sentByCurrentUser:(BOOL)sentByCurrentUser {
    self.textMessageLabel.text = message.bodyText;
    
    if (sentByCurrentUser) {
        self.senderNameLabel.text = @"Me";
        self.senderNameLabel.textAlignment = NSTextAlignmentRight;
        
        self.leadingTextConstraint.active = NO;
        self.trailingTextConstraint.active = YES;
    } else {
        self.senderNameLabel.text = message.sender.name;
        self.senderNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.trailingTextConstraint.active = NO;
        self.leadingTextConstraint.active = YES;
    }
}

@end
