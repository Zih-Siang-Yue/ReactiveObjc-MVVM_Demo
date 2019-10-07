//
//  LoginViewModel.m
//  ReactiveObjc+MVVM_Demo
//
//  Created by Sean.Yue on 2019/10/7.
//  Copyright © 2019 Sean.Yue. All rights reserved.
//

#import "LoginViewModel.h"
#import "NSString+Utils.h"

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loginBtnSignalBinding];
        [self imageConfig];
        [self loginCommandConfig];
    }
    return self;
}

- (void)loginBtnSignalBinding {
    NSArray *signals = @[RACObserve(self, account), RACObserve(self, password)];
    RAC(self, loginBtnEnableSignal) = [[RACSignal combineLatest:signals reduce:^id(NSString *ac, NSString *pw) {
        return @(ac.length && pw.length);
    }] distinctUntilChanged];
}

- (void)imageConfig {
    self.image = [UIImage imageNamed:@"MVVM"];
}

- (void)loginCommandConfig {
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        self.account = [self.account filterSpaceChar];
        self.password = [self.password filterSpaceChar];
        
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            //mock api situation
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSDictionary *mockResult = @{ @"token": @"validation" };
                
                if ([mockResult[@"token"] isEqualToString:@"validation"]) {
                    [subscriber sendNext:mockResult];
                    self.password = @"";
                }
                else {
                    NSError *err = [NSError errorWithDomain:@"Invalidation" code:500 userInfo:nil];
                    [subscriber sendError:err];
                }
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
}

@end
