//
//  AppDependencies.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "AppDependencies.h"
#import "BotService.h"
#import "DataAccess.h"
#import "ImageService.h"

#import "ChatRouter.h"
#import "ChatInteractor.h"

@interface AppDependencies()

@property (nonatomic, readwrite) ChatRouter *chatRouter;

@end

@implementation AppDependencies

- (void)configureWithWindow:(UIWindow *)window {
    BotService *botService = [BotService new];
    DataAccess *dataAccess = [DataAccess new];
    ImageService *imageService = [ImageService new];
    
    ChatRouter *chatRouter = [ChatRouter new];
    ChatInteractor *chatInteractor = [ChatInteractor new];
    
    [dataAccess configure];
    
    botService.dataAccess = dataAccess;
    
    chatInteractor.botService = botService;
    chatInteractor.dataAccess = dataAccess;
    chatInteractor.imageService = imageService;
    
    chatRouter.interactor = chatInteractor;
    chatRouter.window = window;
    
    self.chatRouter = chatRouter;
}

@end
