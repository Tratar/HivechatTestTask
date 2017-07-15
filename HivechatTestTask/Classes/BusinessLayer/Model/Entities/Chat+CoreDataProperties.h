//
//  Chat+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Chat+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Chat (CoreDataProperties)

+ (NSFetchRequest<Chat *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *chatID;
@property (nullable, nonatomic, retain) NSSet<Message *> *messages;
@property (nullable, nonatomic, retain) Bot *bot;
@property (nullable, nonatomic, retain) NSSet<Person *> *persons;

@end

@interface Chat (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet<Message *> *)values;
- (void)removeMessages:(NSSet<Message *> *)values;

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet<Person *> *)values;
- (void)removePersons:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
