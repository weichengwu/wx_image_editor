import Flutter
import UIKit
import ZLImageEditor

fileprivate enum MethodNames: String {
  case editImage
  case setup
}

public class SwiftWxImageEditorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "wx_image_editor", binaryMessenger: registrar.messenger())
    let instance = SwiftWxImageEditorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
    case MethodNames.editImage.rawValue:
      editImage(path: call.arguments as? String, result: result)
    case MethodNames.setup.rawValue:
      setup(args: call.arguments, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  // MARK: methods
  
  private func editImage(path: Any?, result: @escaping FlutterResult) {
    guard let path = path as? String, let image = UIImage(contentsOfFile: path) else {
      result(FlutterError(code: "1", message: "image not found", details: nil))
      return
    }
    ZLEditImageViewController.showEditImageVC(
      parentVC: UIApplication.shared.keyWindow?.rootViewController,
      animate: true,
      image: image,
      editModel: nil
    ) { image, _ in
      try? image
        .jpegData(compressionQuality: 1)?
        .write(to: URL(fileURLWithPath: path))
      result(nil)
    }
  }
  
  private func setup(args: Any?, result: @escaping FlutterResult) {
    guard let args = args as? [String: Any] else {
      result(nil)
      return
    }
    if let iosEditImageTools = args["iosEditImageTools"] as? String {
      let editTools = iosEditImageTools
        .split(separator: ",")
        .map { $0.toZLImageEditTool }
        .filter { $0 != nil }
        .map { $0! }
      ZLImageEditorConfiguration.default().editImageTools(editTools)
    }
    if let iosImageAdjustTools = args["iosImageAdjustTools"] as? String {
      let adjustTools = iosImageAdjustTools
        .split(separator: ",")
        .map { $0.toZLImageAdjustTool }
        .filter { $0 != nil }
        .map { $0! }
      ZLImageEditorConfiguration.default().adjustTools(adjustTools)
    }
  }
}

fileprivate extension StringProtocol {
  var toZLImageEditTool: ZLImageEditorConfiguration.EditTool? {
    switch (self) {
    case "draw": return .draw
    case "clip": return .clip
    case "imageSticker": return .imageSticker
    case "textSticker": return .textSticker
    case "mosaic": return .mosaic
    case "filter": return .filter
    case "adjust": return .adjust
    default: return nil
    }
  }
  
  var toZLImageAdjustTool: ZLImageEditorConfiguration.AdjustTool? {
    switch (self) {
    case "brightness": return .brightness
    case "saturation": return .saturation
    case "contrast": return .contrast
    default: return nil
    }
  }
}
