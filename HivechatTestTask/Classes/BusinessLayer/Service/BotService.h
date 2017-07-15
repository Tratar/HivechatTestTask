//
//  BotService.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bot;
@class Message;
@class DataAccess;

@interface BotService : NSObject

@property (nonatomic, strong) DataAccess *dataAccess;

- (void)bot:(Bot *)bot analyzeMessageAndRespond:(Message *)message completion:(void(^)(Message *))completion;

@end
