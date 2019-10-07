//
//  LoginViewController.m
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UITextField+Utils.h"
#import "LoadingView.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *subjectImageView;
@property (weak, nonatomic) IBOutlet UITextField *accTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) LoadingView *loadingView;

@property (strong, nonatomic) LoginViewModel *vm;

@end

@implementation LoginViewController

- (instancetype)initWithViewModel:(LoginViewModel*)vm {
    self = [super init];
    if (self) {
        self.vm = vm;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vmConfig];
    [self imageViewConfig];
    [self textFieldConfig];
    [self btnConfig];
    [self loadingViewConfig];
    [self subscribeLoginResult];
}

- (void)vmConfig {
    RACChannelTo(self.vm, account) = RACChannelTo(self.accTextField, text);
    [self.accTextField.rac_textSignal subscribe:RACChannelTo(self.vm, account)];
    
    RACChannelTo(self.vm, password) = RACChannelTo(self.pwdTextField, text);
    [self.pwdTextField.rac_textSignal subscribe:RACChannelTo(self.vm, password)];
}

- (void)imageViewConfig {
    RAC(self.subjectImageView, image) = RACObserve(self.vm, image);
}

- (void)textFieldConfig {
    [self.accTextField bottomBorderConfig:1];
    [self.pwdTextField bottomBorderConfig:1];
}

- (void)btnConfig {
    self.loginBtn.layer.cornerRadius = 5.0;
    RAC(self.loginBtn, enabled) = RACObserve(self.vm, loginBtnEnableSignal);
    RAC(self.loginBtn, backgroundColor) = [RACObserve(self.vm, loginBtnEnableSignal) map:^id _Nullable(NSNumber *value) {
        UIColor *availableColor = [UIColor colorWithRed:250/255.0 green:191/255.0 blue:19/255.0 alpha:1];
        UIColor *unavailableColor = [UIColor lightGrayColor];
        return [value boolValue] ? availableColor : unavailableColor;
    }];
    
    //Button Action
    @weakify(self);
    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          @strongify(self);
          [self.view endEditing:YES];
      }]
     subscribeNext:^(UIButton *btn) {
         @strongify(self);
         [self.vm.loginCommand execute:nil];
     }];
}

- (void)loadingViewConfig {
    self.loadingView = [LoadingView new];
    self.loadingView.layer.cornerRadius = 5.0;
    [self.loadingView bgColorConfig:[UIColor lightGrayColor]];
    [self.view addSubview:self.loadingView];
    self.loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
    
    [self.view addConstraints:@[top, leading, bottom, trailing]];
}

#pragma mark - subscribe

- (void)subscribeLoginResult {
    //success
    @weakify(self);
    [self.vm.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *result) {
        @strongify(self);
        [self showAlert:@"Log - in" msg:@"Success"];
    }];
    
    //error
    [self.vm.loginCommand.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        [self showAlert:@"Log - in" msg:@"Fail"];
    }];
    
    [[self.vm.loginCommand.executing skip:0] subscribeNext:^(NSNumber *isLoading) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [isLoading boolValue] ? [self.loadingView show] : [self.loadingView dismiss];
        });
    }];
}

#pragma mark - misc

- (void)showAlert:(NSString*)title msg:(NSString*)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:true completion:nil];
}

@end
