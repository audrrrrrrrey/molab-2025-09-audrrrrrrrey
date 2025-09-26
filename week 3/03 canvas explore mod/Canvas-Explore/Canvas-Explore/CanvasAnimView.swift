//
//  CanvasAnimView.swift
//  Canvas-Explore
//
//  Created by jht2 on 1/26/25.
//  Modified by audrrrrrrrey on 9/26/25
//

import SwiftUI

// Swift implmentation of 10Print algorithm
// spiced up with a little color

// See UIGraphicsImageRenderer version:
// https://github.com/molab-itp/01-UIRender-playground / 10print save

let animInterval = 0.10; // update very tenth of a second
let ncell = 5.0
let lineWidth = 1.0
let colorSpecs = [Color.pink, Color.orange, Color.mint, Color.teal, Color.blue];

var loc = CGPoint.zero;
var nsize: CGSize = .zero;
struct PathData {
  var path: Path;
  var color: Color;
}
var paths: [PathData] = [];


struct CanvasAnimView: View {
  var body: some View {
    TimelineView(.animation(minimumInterval: animInterval)) { timeline in
      Canvas { context, size in
        // print("size", size)
        nsize = CGSize(width: size.width/ncell, height: size.width/ncell)
          
        // add a path and random color to paths array
        let path = randomSlash(loc);
        let color = colorSpecs.randomElement()!
        paths.append(PathData(path: path, color: color));
        
        // draw all the paths in paths array
        for p in paths {
          let style = StrokeStyle(lineWidth: lineWidth, lineCap: .round);
          context.stroke(p.path, with: .color(p.color), style: style)
        }
        
        // advance to next location         //changed from original to move vertically instead of horizontally
        loc.y += nsize.height;
        if loc.y > size.height {
          loc.y = 0;
          loc.x += nsize.width;
          if loc.x > size.width {
            loc.x = 0
            paths = [];
          }
        }
        // must read to trigger update
        _ = timeline.date
      }
    }
  }
}

//draw curves in random directions
func randomSlash(_ p: CGPoint) -> Path {
  var path = Path()
  let x = loc.x;
  let y = loc.y;
  let xlen = nsize.width;
  let ylen = nsize.height;
  if Bool.random() {
    // draw curve left to right
    path.move(to: CGPoint(x: x, y: y))
      path.addCurve(to: CGPoint(x: x+xlen, y: y), control1: CGPoint(x: x+(0.5*xlen), y: y+ylen), control2:CGPoint(x: x+xlen, y: y));
  }
  else {
    // draw curve right to left
    path.move(to: CGPoint(x: x+xlen, y: y))
      path.addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: x-(0.5*xlen), y: y+ylen), control2:CGPoint(x: x, y: y));
  }
  return path;
}

#Preview {
  CanvasAnimView()
}
