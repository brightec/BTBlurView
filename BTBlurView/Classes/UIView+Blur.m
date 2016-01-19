//
//  UIView+Blur.m
//
//  Created by Cameron Cooke on 07/08/2014.
//  Copyright (c) 2014 Brightec Ltd. All rights reserved.
//

#import "UIView+Blur.h"
#import "SDVersion.h"


@implementation UIView (Blur)


+ (BOOL)poorGraphicsQuality
{
    NSSet *graphicsQuality = [NSSet setWithObjects:@"iPad",
                              @"iPad1,1",
                              @"iPhone1,1",
                              @"iPhone1,2",
                              @"iPhone2,1",
                              @"iPhone3,1",
                              @"iPhone3,2",
                              @"iPhone3,3",
                              @"iPod1,1",
                              @"iPod2,1",
                              @"iPod2,2",
                              @"iPod3,1",
                              @"iPod4,1",
                              @"iPad2,1",
                              @"iPad2,2",
                              @"iPad2,3",
                              @"iPad2,4",
                              @"iPad3,1",
                              @"iPad3,2",
                              @"iPad3,3",
                              nil];
    
    return [graphicsQuality containsObject:[SDVersion deviceName]];
}


+ (BOOL)canBlur
{
    if ([UIVisualEffectView class] == nil) {
        return NO;
    }
    
    /*
     Some older devices that support iOS8 don't actually support
     bluring and just render a grey box. This method rules out
     these devices.
     */
    if ([self poorGraphicsQuality]) {
        return NO;
    }
    
    return YES;
}


- (GPUImageiOSBlurFilter *)blurFilter
{
    static GPUImageiOSBlurFilter *blurFilter;
    if (blurFilter == nil) {
        blurFilter = [GPUImageiOSBlurFilter new];
    }
    
    return blurFilter;
}


- (UIImage *)snapshot
{
    @try {
        
        // does not need to be retina resolution as it will be blured
        UIGraphicsBeginImageContext(self.bounds.size);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
        
    }
    @catch (NSException *exception) {
        
        // catch exceptions as snapshotting is not essential to
        // the apps funciontality.
        return nil;
    }
}


- (UIImage *)bluredSnapshotImage
{
    return [self bluredSnapshotImageWithBlurRadius:12.0f];
}


- (UIImage *)bluredSnapshotImageWithBlurRadius:(CGFloat)blurRadius
{
    GPUImageiOSBlurFilter *blurFilter = [self blurFilter];
    blurFilter.blurRadiusInPixels = blurRadius;
    blurFilter.saturation = 1.0f;
    
    UIImage *bluredImage = [blurFilter imageByFilteringImage:[self snapshot]];
    return bluredImage;
}


# pragma mark -
# pragma mark GPUImageView methods 

- (GPUImageView *)updateBlurWithImageView:(GPUImageView *)imageView
{
    GPUImageiOSBlurFilter *blurFilter = [self blurFilter];
    UIImage *snapshot = [self snapshot];

    if (snapshot == nil) {
        return nil;
    }
    
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:snapshot];
    [picture addTarget:blurFilter];
    [blurFilter addTarget:imageView];
    [picture processImageWithCompletionHandler:^{
        [blurFilter removeAllTargets];
    }];
    
    return imageView;
}


+ (GPUImageView *)gpuImageViewWithFrame:(CGRect)frame
{
    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.clipsToBounds = YES;
    imageView.layer.contentsGravity = kCAGravityCenter;
    return imageView;
}


@end
