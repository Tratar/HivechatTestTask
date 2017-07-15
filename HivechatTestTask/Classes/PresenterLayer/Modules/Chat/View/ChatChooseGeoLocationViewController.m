//
//  ChatChoosGeoLocationViewController.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 14/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

#import "ChatChooseGeoLocationViewController.h"

NSString *const ChatChooseGeoLocationViewControllerAnnotationReuseIdentifier = @"ChatChooseGeoLocationViewControllerAnnotationReuseIdentifier";

@interface ChatChooseGeoLocationViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *pointAnnotation;

@end

@implementation ChatChooseGeoLocationViewController

#pragma mark Lifecycle

- (void)viewDidLoad {
    self.pointAnnotation = [MKPointAnnotation new];
    
    self.pointAnnotation.coordinate = CLLocationCoordinate2DMake(10.0, 10.0);
    [self.mapView setCenterCoordinate:self.pointAnnotation.coordinate animated:NO];
    [self.mapView addAnnotation:self.pointAnnotation];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneButton;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)tapAction:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [recognizer locationInView:self.mapView];
        self.pointAnnotation.coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    }
}

- (void)done:(id)sender {
    [self.delegate chatChooseGeoLocationViewController:self didSelectLocation:self.pointAnnotation.coordinate];
}

#pragma mark MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {    MKPinAnnotationView * pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ChatChooseGeoLocationViewControllerAnnotationReuseIdentifier];
    
    pinAnnotationView.pinTintColor = [UIColor purpleColor];
    pinAnnotationView.draggable = NO;
    
    return pinAnnotationView;
}

- (void)dealloc {
    
}

@end
