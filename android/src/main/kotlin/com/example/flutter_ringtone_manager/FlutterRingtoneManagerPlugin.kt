package com.example.flutter_ringtone_manager

import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import android.media.RingtoneManager.TYPE_ALARM
import android.media.RingtoneManager.TYPE_NOTIFICATION
import android.media.RingtoneManager.TYPE_RINGTONE
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
                val isLoop = call.argument<Boolean>("isLoop") ?: false
                playDefaultSoundByID(result, TYPE_RINGTONE, isLoop)
            }

            "playAlarm" -> {
                val isLoop = call.argument<Boolean>("isLoop") ?: false
                playDefaultSoundByID(result, TYPE_ALARM, isLoop)
            }

            "playNotification" -> {
                playDefaultSoundByID(result, TYPE_NOTIFICATION)
                result.success(null)
            }

            "playAudioAsset" -> {
                val uri = call.argument<String>("uri")
                val isLoop = call.argument<Boolean>("isLoop") ?: false
                if (uri != null) {
                    playUri(Uri.parse(uri!!), result, isLoop)
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

    private fun playDefaultSoundByID(result: MethodChannel.Result, id: Int, isLoop: Boolean = false) {
        playUri(
            RingtoneManager.getActualDefaultRingtoneUri(context, id),
            result,
            isLoop
        )
    }

    private fun playUri(uri: Uri, result: MethodChannel.Result, isLoop: Boolean) {
        try {
            if (ringtone != null && ringtone!!.isPlaying) {
                ringtone!!.stop()
            }
            ringtone = RingtoneManager.getRingtone(context, uri)
            ringtone?.isLooping = isLoop
            ringtone?.play()
        } catch (e: Exception) {
            e.printStackTrace()
            result.error("PLAY_FAILED", "Failed to play asset sound", null)
        }
    }
}
