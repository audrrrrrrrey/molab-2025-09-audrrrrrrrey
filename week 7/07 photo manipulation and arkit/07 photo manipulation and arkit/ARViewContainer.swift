//
//  Untitled.swift
//  07 photo manipulation and arkit
//
//  Created by Audrey Guo on 10/17/25.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    typealias UIViewType = ARView
    
    
}
