//
//  Blob.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-23.
//

import SwiftUI

struct Blob: Shape, View {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // Define control points for the blob shape
            let width = rect.width
            let height = rect.height
            let midWidth = width / 2
            let midHeight = height / 2
            
            // Start from the top-left corner
            path.move(to: CGPoint(x: midWidth, y: 0))
            
            // Add curves to create a blob shape
            path.addQuadCurve(to: CGPoint(x: width, y: midHeight), control: CGPoint(x: midWidth, y: -midHeight))
            path.addQuadCurve(to: CGPoint(x: midWidth, y: height), control: CGPoint(x: width + midWidth, y: midHeight * 2))
            path.addQuadCurve(to: CGPoint(x: 0, y: midHeight), control: CGPoint(x: midWidth, y: height + midHeight))
            path.addQuadCurve(to: CGPoint(x: midWidth, y: 0), control: CGPoint(x: -midWidth, y: midHeight * 3))
            
            return path
        }
}

#Preview {
    Blob()
}
