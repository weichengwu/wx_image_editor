import 'dart:io';

import 'wx_image_editor_platform_interface.dart';

abstract class WxImageEditor {
  static Future<bool> editImage(String path) async {
    final time1 = await File(path).lastModified();
    await WxImageEditorPlatform.instance.editImage(path);
    final time2 = await File(path).lastModified();
    return time1 != time2;
  }

  static Future<void> setup({
    List<IosEditImageTool>? iosEditImageTools,
    List<IosImageAdjustTool>? iosImageAdjustTools,
  }) {
    return WxImageEditorPlatform.instance.setup(
      iosEditImageTools: iosEditImageTools,
      iosImageAdjustTools: iosImageAdjustTools,
    );
  }
}
