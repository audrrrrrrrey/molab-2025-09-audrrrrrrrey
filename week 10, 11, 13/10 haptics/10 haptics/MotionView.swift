//
//  MotionView.swift
//
//  Created by Audrey Guo on 12/4/25
//
//  MotionView creates a MotionManager to read and write the phone's accelerometer and gyroscope data, and uses that data to bounce a ball around the screen with physics. the ball is a circle with a linear gradient, overlaid with a shadow and ultraThinMaterial to give it softness. i also added two gestures: pinching the ball to enlarge/shrink it, and dragging it. both gestures, along with wall collisions, create haptic feedback using the CoreHaptics library. i also included a sound function here, but chose to remove it to allow the haptics to shine.
//
//  i created this view separately from ContentView in case i wanted to add more views, but this basically serves as ContentView...everything is in here!
//  see README.md for a full list of resources used in this project

import SwiftUI
import CoreMotion
import CoreHaptics
import AVFoundation
import Combine

// handles accelerometer and gyroscope updates
// used code from https://github.com/NDCSwift/SensorExample/blob/main/SensorExample/ContentView.swift
// also ref'd https://github.com/molab-itp/05-BubbleLevel
class MotionManager: ObservableObject {
    private let motion = CMMotionManager()  // core motion manager instance
    @Published var accelerometerData: CMAccelerometerData?      // published data for SwiftUI updates
    @Published var gyroscopeData: CMGyroData?   // published gyroscope data for SwiftUI updates
    
    init() {
        startAcceleromoterUpdates()     //start accel updates
        startGyroscopeUpdates()         //start gyroscope updates
    }

    // start accel updates
    func startAcceleromoterUpdates() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 0.1    //updates every 0.1s
            motion.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                if let data = data {
                    self?.accelerometerData = data      //update accel data
                }
            }
        }
    }

    // function to start gyroscope updates
    func startGyroscopeUpdates() {
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = 0.1             //updates every 0.1s
            motion.startGyroUpdates(to: .main) { [weak self] data, error in
                if let data = data {
                    self?.gyroscopeData = data          //update gyroscope data
                }
            }
        }
    }
}

//the big struct
//used https://www.hackingwithswift.com/books/ios-swiftui/how-to-use-gestures-in-swiftui to learn gestures
//used https://www.hackingwithswift.com/books/ios-swiftui/adding-haptic-effects to learn haptics
struct MotionView: View {
    //audio
    @State var audioPlayer: AVAudioPlayer!
    @State private var isPlaying = false
    
    //sensor data
    @StateObject private var motion = MotionManager()
    
    //haptics
    @State private var engine: CHHapticEngine?
    @State private var collisions = 0
    
    //physics
    @State private var position = CGPoint(x: 200, y: 400)
    @State private var velocity = CGPoint(x: 0, y: 0)
    @State private var smoothAccel = CGPoint(x: 0, y: 0)
    
    let baseRadius: CGFloat = 70       // base radius of the ball
    let damping: CGFloat = 0.9         // energy loss on bounce
    
    let minScale: CGFloat = 0.0        // min allowed scale
    let maxScale: CGFloat = 2.5        // max allowed scale
    
    @State private var currentScale: CGFloat = 0.0   // temporary scale during gesture
    @State private var finalScale: CGFloat = 1.0     // accumulated scale from gestures
    
    @State private var offset = CGSize.zero     //offset for dragging
    @State private var isDragging = false       //bool
    
    // combined radius considering scale
    var scaledRadius: CGFloat {
        baseRadius * (currentScale + finalScale)
    }

    //body
    var body: some View {
        GeometryReader { geo in
            ZStack {
                //colors
                let blue = Color(red: 0.4, green: 0.7, blue: 0.7)
                let cyan = Color(red: 0.2, green: 0.8, blue: 0.8)
                
                //bg
                LinearGradient(
                    colors: [cyan, blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                //dragging
                let dragGesture = DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in withAnimation {
                        offset = .zero
                        isDragging = false
                            }
                    }
                
                let pressGesture = LongPressGesture(minimumDuration: 0.1)
                    .onEnded { value in
                        withAnimation {
                            isDragging = true
                        }
                    }
                
                let combined = pressGesture.sequenced(before: dragGesture)
                
                //ball
                Circle()
                    .fill(LinearGradient(
                          gradient: .init(colors: [cyan, blue]),
                          startPoint: .init(x: 0.3, y: 0),
                          endPoint: .init(x: 0.7, y: 0.7)
                        ))
                    .overlay(
                        Circle()
//                            .stroke(Color.white.opacity(0.3), lineWidth: 1)   // glass rim
                            .fill(.ultraThinMaterial.opacity(0.3))          // translucent glass
                            
                    )
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0)
                    .frame(width: scaledRadius * 2, height: scaledRadius * 2)
                    .position(position)
                
                    //scaling gesture
//                    .scaleEffect(currentScale + finalScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                // update currentScale and clamp total scale in real time
                                let newScale = finalScale + (value - 1)
                                currentScale = (newScale).clamped(to: minScale...maxScale) - finalScale
                            }
                            .onEnded { _ in
                                // commit the scale and reset temp value
                                finalScale = (finalScale + currentScale).clamped(to: minScale...maxScale)
                                currentScale = 0
                            }
                    )
                
                    //drag gesture
                    .scaleEffect(isDragging ? 1.2 : 1)
                    .offset(offset)
                    .highPriorityGesture(combined)
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: isDragging)
                
                    //haptic when scaling
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: currentScale)
                
                    //haptic with wall collision
//                    .sensoryFeedback(.error, trigger: velocity.x.sign)
//                    .sensoryFeedback(.error, trigger: velocity.y.sign)
                    .sensoryFeedback(.error, trigger: collisions)
            }
            .onReceive(Timer.publish(every: 0.02, on: .main, in: .default).autoconnect()) { _ in
                updatePhysics(screen: geo.size)
            }
        }
        
        .ignoresSafeArea()
    }
    
    //used chatgpt as a helper here, tweaked with my own values
    func updatePhysics(screen: CGSize) {
        let dt: CGFloat = 1/60      //delta time
        let a: CGFloat = 2500       //accel
        let smooth: CGFloat = 0.2
        let friction: CGFloat = 0.99
        let bounce: CGFloat = 0.75
        let maxSpeed: CGFloat = 2500
        
        // read, smooth accel
        let ax = CGFloat(motion.accelerometerData?.acceleration.x ?? 0)
        let ay = CGFloat(-(motion.accelerometerData?.acceleration.y ?? 0))
        
        smoothAccel.x += (ax - smoothAccel.x) * smooth
        smoothAccel.y += (ay - smoothAccel.y) * smooth
        
        // apply accel, friction
        velocity.x = (velocity.x + smoothAccel.x * a * dt) * friction
        velocity.y = (velocity.y + smoothAccel.y * a * dt) * friction
        
        // clamp speed
        velocity.x = velocity.x.clamped(to: -maxSpeed...maxSpeed)
        velocity.y = velocity.y.clamped(to: -maxSpeed...maxSpeed)
        
        // move
        position.x += velocity.x * dt
        position.y += velocity.y * dt
        
        // collisions
        let minX = scaledRadius
        let maxX = screen.width - scaledRadius
        let minY = scaledRadius
        let maxY = screen.height - scaledRadius
        
        if position.x < minX || position.x > maxX {
            //former sound logic
//            let impact = abs(velocity.x)    //mag of x dir
//            playGlassSound(forImpactSpeed: impact)
            
            position.x = position.x.clamped(to: minX...maxX)
            velocity.x *= -bounce
            
            //haptics
            collisions += 1
        }
        
        if position.y < minY || position.y > maxY {
            //former sound logic
//            let impact = abs(velocity.y)    //mag of y dir
//            playGlassSound(forImpactSpeed: impact)
            
            position.y = position.y.clamped(to: minY...maxY)
            velocity.y *= -bounce
            
            //haptics
            collisions += 1
        }
    }
    
    //adapted from https://www.hackingwithswift.com/forums/swiftui/playing-sound/4921
    //(originally wanted to play sound, but it completely overshadowed the haptics! so i let it go...)
    func playGlassSound(forImpactSpeed speed: CGFloat) {
        let file = "glass1"

        guard let url = Bundle.main.url(forResource: file, withExtension: "wav") else {
            print("Missing sound file:", file)
            return
        }

        do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.enableRate = true

                // clamp speed into a usable range (tweak as needed)
                let clamped = min(max(speed, 0), 1500)

                // base pitch from impact (slow = low pitch, fast = high pitch)
                let t = clamped / 1500
                let basePitch = 0.85 + (0.40 * t)

                // small random variation so hits aren't identical
                let randomOffset = Double.random(in: -0.5...0.5)

                // final pitch range (safe + natural)
                let finalPitch = min(max(basePitch + randomOffset, 0.75), 1.35)

                audioPlayer.rate = Float(finalPitch)

                audioPlayer.prepareToPlay()
                audioPlayer.play()

            } catch {
                print("Audio error:", error.localizedDescription)
            }
    }
}

//clamp helper
extension Comparable {
    func clamped(to r: ClosedRange<Self>) -> Self {
        min(max(self, r.lowerBound), r.upperBound)
    }
}

#Preview {
    MotionView()
}
