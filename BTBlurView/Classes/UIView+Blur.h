//
//  UIView+Blur.h
//
//  Created by Cameron Cooke on 07/08/2014.
//  Copyright (c) 2014 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>


@interface UIView (Blur)
// Takes a snapshot of the view
- (UIImage *)snapshot;

// Takes a snapshot of the view and applies a blur effect
- (UIImage *)bluredSnapshotImage;
- (UIImage *)bluredSnapshotImageWithBlurRadius:(CGFloat)blurRadius;

// Bluring using GPUImageView, useful for doing realtime blurs
// as more effecient than using UIImageView
- (GPUImageView *)updateBlurWithImageView:(GPUImageView *)imageView;

// Helper method to create a configured GPUImageView
+ (GPUImageView *)gpuImageViewWithFrame:(CGRect)frame;
@end
