//
//  ContentView.swift
//  07 photo manipulation and arkit
//
//  Created by Audrey Guo on 10/17/25.
//

//  Ref'd https://www.createwithswift.com/detecting-hand-pose-with-the-vision-framework/
import SwiftUI
import AVFoundation
import Vision

// 1. Application main interface
struct ContentView: View {
    
    @State private var handPoseInfo: String = "Detecting hand poses..."
    @State private var handPoints: [CGPoint] = []
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScannerView(handPoseInfo: $handPoseInfo, handPoints: $handPoints)
            
            // Draw lines between finger joints and the wrist
            Path { path in
                let fingerJoints = [
                    [1, 2, 3, 4],    // Thumb joints (thumbCMC -> thumbMP -> thumbIP -> thumbTip)
                    [5, 6, 7, 8],    // Index finger joints
                    [9, 10, 11, 12],  // Middle finger joints
                    [13, 14, 15, 16],// Ring finger joints
                    [17, 18, 19, 20] // Little finger joints
                ]
                
                if let wristIndex = handPoints.firstIndex(where: { $0 == handPoints.first }) {
                    for joints in fingerJoints {
                        guard joints.count > 1 else { continue }

                        // Connect wrist to the first joint of each finger
                        if joints[0] < handPoints.count {
                            let firstJoint = handPoints[joints[0]]
                            let wristPoint = handPoints[wristIndex]
                            path.move(to: wristPoint)
                            path.addLine(to: firstJoint)
                        }

                        // Connect the joints within each finger
                        for i in 0..<(joints.count - 1) {
                            if joints[i] < handPoints.count && joints[i + 1] < handPoints.count {
                                let startPoint = handPoints[joints[i]]
                                let endPoint = handPoints[joints[i + 1]]
                                path.move(to: startPoint)
                                path.addLine(to: endPoint)
                            }
                        }
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 3)
            
            // Draw circles for the hand points, including the wrist
            ForEach(handPoints, id: \.self) { point in
                Circle()
                    .fill(.red)
                    .frame(width: 15)
                    .position(x: point.x, y: point.y)
            }

            Text(handPoseInfo)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom, 50)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//  Ref'd https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image
//import SwiftUI
//
//struct ContentView: View {
//    @State private var renderedImage = Image(systemName: "photo")
//    
//    var drawingView: some View {
//        ZStack{
//            ARViewContainer()
//                .edgesIgnoringSafeArea(.all)
//            CanvasView()
//                .allowsHitTesting(true)     //ensures we can draw
//        }
//    }
//    
//    //ui stuff
//    var body: some View {
//        ZStack{
//            drawingView
//            
//            //separate overlay allows gestures and drawings to both work
//            Color.clear
//                .edgesIgnoringSafeArea(.all)
//                .onLongPressGesture {
//                    let image = drawingView.snapshot()
//                    
//                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//                    
//                }
//        }
//    }
//}
//
//extension View {
//    func snapshot() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
//
//        let targetSize = controller.view.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//
//        return renderer.image { _ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
