import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wx_image_editor_method_channel.dart';

abstract class WxImageEditorPlatform extends PlatformInterface {
  /// Constructs a WxImageEditorPlatform.
  WxImageEditorPlatform() : super(token: _token);

  static final Object _token = Object();

  static WxImageEditorPlatform _instance = MethodChannelWxImageEditor();

  /// The default instance of [WxImageEditorPlatform] to use.
  ///
  /// Defaults to [MethodChannelWxImageEditor].
  static WxImageEditorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WxImageEditorPlatform] when
  /// they register themselves.
  static set instance(WxImageEditorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> editImage(String path);

  Future<void> setup({
    List<IosEditImageTool>? iosEditImageTools,
    List<IosImageAdjustTool>? iosImageAdjustTools,
  });
}

enum IosEditImageTool {
  draw('draw'),
  clip('clip'),
  imageSticker('imageSticker'),
  textSticker('textSticker'),
  mosaic('mosaic'),
  filter('filter'),
  adjust('adjust');

  final String raw;
  const IosEditImageTool(this.raw);
}

enum IosImageAdjustTool {
  brightness('brightness'),
  contrast('contrast'),
  saturation('saturation');

  final String raw;
  const IosImageAdjustTool(this.raw);
}
