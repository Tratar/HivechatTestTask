//
//  ImageService.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 14/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageService.h"

@implementation ImageService

- (NSData *)rescaleImage:(NSData *)data toSize:(CGSize)size {
    UIImage *image = [UIImage imageWithData:data];
    float imageRatio = image.size.width / image.size.height;
    float widthScale = image.size.width / size.width;
    float heightScale = image.size.height / size.height;
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    if (widthScale >= heightScale) {
        width = size.height * imageRatio ;
        height = size.height;
    } else {
        width = size.width;
        height = size.width / imageRatio;
    }
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    [view setImage:image];
    view.contentMode = UIViewContentModeScaleAspectFit;
        
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
        
    UIGraphicsEndImageContext();
        
    return UIImagePNGRepresentation(img);
}

@end
