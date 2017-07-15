//
//  Participant+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

#import "Participant+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Participant (CoreDataProperties)

+ (NSFetchRequest<Participant *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL isBot;
@property (nullable, nonatomic, copy) NSString *participantID;
@property (nullable, nonatomic, retain) Chat *chats;
@property (nullable, nonatomic, retain) Message *messages;

@end

NS_ASSUME_NONNULL_END
