# flutter_ringtone_manager

A Flutter RingtoneManager (AudioManager or RingtonePlayer) allows developers to play default system sounds of the devices and custom short sound. The RingtoneManager (also known as RingtonePlayer) provides access to default ringtones, alarm & notification in `Android` and all the default short/alert sounds in iOS.

Especially this plugin seamlessly play custom sound file in both `Android & iOS` platforms.

## Key features
- Below types of the sound effect can play with this this package
  - Custom asset sound
  - Ringtone
  - Alarm
  - Notification
  - System sound by ID in iOS(default short/alert sounds)

## Getting Started
This plugin is capable of accessing all the features of native methods to play default alert/short sounds in both `Android & iOS`.

### Custom asset sound
Playing Custom sound that located under flutter `assets` folder is the key feature of this plugin as below, sound file name with its extension must be provided.
```dart
/// Mention the sub-folder name as a relative path if the file is not directly located into `assets` folder.
FlutterRingtoneManager().playAudioAsset("audio/test.mp3");

/// Mention only the filename along with its extension when the file directly locates into `assets` folder.
FlutterRingtoneManager().playAudioAsset("sample.mp3");
```
### Default alert sounds
```dart
FlutterRingtoneManager().playRingtone();
FlutterRingtoneManager().playAlarm();
FlutterRingtoneManager().playNotification();
```

### System sounds by ID in iOS
```dart
FlutterRingtoneManager().playIosSystemSoundByID(SystemSoundID.mailSent);
FlutterRingtoneManager().playIosSystemSoundByID(SystemSoundID.smsReceived);
```
#### System Sound IDs

| Enum Value                | Sound ID |
|---------------------------|----------|
| `SystemSoundID.newMail`                | 1000     |
| `SystemSoundID.mailSent`               | 1001     |
| `SystemSoundID.voicemailReceived`      | 1002     |
| `SystemSoundID.receivedMessage`        | 1003     |
| `SystemSoundID.sentMessage`            | 1004     |
| `SystemSoundID.alarm`                  | 1005     |
| `SystemSoundID.lowPower`               | 1006     |
| `SystemSoundID.smsReceived`            | 1007     |
| `SystemSoundID.smsSent`                | 1008     |
| `SystemSoundID.tweetSent`              | 1009     |
| `SystemSoundID.anticipate`             | 1010     |
| `SystemSoundID.bloom`                  | 1011     |
| `SystemSoundID.calypso`                | 1012     |
| `SystemSoundID.chooChoo`               | 1013     |
| `SystemSoundID.descent`                | 1014     |
| `SystemSoundID.fanfare`                | 1015     |
| `SystemSoundID.ladder`                 | 1016     |
| `SystemSoundID.minuet`                 | 1017     |
| `SystemSoundID.newsFlash`              | 1018     |
| `SystemSoundID.noir`                   | 1019     |
| `SystemSoundID.sherwoodForest`         | 1020     |
| `SystemSoundID.spell`                  | 1021     |
| `SystemSoundID.suspense`               | 1022     |
| `SystemSoundID.telegraph`              | 1023     |
| `SystemSoundID.tiptoes`                | 1024     |
| `SystemSoundID.typewriters`            | 1025     |
| `SystemSoundID.update`                 | 1026     |
| `SystemSoundID.ussdAlert`              | 1027     |
| `SystemSoundID.simToolkitCallDropped`  | 1028     |

### Note:
In iOS, the plugin automatically chooses the appropriate resource based on the duration of the sound, saying that it uses `AudioServices` when the sound has less than 30 seconds; otherwise, it uses `AVAudioPlayer`.

Here is the full snippet of the example program:
```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_manager/flutter_ringtone_manager.dart';
import 'package:flutter_ringtone_manager/ios_system_sounds.dart';

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
                      child: const Text("Play custom Asset")),
                  if (Platform.isIOS)
                    OutlinedButton(
                        onPressed: () {
                          _flutterRingtoneManager
                              .playIosSystemSoundByID(SystemSoundID.mailSent);
                        },
                        child: const Text("Play Notification")),
                  ElevatedButton(
                      onPressed: () => _flutterRingtoneManager.stop(),
                      style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red)),
                      child: const Text("Stop"))
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