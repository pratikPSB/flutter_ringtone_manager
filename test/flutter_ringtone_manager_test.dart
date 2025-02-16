import 'dart:async';

import 'package:flutter_ringtone_manager/flutter_ringtone_manager_method_channel.dart';
import 'package:flutter_ringtone_manager/flutter_ringtone_manager_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterRingtoneManagerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterRingtoneManagerPlatform {
  @override
  FutureOr<void> playAlarm({bool playInLoop = false}) {}

  @override
  FutureOr<void> playAudioAsset(String assetPath, {bool playInLoop = false}) {}

  @override
  FutureOr<void> playNotification() {}

  @override
  FutureOr<void> playRingtone({bool playInLoop = false}) {}

  @override
  FutureOr<void> playIosSystemSoundByID(int id, {bool playInLoop = false}) {}

  @override
  FutureOr<void> stop() {}

  @override
  FutureOr<String?> getUriOfSystemSoundByID(int id) {
    return "";
  }
}

void main() {
  final FlutterRingtoneManagerPlatform initialPlatform = FlutterRingtoneManagerPlatform.instance;

  test('$MethodChannelFlutterRingtoneManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterRingtoneManager>());
  });
}
