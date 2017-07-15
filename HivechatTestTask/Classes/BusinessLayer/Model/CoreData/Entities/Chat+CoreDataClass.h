//
//  Chat+CoreDataClass.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 We. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message, Participant;

NS_ASSUME_NONNULL_BEGIN

@interface Chat : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Chat+CoreDataProperties.h"
