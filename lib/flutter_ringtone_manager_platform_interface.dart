import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ringtone_manager_method_channel.dart';

abstract class FlutterRingtoneManagerPlatform extends PlatformInterface {
  /// Constructs a FlutterRingtoneManagerPlatform.
  FlutterRingtoneManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterRingtoneManagerPlatform _instance =
      MethodChannelFlutterRingtoneManager();

  /// The default instance of [FlutterRingtoneManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterRingtoneManager].
  static FlutterRingtoneManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterRingtoneManagerPlatform] when
  /// they register themselves.
  static set instance(FlutterRingtoneManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  FutureOr<void> playRingtone({bool playInLoop = false}) {
    throw UnimplementedError('playRingtone() has not been implemented');
  }

  FutureOr<void> playAlarm({bool playInLoop = false}) {
    throw UnimplementedError('playAlarm() has not been implemented');
  }

  FutureOr<void> playNotification() {
    throw UnimplementedError('playNotification() has not been implemented');
  }

  FutureOr<void> playAudioAsset(String assetPath, {bool playInLoop = false}) {
    throw UnimplementedError('playAudioAsset() has not been implemented');
  }

  FutureOr<void> playIosSystemSoundByID(int id, {bool playInLoop = false}) {
    throw UnimplementedError(
        'playIosSystemSoundByID is iOS platform specific method which is not implemented');
  }

  FutureOr<void> stop() {
    throw UnimplementedError('stop() has not been implemented');
  }
}
