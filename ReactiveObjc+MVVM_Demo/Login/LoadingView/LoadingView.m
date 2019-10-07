//
//  LoadingView.m
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView()

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation LoadingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self indicatorViewConfig];
    }
    return self;
}

#pragma mark - public

- (void)bgColorConfig:(UIColor*)color {
    self.backgroundColor = color;
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setHidden:NO];
        [self.indicatorView startAnimating];
        self.indicatorView.hidden = NO;
    });
}

- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setHidden:YES];
        self.indicatorView.hidden = YES;
        [self.indicatorView stopAnimating];
    });
}

#pragma mark - private

- (void)indicatorViewConfig {
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.indicatorView.color = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1];
    self.indicatorView.hidesWhenStopped = YES;
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.indicatorView];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
    [self addConstraints:@[centerX, centerY]];
}

@end
