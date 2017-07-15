//
//  ChatInteractor.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "ChatInteractor.h"
#import "DataAccess.h"
#import "BotService.h"
#import "ImageService.h"
#import "ChatPresenter.h"

#import "Message+CoreDataClass.h"
#import "Participant+CoreDataClass.h"
#import "Chat+CoreDataClass.h"
#import "Bot+CoreDataClass.h"
#import "Person+CoreDataClass.h"

@implementation ChatInteractor

#pragma mark Input

- (Chat *)chatByName:(NSString *)name {
    return [self.dataAccess chatByName:name];
}

- (Person *)personWithName:(NSString *)name {
    return [self.dataAccess personByName:name];
}

- (NSArray <Message *> *)messagesForChat:(Chat *)chat {
    return [self.dataAccess messagesForChat:chat];
}

- (void)joinPerson:(Person *)person toChat:(Chat *)chat {
    [self.dataAccess joinPerson:person toChat:chat];
}

- (Person *)createPersonWithName:(NSString *)name {
    return [self.dataAccess createPersonWithName:name];
}

- (Chat *)createChatWithName:(NSString *)name {
    return [self.dataAccess createChatWithName:name];
}

- (Bot *)createBotWithName:(NSString *)name chat:(Chat *)chat {
    return [self.dataAccess createBotWithName:name toChat:chat];
}

- (Message *)createTextMessage:(NSString *)textMessage fromParticipant:(Participant *)participant inChat:(Chat *)chat {
    Message *message = [self.dataAccess createTextMessage:textMessage imageData:nil geoLocation:nil sentOn:[NSDate date] fromParticipant:participant inChat:chat];
    [self notifyBotsForChat:chat aboutMessage:message];
    return message;
}

- (Message *)createImageMessage:(NSData *)imageData fromParticipant:(Participant *)participant inChat:(Chat *)chat {
    Message *message = [self.dataAccess createTextMessage:nil imageData:imageData geoLocation:nil sentOn:[NSDate date] fromParticipant:participant inChat:chat];
    [self notifyBotsForChat:chat aboutMessage:message];
    return message;
}

- (Message *)createGeoLocation:(NSString *)geoLocation fromParticipant:(Participant *)participant inChat:(Chat *)chat {
    Message *message = [self.dataAccess createTextMessage:nil imageData:nil geoLocation:geoLocation sentOn:[NSDate date] fromParticipant:participant inChat:chat];
    [self notifyBotsForChat:chat aboutMessage:message];
    return message;
}

- (NSData *)rescaleImage:(NSData *)data toSize:(CGSize)size {
    return [self.imageService rescaleImage:data toSize:size];
}

#pragma mark Private 

- (void)notifyBotsForChat:(Chat *)chat aboutMessage:(Message *)message {
    Bot *bot = chat.bot;
    typeof(self) __weak weakSelf = self;
    [self.botService bot:bot analyzeMessageAndRespond:message completion:^(Message *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            if (strongSelf && message) {
                Message *retakenMessage = [self.dataAccess retakeMessage:message];
                [self.presenter incomingMessage:retakenMessage];
            }
        });
    }];
}

@end
