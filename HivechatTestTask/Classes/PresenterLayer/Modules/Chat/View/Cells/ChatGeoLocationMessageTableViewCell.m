//
//  ChatGeoLocationMessageTableViewCell.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "ChatGeoLocationMessageTableViewCell.h"

#import "Message+CoreDataClass.h"
#import "Participant+CoreDataClass.h"

@interface ChatGeoLocationMessageTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leadingMapConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *trailingMapConstraint;

@end

@implementation ChatGeoLocationMessageTableViewCell

- (void)awakeFromNib {
    self.locationMapView.layer.cornerRadius = 10.0;
    self.locationMapView.layer.masksToBounds = YES;

    [super awakeFromNib];
}

- (void)configureWithMessage:(Message *)message sentByCurrentUser:(BOOL)sentByCurrentUser {
    NSArray *locations = [message.bodyLocation componentsSeparatedByString:@";"];
    CLLocationDegrees latitude = [locations[0] doubleValue];
    CLLocationDegrees longitude = [locations[1] doubleValue];
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    [self.locationMapView setRegion:MKCoordinateRegionMake(locationCoordinate, MKCoordinateSpanMake(1.0, 1.0)) animated:NO];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = locationCoordinate;
    [self.locationMapView addAnnotation:annotation];

    if (sentByCurrentUser) {
        self.senderNameLabel.text = @"Me";
        self.senderNameLabel.textAlignment = NSTextAlignmentRight;
        
        self.leadingMapConstraint.active = NO;
        self.trailingMapConstraint.active = YES;
        
    } else {
        self.senderNameLabel.text = message.sender.name;
        self.senderNameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.trailingMapConstraint.active = NO;
        self.leadingMapConstraint.active = YES;
    }
}

@end
