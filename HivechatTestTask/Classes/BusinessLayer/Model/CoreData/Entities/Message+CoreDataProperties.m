//
//  Message+CoreDataProperties.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

#import "Message+CoreDataProperties.h"

@implementation Message (CoreDataProperties)

+ (NSFetchRequest<Message *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Message"];
}

@dynamic sentOn;
@dynamic bodyText;
@dynamic bodyPicture;
@dynamic bodyLocation;
@dynamic messageID;
@dynamic chats;
@dynamic sender;

@end
