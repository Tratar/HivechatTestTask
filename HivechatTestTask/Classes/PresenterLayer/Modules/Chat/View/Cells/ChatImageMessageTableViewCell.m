//
//  ChatImageMessageTableViewCell.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "ChatImageMessageTableViewCell.h"

#import "Message+CoreDataClass.h"
#import "Participant+CoreDataClass.h"

@interface ChatImageMessageTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leadingImageConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *trailingImageConstraint;

@end

@implementation ChatImageMessageTableViewCell

- (void)awakeFromNib {
    self.messageImageView.layer.cornerRadius = 10.0;
    self.messageImageView.layer.masksToBounds = YES;
 
    [super awakeFromNib];
}

- (void)configureWithMessage:(Message *)message sentByCurrentUser:(BOOL)sentByCurrentUser {
    UIImage *image = [UIImage imageWithData:message.bodyPicture];
    self.messageImageView.image = image;
    
    if (sentByCurrentUser) {
        self.senderNameLabel.text = @"Me";
        self.senderNameLabel.textAlignment = NSTextAlignmentRight;
        
        self.leadingImageConstraint.active = NO;
        self.trailingImageConstraint.active = YES;
    } else {
        self.senderNameLabel.text = message.sender.name;
        self.senderNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.trailingImageConstraint.active = NO;
        self.leadingImageConstraint.active = YES;
    }
}

@end
