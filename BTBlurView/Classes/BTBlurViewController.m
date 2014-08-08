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
@property (nonatomic) UIImageView *backgroundImageView;
@end


@implementation BTBlurViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // preapre the imageview
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImageView.center = self.view.center;    
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;;
    self.backgroundImageView.contentMode = UIViewContentModeCenter;
    self.backgroundImageView.clipsToBounds = YES;
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self updateBlur];
}

- (void)updateBlur
{
    UIView *view = self.presentingViewController.view;
    self.backgroundImageView.image = [view bluredSnapshotImage];
}


@end
