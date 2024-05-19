import Flutter
import UIKit
import AudioToolbox
import AVFoundation

public class FlutterRingtoneManagerPlugin: NSObject, FlutterPlugin {
    
    var audioPlayer: AVAudioPlayer?
    
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
                playSound(path: path)
            }
        case "playSystemSound":
        if let args = call.arguments as? [String: Any],
            let id = args["soundID"] as? Int {
                playSoundByID(id: id)
            } else {
                result(FlutterError(code: "ID_NOT_FOUND", message: "Invalid system ID provided", details: nil))
            }
        case "playRingtone":
            playSoundByID(id: 1000)
        case "playAlarm":
            playSoundByID(id: 1005)
        case "playNotification":
            playSoundByID(id: 1007)
        case "stop":
            if(audioPlayer != nil && ((audioPlayer?.isPlaying) != nil)) {
                audioPlayer?.stop()
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

  func playSoundByID(id: Int) {
      AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(id)) {
          print("play system sound finished")
      }
  }

    func playSound(path: String) {
        
        let fileURL = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            guard let duration = audioPlayer?.duration else {
                print("unable to detect duration of the sound")
                return
            }
            if(duration > 30) {
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } else {
                playShortSound(path: path)
            }
        } catch {
            print("Error: Unable to play sound, error: \(error.localizedDescription)")
        }
    }
    
    func playShortSound(path: String) {

        let fileURL = URL(fileURLWithPath: path)
        var soundID: SystemSoundID = 0
        let status = AudioServicesCreateSystemSoundID(fileURL as CFURL, &soundID)
        if status == kAudioServicesNoError {
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(soundID)) {
                print("play short sound is finished")
            }
        } else {
            print("Error: Unable to create sound ID, status: \(status)")
        }
    }
}
