//
//  UIImage+MaskImage.h
//  CIMCNote
//
//  Created by cloudzou on 8/15/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MaskImage)

+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end
