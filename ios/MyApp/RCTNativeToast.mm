#import "RCTNativeToast.h"
#import <React/RCTLog.h>
#import "MyApp-Swift.h"

#ifdef RCT_NEW_ARCH_ENABLED
#import "MyAppSpecs.h"
#endif

@implementation RCTNativeToast {
    NativeToastSwiftImpl *_swiftImpl;
}

RCT_EXPORT_MODULE(NativeToast)

- (instancetype)init {
    if (self = [super init]) {
        _swiftImpl = [[NativeToastSwiftImpl alloc] init];
    }
    return self;
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeMyAppSpecsSpecJSI>(params);
}
#endif

RCT_EXPORT_METHOD(showToast:(NSString *)message) {
    [_swiftImpl showToast:message];
}

// Don't compile this code when we build for the old architecture.
#ifdef RCT_NEW_ARCH_ENABLED
- (void)showToast:(NSString *)message {
    [_swiftImpl showToast:message];
}
#endif

@end
