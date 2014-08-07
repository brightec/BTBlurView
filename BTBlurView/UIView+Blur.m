//
//  UIView+Blur.m
//
//  Created by Cameron Cooke on 07/08/2014.
//  Copyright (c) 2014 Brightec Ltd. All rights reserved.
//

#import "UIView+Blur.h"


@implementation UIView (Blur)


- (UIImage *)snapshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (GPUImageView *)updateBlurWithImageView:(GPUImageView *)imageView
{
    static GPUImageiOSBlurFilter *blurFilter;
    if (blurFilter == nil) {
        blurFilter = [GPUImageiOSBlurFilter new];
        blurFilter.saturation = 1.5;
        blurFilter.blurRadiusInPixels = 1;
    }
    
    // used for testing alignments
    GPUImageSepiaFilter *sepiaFilter = [GPUImageSepiaFilter new];

    UIImage *snapshot = [self snapshot];
    
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:snapshot];
    [picture addTarget:sepiaFilter];
    [sepiaFilter addTarget:imageView];
    [picture processImageWithCompletionHandler:^{
        [sepiaFilter removeAllTargets];
    }];
    
    return imageView;
}


+ (GPUImageView *)gpuImageViewWithFrame:(CGRect)frame
{
    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:frame];
    imageView.clipsToBounds = YES;
    imageView.layer.contentsGravity = kCAGravityTop;
    return imageView;
}


@end
