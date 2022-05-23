import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wx_image_editor_platform_interface.dart';

/// An implementation of [WxImageEditorPlatform] that uses method channels.
class MethodChannelWxImageEditor extends WxImageEditorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wx_image_editor');

  @override
  Future<void> editImage(String path) async {
    await methodChannel.invokeMethod('editImage', path);
  }

  @override
  Future<void> setup({
    List<IosEditImageTool>? iosEditImageTools,
    List<IosImageAdjustTool>? iosImageAdjustTools,
  }) async {
    await methodChannel.invokeMethod('setup', {
      'iosEditImageTools': iosEditImageTools?.map((e) => e.raw).join(','),
      'iosImageAdjustTools': iosImageAdjustTools?.map((e) => e.raw).join(','),
    });
  }
}
