// modded from jht's original by audrrrrrrrey on 10/9/25

//
// Display a computed image in SwiftUI View
//  Uses UIGraphicsImageRenderer

import SwiftUI
import UIKit

struct ImageUIDemo: View {
    @AppStorage("username") var username: String = "anon"
    
    var body: some View {
        
        // display updates for debugging
        let _ = Self._printChanges()
        VStack {
            
            Text("welcome, \(username)!")
                .font(.title)
                .frame(width: 250)
                .multilineTextAlignment(.center)
            
            
            Text("your username and current song will be saved even if you close the app")
                .frame(width: 200)
                .foregroundStyle(.secondary)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(5)
            
            
            headphones
                .frame(width: 100, height: 100)
                .padding(20)
            
            login
                .padding()
        }
        
    }
    
    var headphones: some View {
        Image(systemName: "beats.headphones")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.accentColor)
    }
    
    
    var login: some View {
        VStack {
            HStack {
                Spacer()
                Spacer()
                Spacer()
                Button("log in", systemImage: "figure.strengthtraining.functional") {
                    username = "molab"
                }
                Spacer()
                Button("log out", systemImage: "figure.flexibility") {
                    username = "anon"
                }
                Spacer()
                Spacer()
                Spacer()
                
            }
            
        }
    }
}

#Preview {
    ImageUIDemo()
}
