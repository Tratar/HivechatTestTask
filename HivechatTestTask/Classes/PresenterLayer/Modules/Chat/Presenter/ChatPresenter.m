//
//  ChatPresenter.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "ChatPresenter.h"
#import "ChatPresenterState.h"
#import "ChatInteractor.h"
#import "ChatViewController.h"

#import "Message+CoreDataClass.h"
#import "Person+CoreDataClass.h"
#import "Participant+CoreDataClass.h"
#import "Chat+CoreDataClass.h"
#import "Bot+CoreDataClass.h"

NSString *const ChatName = @"Chat With Bot";
NSString *const ChatBotName = @"Bot";
NSString *const ChatPersonName = @"My Name";

CGFloat resizedSizeWidth = 200.0;
CGFloat resizedSizeHeight = 170.0;

@implementation ChatPresenter

#pragma mark View Output

- (void)loaded {
    Chat *chat = [self.interactor chatByName:ChatName];
    if (!chat) {
        chat = [self.interactor createChatWithName:ChatName];
    }
    
    if (!chat.bot) {
        [self.interactor createBotWithName:ChatBotName chat:chat];
    }
  
    Person *person = [self.interactor personWithName:ChatPersonName];
    if (!person) {
        person = [self.interactor createPersonWithName:ChatPersonName];
        [self.interactor joinPerson:person toChat:chat];
    }
    
    NSMutableArray<Message *> *messages = [[self.interactor messagesForChat:chat] mutableCopy];
    self.state.currentPerson = person;
    self.state.messages = messages;
    self.state.chat = chat;
    [self.view showChat:chat withMessages:messages forPerson:person];
}

- (void)newTextMessage:(NSString *)textMessage {
    if ([textMessage isEqualToString:@""]) {
        return;
    }
    
    Participant *sender = self.state.currentPerson;
    Chat *chat = self.state.chat;
    
    if (!sender || !chat) {
        return;
    }

    Message *message = [self.interactor createTextMessage:textMessage fromParticipant:sender inChat:chat];
    [self postMessage:message];
}

- (void)chooseLocation {
    [self.router presentGeoLocation];
}

- (void)choosePicture {
    [self.router presentImagePicker];
}

#pragma mark ChatRouterDelegate

- (void)didChooseLocation:(CLLocationCoordinate2D)location {
    Participant *sender = self.state.currentPerson;
    Chat *chat = self.state.chat;
    
    if (!sender || !chat) {
        return;
    }
    NSString *locationString = [NSString stringWithFormat:@"%f;%f", location.latitude, location.longitude];
    Message *message = [self.interactor createGeoLocation:locationString fromParticipant:sender inChat:chat];
    [self postMessage:message];
}

- (void)didChoosePicture:(NSData *)data {
    Participant *sender = self.state.currentPerson;
    Chat *chat = self.state.chat;
    
    if (!sender || !chat) {
        return;
    }
    NSData *scaledData = [self.interactor rescaleImage:data toSize:CGSizeMake(resizedSizeWidth, resizedSizeHeight)];
    Message *message = [self.interactor createImageMessage:scaledData fromParticipant:sender inChat:chat];
    [self postMessage:message];
}

#pragma mark Interactor Output

- (void)incomingMessage:(Message *)message {
    [self postMessage:message];
}

#pragma mark Private

- (void)postMessage:(Message *)message {
    [self.state.messages addObject:message];
    [self.view newMessage:message];
}

@end
