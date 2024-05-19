package com.example.flutter_ringtone_manager

import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** FlutterRingtoneManagerPlugin */
class FlutterRingtoneManagerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context

    private lateinit var ringtoneManager: RingtoneManager

    private var ringtone: Ringtone? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_ringtone_manager")
        this.channel.setMethodCallHandler(this)
        this.context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "playRingtone" -> {
                playRingtone(result)
                result.success(null)
            }

            "playAlarm" -> {
                playAlarm(result)
                result.success(null)
            }

            "playNotification" -> {
                playNotification(result)
                result.success(null)
            }

            "playAudioAsset" -> {
                val uri = call.argument<String>("uri")
                if (uri != null) {
                    playUri(Uri.parse(uri!!), result)
                } else {
                    result.error("PLAY_FAILED", "assetPath can not be null", null)
                }
                result.success(null)
            }

            "stop" -> {
                if (ringtone?.isPlaying == true) {
                    ringtone?.stop()
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun playRingtone(result: MethodChannel.Result) {
        playUri(
            RingtoneManager.getActualDefaultRingtoneUri(context, RingtoneManager.TYPE_RINGTONE),
            result
        )
    }

    private fun playAlarm(result: MethodChannel.Result) {
        playUri(
            RingtoneManager.getActualDefaultRingtoneUri(context, RingtoneManager.TYPE_ALARM),
            result
        )
    }

    private fun playNotification(result: MethodChannel.Result) {
        playUri(
            RingtoneManager.getActualDefaultRingtoneUri(
                context,
                RingtoneManager.TYPE_NOTIFICATION
            ), result
        )
    }

    private fun playUri(uri: Uri, result: MethodChannel.Result) {
        try {
            if (ringtone != null && ringtone!!.isPlaying) {
                ringtone!!.stop()
            }
            ringtone = RingtoneManager.getRingtone(context, uri)
            ringtone?.play()
        } catch (e: Exception) {
            e.printStackTrace()
            result.error("PLAY_FAILED", "Failed to play asset sound", null)
        }
    }
}
