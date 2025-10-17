//
//  ContentView.swift
//  Shared
//
//  Created by jht2 on 2/25/22.
//

import SwiftUI

struct AppStorageDemo: View {
    @AppStorage("username") var username: String = "Anonymous"
    @AppStorage("score") var score:Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome, \(username)")
            HStack {
                Button("Log in") {
                    username = "someone"
                }
                Button("Log out") {
                    username = "Anonymous"
                }
            }
            Text("Score \(score)")
            HStack {
                Button("+ Store ") {
                    score += 1
                }
                Button("- Score") {
                    score -= 1
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    AppStorageDemo()
}
