//
//  BotService.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "DataAccess.h"

#import "BotService.h"
#import "Bot+CoreDataClass.h"
#import "Message+CoreDataClass.h"
#import "Chat+CoreDataClass.h"

@implementation BotService

- (void)bot:(Bot *)bot analyzeMessageAndRespond:(Message *)message completion:(void(^)(Message *))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        [self.dataAccess performBlockOnPrivateContextQueue:^{
            Message *retakenMessage = [self.dataAccess retakeMessage:message];
            Message *respondMessage = [self.dataAccess createTextMessage:retakenMessage.bodyText imageData:retakenMessage.bodyPicture geoLocation:retakenMessage.bodyLocation sentOn:[NSDate date] fromParticipant:bot inChat:retakenMessage.chat];
            if (completion)
                completion(respondMessage);
        }];
    });
}

@end
