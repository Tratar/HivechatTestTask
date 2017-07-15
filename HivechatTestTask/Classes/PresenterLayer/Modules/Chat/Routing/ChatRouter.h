//
//  ChatRouter.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class ChatInteractor;
@protocol ChatRouterDelegate;

@interface ChatRouter : NSObject

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) ChatInteractor *interactor;
@property (nonatomic, weak) id<ChatRouterDelegate> delegate;

- (void)presentChat;
- (void)presentImagePicker;
- (void)presentGeoLocation;

@end

@protocol ChatRouterDelegate <NSObject>

- (void)didChoosePicture:(NSData *)data;
- (void)didChooseLocation:(CLLocationCoordinate2D)location;

@end
