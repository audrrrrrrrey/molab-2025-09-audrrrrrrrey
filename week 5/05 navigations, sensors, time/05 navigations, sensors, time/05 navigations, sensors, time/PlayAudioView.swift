// modded from jht's original by audrrrrrrrey on 10/9/25

// create an audio player given a file stored in the app bundle
// detailed documntation on AVAudioPlayer https://developer.apple.com/documentation/avfaudio/avaudioplayer

import SwiftUI
import AVFoundation

let bundleAudio = [
    "bbc-birds-1.m4a",
    "bbc-birds-2.m4a",
    "scale-1.m4a"
];

func loadBundleAudio(_ fileName:String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: fileName, ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        return try AVAudioPlayer(contentsOf: url)
    } catch {
        print("loadBundleAudio error", error)
    }
    return nil
}

struct PlayAudioView: View {
    @State private var soundFile = bundleAudio[0]
    @State private var player: AVAudioPlayer? = nil
    @AppStorage("soundIndex") var soundIndex:Int = 0

    var body: some View {
        TimelineView(.animation) { context in
            VStack {
                HStack {
                    Button("", systemImage: "play.fill") {
                        print("Button Play")
                        player = loadBundleAudio(soundFile)
                        print("player", player as Any)
                        // Loop indefinitely
                        player?.numberOfLoops = -1
                        player?.play()
                    }
    
                    Button("", systemImage: "stop.fill") {
                        print("Button Stop")
                        player?.stop()
                    }
                    Button("", systemImage: "forward.fill") {
                        soundIndex = (soundIndex+1) % bundleAudio.count
                        soundFile = bundleAudio[soundIndex];
                    }
                }
                .padding()
                Text("\(soundFile)")
//                Text("soundIndex \(soundIndex)")
                    
                
                    
                if let player = player {
                    Text(String(format: "%.1f", player.currentTime) + " seconds through")
                        .foregroundStyle(.secondary)
                    Text(String(format: "%.1f", player.duration) + " second clip")
                        .foregroundStyle(.secondary)
                }
                    
                
            }
            
        }
    }
}

#Preview {
    PlayAudioView()
}

// https://developer.apple.com/documentation/avfaudio/avaudioplayer

// https://developer.apple.com/documentation/swiftui/state

// Source for audio clips
// https://www.youraccompanist.com/free-scales-and-warm-ups/reference-scales
// Reference Scales_On A Flat-G Sharp.mp3
// https://sound-effects.bbcrewind.co.uk/search?cat=Animals
// https://file-examples.com/index.php/sample-audio-files/sample-mp3-download/
