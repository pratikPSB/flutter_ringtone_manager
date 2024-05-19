import 'dart:async';

import 'flutter_ringtone_manager_platform_interface.dart';
import 'ios_system_sounds.dart';

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

  /// Plays the default short sound which provides in iOS platform
  /// based on the param value of [SystemSoundID]
  /// Note: iOS SDK not provides those values as a predefined and it may change based new versions
  FutureOr<void> playIosSystemSoundByID(SystemSoundID id) {
    return FlutterRingtoneManagerPlatform.instance
        .playIosSystemSoundByID(id.value);
  }
}
