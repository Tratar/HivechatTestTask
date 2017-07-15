//
//  Participant+CoreDataProperties.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

#import "Participant+CoreDataProperties.h"

@implementation Participant (CoreDataProperties)

+ (NSFetchRequest<Participant *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Participant"];
}

@dynamic name;
@dynamic isBot;
@dynamic participantID;
@dynamic chats;
@dynamic messages;

@end
