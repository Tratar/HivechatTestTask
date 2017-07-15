//
//  DataAccess.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Chat;
@class Participant;
@class Message;
@class Person;
@class Bot;

@interface DataAccess : NSObject

- (void)configure;

- (Chat *)chatByName:(NSString *)name;
- (Person *)personByName:(NSString *)name;
- (Message *)retakeMessage:(Message *)message;
- (NSArray <Message *> *)messagesForChat:(Chat *)chat;

- (Message *)createTextMessage:(NSString *)textMessage imageData:(NSData *)imageData geoLocation:(NSString *)geoLocation sentOn:(NSDate *)sentOn fromParticipant:(Participant *)participant inChat:(Chat *)chat;
- (Chat *)createChatWithName:(NSString *)name;
- (Bot *)createBotWithName:(NSString *)name toChat:(Chat *)chat;
- (Person *)createPersonWithName:(NSString *)name;
- (void)joinPerson:(Person *)person toChat:(Chat *)chat;

- (void)performBlockOnPrivateContextQueue:(void (^)())block;

@end
