//
//  GestureView.swift
//  10 haptics
//
//  Created by Audrey Guo on 11/20/25.
//
//  a view i made to test out gestures. i pulled code from here to use in MotionView, but the view as a whole isn't present in the final app
//  ref'd this video https://www.hackingwithswift.com/books/ios-swiftui/how-to-use-gestures-in-swiftui

import SwiftUI
import CoreHaptics

struct GestureView: View {
    @State private var engine: CHHapticEngine?
    @State private var counter = 0
    
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State private var currentAngle = Angle.zero
    @State private var finalAngle = Angle.zero
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false

    
    var body: some View {
        

        //tap gesture demo
        Text("Double tap me")
            .font(.system(size: 36))
            .padding()
            .onTapGesture(count: 2) {
                counter += 1;
            }
            .sensoryFeedback(.success, trigger: counter)
        
        //long press demo
        Text("Long press me")
            .font(.system(size: 36))
            .padding()
            .onLongPressGesture(minimumDuration: 1) {
                counter += 1;
            }
            .sensoryFeedback(.error, trigger: counter)
        
        
        //this prints whether we're in progress of pressing or not
//        Text("Long press me")
//            .onLongPressGesture() {
//                counter += 1;
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)")
//            }
            
        //zooming with pinch
        Text("Pinch me")
            .font(.system(size: 36))
            .padding()
            .scaleEffect(currentAmount + finalAmount)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        currentAmount = value.magnification - 1
                    }
                    .onEnded { value in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: currentAmount)
        
        
        //rotation
        Text("Two finger rotate me")
            .font(.system(size: 36))
            .padding()
            .rotationEffect(currentAngle + finalAngle)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        currentAngle = value.rotation
                    }
                    .onEnded { value in
                        finalAngle += currentAngle
                        currentAngle = .zero
                    }
            )
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: currentAngle)
        
        
        //dragging with gesture chains
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in withAnimation {
                offset = .zero
                isDragging = false
                    }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 100, height: 100)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .highPriorityGesture(combined)
            .overlay(
                Text("Hold to drag me")
            )
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: isDragging)
            .padding()
    }
}

#Preview {
    GestureView()
}

//additional notes
//for children gestures wrapped inside parents gestures, use .highPriorityGesture to dictate which should override the other,
//or .simultaneousGesture to do multiple
