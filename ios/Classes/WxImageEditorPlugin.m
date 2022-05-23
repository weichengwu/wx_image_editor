#import "WxImageEditorPlugin.h"
#if __has_include(<wx_image_editor/wx_image_editor-Swift.h>)
#import <wx_image_editor/wx_image_editor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wx_image_editor-Swift.h"
#endif

@implementation WxImageEditorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWxImageEditorPlugin registerWithRegistrar:registrar];
}
@end
