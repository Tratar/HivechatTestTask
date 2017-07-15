//
//  AppDependencies.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 12/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ChatRouter.h"

@interface AppDependencies : NSObject

@property (nonatomic, readonly) ChatRouter *chatRouter;

- (void)configureWithWindow:(UIWindow *)window;

@end
