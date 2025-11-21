//
//  HapticView.swift
//  10 haptics
//
//  Created by Audrey Guo on 11/14/25.
//

import CoreHaptics
import SwiftUI

struct HapticView: View {
    @State private var engine: CHHapticEngine?
    @State private var counter = 0
    
    var body: some View {
        //easy way to add haptics
        Button("built in haptic") {
            counter += 1
        }
        
//        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)         //standard feeling
//        .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: counter)     //soft and nice
//        .sensoryFeedback(.levelChange, trigger: counter)      //for some reason, this does nothing
//        .sensoryFeedback(.alignment, trigger: counter)        //for some reason, this does nothing
//        .sensoryFeedback(.pathComplete, trigger: counter)     //for some reason, this does nothing
//
//        .sensoryFeedback(.start, trigger: counter)            //for some reason, this does nothing
//        .sensoryFeedback(.stop, trigger: counter)             //for some reason, this does nothing
//
//        .sensoryFeedback(.success, trigger: counter)          //deep press
        .sensoryFeedback(.error, trigger: counter)            //two shakes
//        .sensoryFeedback(.warning, trigger: counter)          //like half of error
//
//        .sensoryFeedback(.increase, trigger: counter)         //very small, don't really feel like their names
//        .sensoryFeedback(.decrease, trigger: counter)
        
        
        //more controlled way
        Button("rolling haptic", action: rollingHaptic)
            .onAppear(perform: prepareHaptics)
            //must prepare haptic engine on "Awake"
        
        //test haptic
        Button("random haptic", action: randHaptic)
            .onAppear(perform: prepareHaptics)
    }
    
    //more control in adding haptics
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("there was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    //example of haptic
    func rollingHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var events = [CHHapticEvent]()
        
        //crescendo
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        //dimuendo
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1-i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1-i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: (1+i))
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print ("failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    func randHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let randIntensity: Float = Float.random(in: 0.0..<1.0)
        let randSharpness: Float = Float.random(in: 0.0..<1.0)

        var events = [CHHapticEvent]()
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: randIntensity)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: randSharpness)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print ("failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HapticView()
}
