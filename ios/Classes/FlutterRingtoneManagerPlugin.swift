import Flutter
import UIKit
import AudioToolbox
import AVFoundation

public class FlutterRingtoneManagerPlugin: NSObject, FlutterPlugin {
    // Keeps the instance of AVAudioPlayer to handle the operation of the player
    var audioPlayer: AVAudioPlayer?
    
    // Keeps the SystemSoundID for short sounds in play mode and it refresh when a sound stop explicitly
    var soundID: SystemSoundID = 0;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_ringtone_manager",
                                           binaryMessenger: registrar.messenger())
        let instance = FlutterRingtoneManagerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "playAudioAsset":
            if let args = call.arguments as? [String: Any],
               let path = args["uri"] as? String {
                let isLoop = args["isLoop"] as? Bool ?? false
                playSound(path: path, isLoop: isLoop)
            }
        case "playSystemSound":
            if let args = call.arguments as? [String: Any],
               let id = args["soundID"] as? Int {
                let isLoop = args["isLoop"] as? Bool ?? false
                playSoundByID(id: id, isLoop: isLoop)
            } else {
                result(FlutterError(code: "ID_NOT_FOUND", message: "Invalid system ID provided", details: nil))
            }
        case "playRingtone":
            let isLoop = (call.arguments as? [String: Any])?["isLoop"] as? Bool ?? false
            playSoundByID(id: 1000, isLoop: isLoop)
        case "playAlarm":
            let isLoop = (call.arguments as? [String: Any])?["isLoop"] as? Bool ?? false
            playSoundByID(id: 1005, isLoop: isLoop)
        case "playNotification":
            let isLoop = (call.arguments as? [String: Any])?["isLoop"] as? Bool ?? false
            playSoundByID(id: 1007, isLoop: isLoop)
        case "stop":
            stop()
        case "getUriOfSystemSoundByID":
            if let args = call.arguments as? [String: Any],
               let id = args["soundID"] as? Int {
                if let soundURL = getSystemSoundPath(for: id) {
                    result(soundURL.absoluteString) // Return the URI as a string
                } else {
                    result(FlutterError(code: "ID_NOT_FOUND", message: "Invalid system sound ID provided", details: nil))
                }
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing or invalid soundID", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
//    func playSoundByID(id: Int) {
//        // Stops the player if already playing
//        stop()
//
//        soundID = SystemSoundID(id)
//        AudioServicesPlaySystemSoundWithCompletion(soundID) {
//            print("play system sound finished")
//        }
//    }

    func playSoundByID(id: Int, isLoop: Bool) {
        stop() // Stop previous sound before playing a new one

        guard let soundURL = getSystemSoundPath(for: id) else {
            print("Invalid system sound ID: \(id)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = isLoop ? -1 : 0 // Infinite loop if `isLoop` is true
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing system sound: \(error.localizedDescription)")
        }
    }

    func getSystemSoundPath(for id: Int) -> URL? {
        let systemSounds: [Int: String] = [
            1000: "/System/Library/Audio/UISounds/nano/Alarm_Nano.caf",
            1001: "/System/Library/Audio/UISounds/Modern/mail-sent.caf",
            1002: "/System/Library/Audio/UISounds/voicemail.caf",
            1003: "/System/Library/Audio/UISounds/Modern/sms-received1.caf",
            1004: "/System/Library/Audio/UISounds/Modern/sms-sent1.caf",
            1005: "/System/Library/Audio/UISounds/Modern/alarm.caf",
            1006: "/System/Library/Audio/UISounds/low_power.caf",
            1007: "/System/Library/Audio/UISounds/Modern/sms_alert_note.caf",
            1008: "/System/Library/Audio/UISounds/Modern/sms_alert_sent.caf",
            1009: "/System/Library/Audio/UISounds/Modern/tweet-sent.caf",
            1010: "/System/Library/Audio/UISounds/Anticipate.caf",
            1011: "/System/Library/Audio/UISounds/Bloom.caf",
            1012: "/System/Library/Audio/UISounds/Calypso.caf",
            1013: "/System/Library/Audio/UISounds/Choo_Choo.caf",
            1014: "/System/Library/Audio/UISounds/Descent.caf",
            1015: "/System/Library/Audio/UISounds/Fanfare.caf",
            1016: "/System/Library/Audio/UISounds/Ladder.caf",
            1017: "/System/Library/Audio/UISounds/Minuet.caf",
            1018: "/System/Library/Audio/UISounds/News_Flash.caf",
            1019: "/System/Library/Audio/UISounds/Noir.caf",
            1020: "/System/Library/Audio/UISounds/Sherwood_Forest.caf",
            1021: "/System/Library/Audio/UISounds/Spell.caf",
            1022: "/System/Library/Audio/UISounds/Suspense.caf",
            1023: "/System/Library/Audio/UISounds/Telegraph.caf",
            1024: "/System/Library/Audio/UISounds/Tiptoes.caf",
            1025: "/System/Library/Audio/UISounds/Typewriters.caf",
            1026: "/System/Library/Audio/UISounds/Update.caf",
            1027: "/System/Library/Audio/UISounds/ussd-alert.caf",
            1028: "/System/Library/Audio/UISounds/SIMToolkitCallDropped.caf"
        ]

        if let path = systemSounds[id] {
            return URL(fileURLWithPath: path)
        }
        return nil
    }

    func playSound(path: String, isLoop: Bool = false) {
        let fileURL = URL(fileURLWithPath: path)
        do {
            stop()  // Stop any currently playing sound

            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.numberOfLoops = isLoop ? -1 : 0  // Enable looping if needed
            audioPlayer?.play()
        } catch {
            print("Error: Unable to play sound, error: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        if(audioPlayer != nil && ((audioPlayer?.isPlaying) != nil)) {
            audioPlayer?.stop()
        }
        if(soundID != 0) {
            AudioServicesDisposeSystemSoundID(soundID)
            soundID = SystemSoundID(0)
        }
    }
}
