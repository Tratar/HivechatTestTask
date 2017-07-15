//
//  Chat+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

#import "Chat+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Chat (CoreDataProperties)

+ (NSFetchRequest<Chat *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *chatID;
@property (nullable, nonatomic, retain) NSSet<Participant *> *participants;
@property (nullable, nonatomic, retain) Message *messages;

@end

@interface Chat (CoreDataGeneratedAccessors)

- (void)addParticipantsObject:(Participant *)value;
- (void)removeParticipantsObject:(Participant *)value;
- (void)addParticipants:(NSSet<Participant *> *)values;
- (void)removeParticipants:(NSSet<Participant *> *)values;

@end

NS_ASSUME_NONNULL_END
