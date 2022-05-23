import 'wx_image_editor_platform_interface.dart';

abstract class WxImageEditor {
  static Future<void> editImage(String path) {
    return WxImageEditorPlatform.instance.editImage(path);
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
