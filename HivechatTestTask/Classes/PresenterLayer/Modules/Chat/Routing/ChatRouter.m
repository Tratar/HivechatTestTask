//
//  ChatRouter.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "ChatChooseGeoLocationViewController.h"

#import "ChatInteractor.h"
#import "ChatRouter.h"
#import "ChatViewController.h"
#import "ChatPresenter.h"
#import "ChatPresenterState.h"

@interface ChatRouter()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, ChatChooseGeoLocationViewControllerDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation ChatRouter

- (void)presentChat {
    ChatViewController *chatViewController = [[UIStoryboard storyboardWithName:@"ChatStoryboard" bundle:nil] instantiateInitialViewController];
    
    ChatPresenter *presenter = [ChatPresenter new];
    
    presenter.interactor = self.interactor;
    presenter.view = chatViewController;
    presenter.router = self;
    presenter.state = [ChatPresenterState new];
    
    self.interactor.presenter = presenter;
    self.delegate = presenter;
    chatViewController.presenter = presenter;
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:chatViewController];
    
    [self.window setRootViewController:self.navigationController];
}

- (void)presentGeoLocation {
    ChatChooseGeoLocationViewController *controller = [[UIStoryboard storyboardWithName:@"ChatStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ChatChooseGeoLocationViewController"];
    
    controller.delegate = self;
    
    
    [self.navigationController setViewControllers:[self.navigationController.viewControllers arrayByAddingObject:controller] animated:YES];
    //[self.navigationController presentViewController:controller animated:YES completion:nil];
    // [self.navigationController setViewControllers:[self.navigationController.viewControllers arrayByAddingObject:picker] animated:YES];
}

- (void)presentImagePicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([UIImagePickerController isSourceTypeAvailable:type] == false) {
        return;
    }
    
    picker.delegate = self;
    picker.mediaTypes = @[(NSString *) kUTTypeImage];
    picker.sourceType = type;
    
    [self.navigationController presentViewController:picker animated:YES completion:nil];
   // [self.navigationController setViewControllers:[self.navigationController.viewControllers arrayByAddingObject:picker] animated:YES];
}

#pragma mark ChatChooseGeoLocationViewControllerDelegate

- (void)chatChooseGeoLocationViewController:(ChatChooseGeoLocationViewController *)viewController didSelectLocation:(CLLocationCoordinate2D)location {
    [self.delegate didChooseLocation:location];
    
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    [viewControllers removeObject:viewController];
    
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (image) {
        NSData *imgData = UIImagePNGRepresentation(image);
        [self.delegate didChoosePicture:imgData];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
