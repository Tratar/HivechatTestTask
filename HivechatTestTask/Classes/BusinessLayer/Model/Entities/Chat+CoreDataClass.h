//
//  Chat+CoreDataClass.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bot, Message, Person;

NS_ASSUME_NONNULL_BEGIN

@interface Chat : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Chat+CoreDataProperties.h"
