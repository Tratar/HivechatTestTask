//
//  ChatViewController.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatPresenter;
@class Message;
@class Chat;
@class Person;

@interface ChatViewController : UIViewController

@property (nonatomic, weak) ChatPresenter *presenter;

#pragma mark Presenter Output.

- (void)newMessage:(Message *)message;
- (void)showChat:(Chat *)chat withMessages:(NSArray <Message *>*)messages forPerson:(Person *)person;

@end
