//
//  Participant+CoreDataProperties.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Participant+CoreDataProperties.h"

@implementation Participant (CoreDataProperties)

+ (NSFetchRequest<Participant *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Participant"];
}

@dynamic name;
@dynamic participantID;
@dynamic messages;

@end
