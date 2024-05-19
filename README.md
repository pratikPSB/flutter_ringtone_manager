# flutter_ringtone_manager

A Flutter project to play default sounds of the devices such as Ringtone, Alarm, Notification and custom quick sound. RingtoneManager provides access to ringtones, notification, and other types of sounds. This plugin is capable of accessing all the features of native methods in both `Android & iOS`.

## Key features
- Four types of the sound effect can play with this this package as below
    - Ringtone
    - Alarm
    - Notification
    - Custom asset sound

## Getting Started

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_manager/flutter_ringtone_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterRingtoneManager = FlutterRingtoneManager();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
              appBar: AppBar(
                title: const Text('Plugin example app'),
              ),
              body: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                                  onPressed: () {
                                    _flutterRingtoneManager.playRingtone();
                                  },
                                  child: const Text("Play Ringtone")),
                          OutlinedButton(
                                  onPressed: () => {_flutterRingtoneManager.playAlarm()},
                                  child: const Text('Play Alarm')),
                          OutlinedButton(
                                  onPressed: () {
                                    _flutterRingtoneManager.playNotification();
                                  },
                                  child: const Text("Play Notification")),
                          ElevatedButton(
                                  onPressed: () {
                                    _flutterRingtoneManager
                                            .playAudioAsset("audio/test.mp3");
                                  },
                                  child: const Text("Play custom Asset"))
                        ],
                      ))),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }
}
```
### Feel free to contribute to this package!! 🙇‍♂️
Always happy if anyone wants to help to improve this package!

### If you need any features
Please open an issue so that we can discuss your feature request 🙏