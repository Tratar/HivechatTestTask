//
//  Bot+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Bot+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Bot (CoreDataProperties)

+ (NSFetchRequest<Bot *> *)fetchRequest;

@property (nullable, nonatomic, retain) Chat *chat;

@end

NS_ASSUME_NONNULL_END
