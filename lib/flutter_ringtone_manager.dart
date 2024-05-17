import 'dart:async';

import 'flutter_ringtone_manager_platform_interface.dart';

class FlutterRingtoneManager {
  /// Plays the default ringtone of the device
  FutureOr<void> playRingtone() {
    return FlutterRingtoneManagerPlatform.instance.playRingtone();
  }

  /// Plays the default alarm of the device
  FutureOr<void> playAlarm() {
    return FlutterRingtoneManagerPlatform.instance.playAlarm();
  }

  /// Plays the default notification of the device
  FutureOr<void> playNotification() {
    return FlutterRingtoneManagerPlatform.instance.playNotification();
  }

  /// Plays the audio file which is located in assets folder of the root directory
  /// [assetPath] contains the [Uri] formatted [String] of the target asset
  FutureOr<void> playAudioAsset(String assetPath) {
    return FlutterRingtoneManagerPlatform.instance.playAudioAsset(assetPath);
  }
}
