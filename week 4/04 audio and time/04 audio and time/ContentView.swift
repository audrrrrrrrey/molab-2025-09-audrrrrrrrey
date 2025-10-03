//
//  ContentView.swift
//  04 audio and time
//
//  Created by Audrey Guo on 10/2/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var audioPlayer: AVAudioPlayer!
    @State private var isPlaying = false
    @State private var offset = 0.0
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom);
                
            
            VStack {
                
                Text("Tune Toy")
                    .foregroundStyle(.red)
                    .bold()
                    .font(.system(size: 50))
                                
                    
                Text("Toggle the instruments, take a listen!")
                    .foregroundStyle(.red)
                    .padding()
                
                Button {
                    AudioServicesPlaySystemSound(1025)
                    
                } label: {
                    Image(systemName: "horn.fill")
                        .foregroundStyle(.red)
                        .font(.system(size: 60))
                        .padding()
                }
                .phaseAnimator([false, true]) { content, phase in
                    content.offset(x: phase ? -1.0: 1.0)
                            }
                
                Button {
                    playSound("piano.mp3")
                    
                } label: {
                    Image(systemName: "pianokeys.inverse")
                        .foregroundStyle(.red)
                        .font(.system(size: 60))
                        .padding()
                }
                .phaseAnimator([false, true]) { content, phase in
                                content.offset(y: phase ? -1.0 : 1.0)
                            }
                
                Button {
                    playSound("guitar.mp3")

                } label: {
                    Image(systemName: "guitars.fill")
                        .foregroundStyle(.red)
                        .font(.system(size: 60))
                        .padding()
                    
                }
                .phaseAnimator([false, true]) { content, phase in
                    content.offset(x: phase ? 1.0: -1.0)
                            }
                
                Button {
                    AudioServicesPlaySystemSound(1321)
                    
                    
                } label: {
                    Image(systemName: "music.note")
                        .foregroundStyle(.red)
                        .font(.system(size: 60))
                        .padding(10)
                }
                .phaseAnimator([false, true]) { content, phase in
                                content.offset(y: phase ? 1.0 : -1.0)
                            }
            }
            
        }
        .ignoresSafeArea()
        
    }
    
    //adapted from https://www.hackingwithswift.com/forums/swiftui/playing-sound/4921
    func playSound(_ soundFileName : String) {
            guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
                fatalError("Unable to find \(soundFileName) in bundle")
            }

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print(error.localizedDescription)
            }
            audioPlayer.play()
    }
}

#Preview {
    ContentView()
}
