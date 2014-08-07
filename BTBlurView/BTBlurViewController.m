//
//  BTBlurViewController.m
//  BTBlurView
//
//  Created by Cameron Cooke on 07/08/2014.
//  Copyright (c) 2014 Brightec Ltd. All rights reserved.
//

#import "BTBlurViewController.h"
#import "UIView+Blur.h"


@interface BTBlurViewController ()
@property (nonatomic) GPUImageView *backgroundImageView;
@end


@implementation BTBlurViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // preapre the imageview
    CGRect frame = CGRectInset(self.view.bounds, 20.0f, 100.0f);
    self.backgroundImageView = [UIView gpuImageViewWithFrame:frame];
    self.backgroundImageView.center = self.view.center;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    frame = self.backgroundImageView.frame;
    NSLog(@"frame=%@", NSStringFromCGRect(frame));
    
    CGFloat contentsX = CGRectGetMinX(frame) / CGRectGetWidth(self.view.bounds);
    CGFloat contentsY = CGRectGetMinY(frame) / CGRectGetHeight(self.view.bounds);
    CGFloat contentsW = CGRectGetWidth(frame) / CGRectGetWidth(self.view.bounds);
    CGFloat contentsH = CGRectGetHeight(frame) / CGRectGetHeight(self.view.bounds);
    
    self.backgroundImageView.layer.contentsRect = CGRectMake(contentsX, contentsY, contentsW, contentsH);
    self.backgroundImageView.layer.contentsScale = contentsW * 2;
    
    [self.view insertSubview:self.backgroundImageView atIndex:1];
    
    [self updateBlur];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBlur];
}


- (void)updateBlur
{
    UIView *view = self.presentingViewController.view;
    [view updateBlurWithImageView:self.backgroundImageView];
}


@end
