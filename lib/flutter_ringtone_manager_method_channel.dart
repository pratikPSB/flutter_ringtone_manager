import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'flutter_ringtone_manager_platform_interface.dart';

/// An implementation of [FlutterRingtoneManagerPlatform] that uses method channels.
class MethodChannelFlutterRingtoneManager extends FlutterRingtoneManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ringtone_manager');

  @override
  FutureOr<void> playRingtone({bool playInLoop = false}) {
    methodChannel.invokeMethod('playRingtone', {"isLoop": playInLoop});
  }

  @override
  FutureOr<void> playAlarm({bool playInLoop = false}) {
    methodChannel.invokeMethod('playAlarm', {"isLoop": playInLoop});
  }

  @override
  FutureOr<void> playNotification() {
    methodChannel.invokeMethod('playNotification');
  }

  @override
  Future<FutureOr<void>> playAudioAsset(String assetPath, {bool playInLoop = false}) async {
    final bytes = await rootBundle.load("assets/$assetPath");
    final file = File('${(await getTemporaryDirectory()).path}/$assetPath');
    await file.create(recursive: true);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    methodChannel.invokeMethod('playAudioAsset', {'uri': file.uri.path, "isLoop": playInLoop});
  }

  @override
  FutureOr<void> playIosSystemSoundByID(int id, {bool playInLoop = false}) {
    methodChannel.invokeMethod('playSystemSound', {'soundID': id, "isLoop": playInLoop});
  }

  @override
  FutureOr<void> stop() {
    methodChannel.invokeMethod('stop');
  }
}
