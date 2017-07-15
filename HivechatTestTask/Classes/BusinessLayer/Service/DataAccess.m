//
//  DataAccess.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "DataAccess.h"

#import "Message+CoreDataClass.h"
#import "Participant+CoreDataClass.h"
#import "Chat+CoreDataClass.h"
#import "Bot+CoreDataClass.h"
#import "Person+CoreDataClass.h"

NSString *const ModelName = @"ChatScheme";
NSString *const ModelExtension = @"momd";

NSString *const SQLLiteFileName = @"ChatScheme.sqlite";

@interface DataAccess()

@property (nonatomic, strong) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *privateObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataAccess

#pragma mark Lifecycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Public

- (void)configure {
    NSURL *modelURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:ModelName ofType:ModelExtension]];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSURL *fileURL = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    fileURL = [fileURL URLByAppendingPathComponent:SQLLiteFileName];
    
    NSError *error = nil;
    [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:nil error:&error];

    if (error != nil) {
        [NSException raise:@"Unable to init persistent storage" format:@"Unable to init persistent storage"];
        return;
    }
    
    self.privateObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.privateObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    self.mainObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainObjectContext.parentContext = self.privateObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(privateObjectSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:self.privateObjectContext];
}

- (Chat *)chatByName:(NSString *)name {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    Chat * __block result = nil;
    NSFetchRequest <Chat *> *chat = [[NSFetchRequest <Chat *> alloc] initWithEntityName:@"Chat"];
    
    chat.predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    result = [[context executeFetchRequest:chat error:nil] firstObject];
    
    return result;
}

- (Person *)personByName:(NSString *)name {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    Person * __block result = nil;
    NSFetchRequest <Person *> *person = [[NSFetchRequest <Person *> alloc] initWithEntityName:@"Person"];
    
    person.predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    result = [[context executeFetchRequest:person error:nil] firstObject];
    
    return result;
}

- (Message *)retakeMessage:(Message *)message {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    NSError *error = nil;
    Message *result = [context existingObjectWithID:message.objectID error:&error];
    
    if (error) {
        return nil;
    }
    
    return result;
}

- (NSArray <Message *> *)messagesForChat:(Chat *)chat {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"sentOn" ascending:YES];
    return [chat.messages sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (Message *)createTextMessage:(NSString *)textMessage imageData:(NSData *)imageData geoLocation:(NSString *)geoLocation sentOn:(NSDate *)sentOn fromParticipant:(Participant *)participant inChat:(Chat *)chat {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    NSError *error = nil;
    Participant *senderRetaken = [context existingObjectWithID:participant.objectID error:&error];
    if (error != nil) {
        return nil;
    }
    
    Chat *chatRetaken = [context existingObjectWithID:chat.objectID error:&error];
    if (error != nil) {
        return nil;
    }
    
    Message *message = [[Message alloc] initWithContext:context];
    message.bodyText = textMessage;
    message.bodyPicture = imageData;
    message.bodyLocation = geoLocation;
    message.sender = senderRetaken;
    message.chat = chatRetaken;
    message.messageID = [[NSUUID new] UUIDString];
    message.sentOn = sentOn;
    
    
    [context insertObject:message];
    [context save:nil];
    
    return message;
}

- (Chat *)createChatWithName:(NSString *)name {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    Chat *chat = [[Chat alloc] initWithContext:context];
    
    chat.name = name;
    chat.chatID = [[NSUUID new] UUIDString];
    
    [context insertObject:chat];
    [context save:nil];
    
    return chat;
}

- (Bot *)createBotWithName:(NSString *)name toChat:(Chat *)chat {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    Bot *bot = [[Bot alloc] initWithContext:context];
    
    bot.name = name;
    bot.participantID = [[NSUUID new] UUIDString];
    bot.chat = chat;
    
    [context insertObject:bot];
    [context save:nil];
    
    return bot;
}

- (Person *)createPersonWithName:(NSString *)name {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    Person *person = [[Person alloc] initWithContext:context];
    
    person.name = name;
    person.participantID = [[NSUUID new] UUIDString];
    
    [context insertObject:person];
    [context save:nil];
    
    return person;
}

- (void)joinPerson:(Person *)person toChat:(Chat *)chat {
    NSManagedObjectContext *context = NSThread.isMainThread ? self.mainObjectContext : self.privateObjectContext;
    
    NSError *error = nil;
    
    Person *personRetaken = [context existingObjectWithID:person.objectID error:&error];
    if (error != nil) {
        return;
    }
    
    Chat *chatRetaken = [context existingObjectWithID:chat.objectID error:&error];
    if (error != nil) {
        return;
    }

    if ([chatRetaken.persons containsObject:personRetaken]) {
        return;
    } else {
        [chatRetaken addPersonsObject:personRetaken];
        [context save:nil];
    }
}

- (void)performBlockOnPrivateContextQueue:(void (^)())block {
    [self.privateObjectContext performBlockAndWait:block];
}

#pragma mark Notifications

- (void)privateObjectSaveNotification:(NSNotification *)notification {
    [self.mainObjectContext performBlock:^{
        [self.mainObjectContext mergeChangesFromContextDidSaveNotification:notification];
    }];
}

@end
