//
//  ChatPresenterState.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 14/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;
@class Chat;
@class Person;

@interface ChatPresenterState : NSObject

@property (nonatomic, strong) Person *currentPerson;
@property (nonatomic, strong) NSMutableArray<Message *> *messages;
@property (nonatomic, strong) Chat *chat;

@end
