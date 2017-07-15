//
//  Chat+CoreDataProperties.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Chat+CoreDataProperties.h"

@implementation Chat (CoreDataProperties)

+ (NSFetchRequest<Chat *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Chat"];
}

@dynamic name;
@dynamic chatID;
@dynamic messages;
@dynamic bot;
@dynamic persons;

@end
