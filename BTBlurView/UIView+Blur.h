//
//  UIView+Blur.h
//
//  Created by Cameron Cooke on 07/08/2014.
//  Copyright (c) 2014 Brightec Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>


@interface UIView (Blur)
- (UIImage *)snapshot;
- (GPUImageView *)updateBlurWithImageView:(GPUImageView *)imageView;
+ (GPUImageView *)gpuImageViewWithFrame:(CGRect)frame;
@end
