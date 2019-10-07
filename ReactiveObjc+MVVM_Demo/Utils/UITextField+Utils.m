//
//  UITextField+Utils.m
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

#import "UITextField+Utils.h"

@implementation UITextField (Utils)

- (void)bottomBorderConfig:(CGFloat)height {
    dispatch_async(dispatch_get_main_queue(), ^{
        CALayer *border = [CALayer new];
        border.frame = CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height);
        border.backgroundColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1].CGColor;
        [self.layer addSublayer:border];
    });
}

@end
