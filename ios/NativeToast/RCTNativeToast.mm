#import "RCTNativeToast.h"
#import "MyApp-Swift.h"

@implementation RCTNativeToast {
  TurboToastSwiftImpl *_swiftImpl;
}

RCT_EXPORT_MODULE("NativeToast")

- (instancetype)init {
  self = [super init];
  if (self) {
    _swiftImpl = [[TurboToastSwiftImpl alloc] init];
  }
  return self;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeToastSpecJSI>(params);
}

- (void)showToast:(NSString *)message {
  [_swiftImpl show:message];
}

@end
