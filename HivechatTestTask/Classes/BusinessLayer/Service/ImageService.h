//
//  ImageService.h
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 14/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ImageService : NSObject

- (NSData *)rescaleImage:(NSData *)data toSize:(CGSize)size;

@end
