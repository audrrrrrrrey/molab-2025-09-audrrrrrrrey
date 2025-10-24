//
//  ContentView.swift
//  07 photo manipulation and arkit
//
//  Created by Audrey Guo on 10/17/25.
//
//  Ref'd https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image

import SwiftUI

struct ContentView: View {
    @State private var renderedImage = Image(systemName: "photo")
    
    var drawingView: some View {
        ZStack{
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            CanvasView()
                .allowsHitTesting(true)     //ensures we can draw
        }
    }
    
    //ui stuff
    var body: some View {
        ZStack{
            drawingView
            
            //separate overlay allows gestures and drawings to both work
            Color.clear
                .edgesIgnoringSafeArea(.all)
                .onLongPressGesture {
                    let image = drawingView.snapshot()
                    
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    
                }
        }
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

#Preview {
    ContentView()
}
