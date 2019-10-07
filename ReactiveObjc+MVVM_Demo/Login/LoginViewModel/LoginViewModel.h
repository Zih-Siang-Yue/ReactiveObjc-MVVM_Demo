//
//  LoginViewModel.h
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//


#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : BaseViewModel

@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) UIImage *image;

@property (strong, readonly, nonatomic) RACSignal *loginBtnEnableSignal;
@property (strong, nonatomic) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
