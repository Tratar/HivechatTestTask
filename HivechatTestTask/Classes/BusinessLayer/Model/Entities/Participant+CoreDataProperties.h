//
//  Participant+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Participant+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Participant (CoreDataProperties)

+ (NSFetchRequest<Participant *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *participantID;
@property (nullable, nonatomic, retain) NSSet<Message *> *messages;

@end

@interface Participant (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet<Message *> *)values;
- (void)removeMessages:(NSSet<Message *> *)values;

@end

NS_ASSUME_NONNULL_END
