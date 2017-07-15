//
//  Person+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSSet<Chat *> *chats;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addChatsObject:(Chat *)value;
- (void)removeChatsObject:(Chat *)value;
- (void)addChats:(NSSet<Chat *> *)values;
- (void)removeChats:(NSSet<Chat *> *)values;

@end

NS_ASSUME_NONNULL_END
