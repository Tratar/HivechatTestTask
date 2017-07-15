//
//  Bot+CoreDataProperties.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Bot+CoreDataProperties.h"

@implementation Bot (CoreDataProperties)

+ (NSFetchRequest<Bot *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Bot"];
}

@dynamic chat;

@end
