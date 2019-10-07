//
//  LoadingView.h
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingView : UIView

- (void)bgColorConfig:(UIColor*)color;
- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
