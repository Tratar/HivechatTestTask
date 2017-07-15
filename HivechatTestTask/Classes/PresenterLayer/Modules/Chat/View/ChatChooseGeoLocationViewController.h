//
//  ChatChooseGeoLocationViewController.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 14/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@protocol ChatChooseGeoLocationViewControllerDelegate;

@interface ChatChooseGeoLocationViewController : UIViewController

@property (weak, nonatomic) id<ChatChooseGeoLocationViewControllerDelegate> delegate;

@end

@protocol ChatChooseGeoLocationViewControllerDelegate <NSObject>

- (void)chatChooseGeoLocationViewController:(ChatChooseGeoLocationViewController *)viewController didSelectLocation:(CLLocationCoordinate2D)location;

@end
