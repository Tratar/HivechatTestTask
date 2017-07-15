//
//  ChatPresenter.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatRouter.h"

@class ChatInteractor;
@class ChatViewController;
@class Message;
@class ChatPresenterState;

@interface ChatPresenter : NSObject<ChatRouterDelegate>

@property (nonatomic, strong) ChatPresenterState *state;
@property (nonatomic, weak) ChatRouter *router;
@property (nonatomic, weak) ChatInteractor *interactor;
@property (nonatomic, strong) ChatViewController *view;

#pragma mark View Output

- (void)loaded;
- (void)newTextMessage:(NSString *)textMessage;
- (void)chooseLocation;
- (void)choosePicture;

#pragma mark Interactor Output

- (void)incomingMessage:(Message *)message;

@end
