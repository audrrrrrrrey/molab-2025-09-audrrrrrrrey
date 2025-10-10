// modded from jht's original by audrrrrrrrey on 10/9/25

// nav view for pages

import SwiftUI

struct BasicNav: View {
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
                } label: {
                    Label("let's play", systemImage: "music.note")
                }
            }
            .navigationTitle("music player")
            .navigationBarTitleDisplayMode(.large)
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}

#Preview {
    BasicNav()
}
