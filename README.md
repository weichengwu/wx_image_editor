# wx_image_editor

仿微信图片编辑控件。

依赖库：

- iOS：[longitachi/ZLImageEditor](https://github.com/longitachi/ZLImageEditor)
- Android: [minetsh/Imaging](https://github.com/minetsh/Imaging)

## Usage

```dart
// setup
WxImageEditor.setup(
  iosEditImageTools: [...],
  iosImageAdjustTools: [...],
);

// edit
final path = ... // picked image path
await WxImageEditor.editImage(path);
```