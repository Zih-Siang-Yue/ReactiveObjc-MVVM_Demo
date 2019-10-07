//
//  LoginViewController.h
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController

- (instancetype)initWithViewModel:(LoginViewModel*)vm;

@end

NS_ASSUME_NONNULL_END
