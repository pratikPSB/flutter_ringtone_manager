import 'dart:async';

import 'flutter_ringtone_manager_platform_interface.dart';
import 'ios_system_sounds.dart';

class FlutterRingtoneManager {
  /// Plays the default ringtone of the device
  /// there is one optional parameter also to play the ringtone in loop
  FutureOr<void> playRingtone({bool playInLoop = false}) {
    return FlutterRingtoneManagerPlatform.instance.playRingtone(playInLoop: playInLoop);
  }

  /// Plays the default alarm of the device
  /// there is one optional parameter also to play the ringtone in loop
  FutureOr<void> playAlarm({bool playInLoop = false}) {
    return FlutterRingtoneManagerPlatform.instance.playAlarm(playInLoop: playInLoop);
  }

  /// Plays the default notification of the device
  /// there is one optional parameter also to play the ringtone in loop
  FutureOr<void> playNotification() {
    return FlutterRingtoneManagerPlatform.instance.playNotification();
  }

  /// Plays the audio file which is located in assets folder of the root directory
  /// [assetPath] contains the [Uri] formatted [String] of the target asset
  /// there is one optional parameter also to play the ringtone in loop
  FutureOr<void> playAudioAsset(String assetPath, {bool playInLoop = false}) {
    return FlutterRingtoneManagerPlatform.instance.playAudioAsset(
      assetPath,
      playInLoop: playInLoop,
    );
  }

  /// Plays the default short sound which provides in iOS platform
  /// based on the param value of [SystemSoundID]
  /// Note: iOS SDK not provides those values as a predefined and it may change based new versions
  /// there is one optional parameter also to play the ringtone in loop
  FutureOr<void> playIosSystemSoundByID(SystemSoundID id, {bool playInLoop = false}) {
    return FlutterRingtoneManagerPlatform.instance.playIosSystemSoundByID(
      id.value,
      playInLoop: playInLoop,
    );
  }

  FutureOr<void> stop() {
    return FlutterRingtoneManagerPlatform.instance.stop();
  }

  /// gets the URI of the default sound which provides in iOS platform based on ids
  /// & for Android platform we are using three of the [SystemSoundID] to get the URIs
  /// 1. [SystemSoundID.alarm] will work in both android & ios to get the alarm sound URI
  /// 2. [SystemSoundID.newMail] will work in both android & ios to get the Ringtone sound URI
  /// 3. [SystemSoundID.smsReceived] will work in both android & ios to get the Notification sound URI
  /// Note: iOS SDK not provides those values as a predefined and it may change based new versions
  FutureOr<String?> getUriOfSystemSoundByID(SystemSoundID id) {
    return FlutterRingtoneManagerPlatform.instance.getUriOfSystemSoundByID(id.value);
  }
}
