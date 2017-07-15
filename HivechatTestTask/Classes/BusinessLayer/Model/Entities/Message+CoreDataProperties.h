//
//  Message+CoreDataProperties.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "Message+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

+ (NSFetchRequest<Message *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *sentOn;
@property (nullable, nonatomic, copy) NSString *bodyText;
@property (nullable, nonatomic, retain) NSData *bodyPicture;
@property (nullable, nonatomic, copy) NSString *bodyLocation;
@property (nullable, nonatomic, copy) NSString *messageID;
@property (nullable, nonatomic, retain) Chat *chat;
@property (nullable, nonatomic, retain) Participant *sender;

@end

NS_ASSUME_NONNULL_END
