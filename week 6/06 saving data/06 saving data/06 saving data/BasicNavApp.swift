//  music player
//  modded from jht's original ImageUiDemo-symbols demo by audrrrrrrrey on 10/9/25

import SwiftUI

@main
struct BasicNavApp: App {
    @State private var audioRecorder = AudioRecorder()

    var body: some Scene {
        WindowGroup {
            BasicNav()
                .environment(audioRecorder)
        }
    }
}
