//
//  ChatInteractor.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class BotService;
@class DataAccess;
@class Chat;
@class Person;
@class Bot;
@class Message;
@class Participant;
@class ChatPresenter;
@class ImageService;

@interface ChatInteractor : NSObject

@property (nonatomic, strong) ImageService *imageService;
@property (nonatomic, strong) BotService *botService;
@property (nonatomic, strong) DataAccess *dataAccess;
@property (nonatomic, strong) ChatPresenter *presenter;

- (Chat *)chatByName:(NSString *)name;
- (Person *)personWithName:(NSString *)name;
- (NSArray <Message *> *)messagesForChat:(Chat *)chat;

- (void)joinPerson:(Person *)person toChat:(Chat *)chat;
- (Person *)createPersonWithName:(NSString *)name;
- (Chat *)createChatWithName:(NSString *)name;
- (Bot *)createBotWithName:(NSString *)name chat:(Chat *)chat;
- (Message *)createTextMessage:(NSString *)textMessage fromParticipant:(Participant *)participant inChat:(Chat *)chat;
- (Message *)createImageMessage:(NSData *)imageData fromParticipant:(Participant *)participant inChat:(Chat *)chat;
- (Message *)createGeoLocation:(NSString *)geoLocation fromParticipant:(Participant *)participant inChat:(Chat *)chat;

- (NSData *)rescaleImage:(NSData *)data toSize:(CGSize)size;

@end
