// modded from jht's original by audrrrrrrrey on 10/9/25

// nav view for pages

import SwiftUI

struct BasicNav: View {
//    @State var audioRecorder = AudioRecorder()
    @Environment(AudioRecorder.self) private var audioRecorder

    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    ImageUIDemo()
                } label: {
                    Label("welcome", systemImage: "sun.min")
                }
                NavigationLink {
                    PlayAudioView()
                        .environment(audioRecorder)
                } label: {
                    Label("play audio", systemImage: "music.note")
                }
                NavigationLink {
                    RecordView()
                        .environment(audioRecorder)
                } label: {
                    Label("record audio", systemImage: "record.circle")
                }
            }
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
            .navigationTitle("music player")
            .navigationBarTitleDisplayMode(.large)
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}

#Preview {
    BasicNav()
        .environment(AudioRecorder())
}
