package com.weichengwu.wx_image_editor

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat.startActivityForResult
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import me.minetsh.imaging.IMGEditActivity
import java.io.File

/** WxImageEditorPlugin */
class WxImageEditorPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wx_image_editor")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "editImage" -> {
                editImage(call.arguments as String?, result)
            }
            "setup" -> {
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private var editImageResult: Result? = null
    private val editImageRequestCode = 123

    // methods

    private fun editImage(path: String?, result: Result) {
        editImageResult?.error("", "", null)
        editImageResult = null
        if (path == null) {
            result.error("", "", null)
            return
        }
        val intent = Intent(activity, IMGEditActivity::class.java)
            .putExtra(IMGEditActivity.EXTRA_IMAGE_URI, Uri.fromFile(File(path)))
            .putExtra(IMGEditActivity.EXTRA_IMAGE_SAVE_PATH, path)
        startActivityForResult(activity, intent, editImageRequestCode, null)
        editImageResult = result
    }

    // ActivityAware

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}

    // PluginRegistry.ActivityResultListener

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == editImageRequestCode) {
            editImageResult?.success(null)
            editImageResult = null
        }
        return true
    }
}
