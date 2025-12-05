//
//  ContentView.swift
//  10 haptics
//
//  Created by Audrey Guo on 11/14/25.
//
//  MotionView creates a MotionManager to read and write the phone's accelerometer and gyroscope data, and uses that data to bounce a ball around the screen with physics. the ball is a circle with a linear gradient, overlaid with a shadow and ultraThinMaterial to give it softness. i also added two gestures: pinching the ball to enlarge/shrink it, and dragging it. both gestures, along with wall collisions, create haptic feedback using the CoreHaptics library. i also included a sound function here, but chose to remove it to allow the haptics to shine.
//  see README.md for a full list of resources used in this project

import SwiftUI

struct ContentView: View {
    var body: some View {
        MotionView()
    }
    
    
}

#Preview {
    ContentView()
}
