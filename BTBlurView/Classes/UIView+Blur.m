//
//  UIView+Blur.m
//
//  Created by Cameron Cooke on 07/08/2014.
//  Copyright (c) 2014 Brightec Ltd. All rights reserved.
//

#import "UIView+Blur.h"


@implementation UIView (Blur)


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
    // does not need to be retina resolution as it will be blured
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
