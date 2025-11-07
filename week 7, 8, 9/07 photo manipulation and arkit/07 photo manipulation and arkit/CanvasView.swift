//
//  CanvasView.swift
//  07 photo manipulation and arkit
//
//  Created by Audrey Guo on 10/23/25.
//
//  Used this video https://www.youtube.com/watch?v=ROxnS5ZYLFk as ref

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {    //UI view representable allows us to embed canvas view in swiftui views
    
    let toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView();
        canvasView.drawingPolicy = .anyInput    //finger and apple pencil
        canvasView.backgroundColor = .clear     //transparent
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)      //when canvas is active, show toolbar
        toolPicker.addObserver(canvasView)  //keep canvas updated with whatever tool you pick
        canvasView.becomeFirstResponder()   //so first line can work "for first responder"
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}
