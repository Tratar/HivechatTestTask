//
//  Chat+CoreDataProperties.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

#import "Chat+CoreDataProperties.h"

@implementation Chat (CoreDataProperties)

+ (NSFetchRequest<Chat *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Chat"];
}

@dynamic name;
@dynamic chatID;
@dynamic participants;
@dynamic messages;

@end
