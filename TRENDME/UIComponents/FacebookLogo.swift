//
//  FacebookLogo.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-25.
//

import SwiftUI

struct FacebookLogo: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0.0625*width, y: 0.0625*height, width: 0.875*width, height: 0.875*height))
        path.move(to: CGPoint(x: 0.66293*width, y: 0.6338*height))
        path.addLine(to: CGPoint(x: 0.68236*width, y: 0.51032*height))
        path.addLine(to: CGPoint(x: 0.56079*width, y: 0.51032*height))
        path.addLine(to: CGPoint(x: 0.56079*width, y: 0.43022*height))
        path.addCurve(to: CGPoint(x: 0.63219*width, y: 0.36347*height), control1: CGPoint(x: 0.56079*width, y: 0.39643*height), control2: CGPoint(x: 0.57774*width, y: 0.36347*height))
        path.addLine(to: CGPoint(x: 0.6875*width, y: 0.36347*height))
        path.addLine(to: CGPoint(x: 0.6875*width, y: 0.25834*height))
        path.addCurve(to: CGPoint(x: 0.58938*width, y: 0.25*height), control1: CGPoint(x: 0.6875*width, y: 0.25834*height), control2: CGPoint(x: 0.63733*width, y: 0.25*height))
        path.addCurve(to: CGPoint(x: 0.4238*width, y: 0.4162*height), control1: CGPoint(x: 0.48921*width, y: 0.25*height), control2: CGPoint(x: 0.4238*width, y: 0.30915*height))
        path.addLine(to: CGPoint(x: 0.4238*width, y: 0.51032*height))
        path.addLine(to: CGPoint(x: 0.3125*width, y: 0.51032*height))
        path.addLine(to: CGPoint(x: 0.3125*width, y: 0.6338*height))
        path.addLine(to: CGPoint(x: 0.4238*width, y: 0.6338*height))
        path.addLine(to: CGPoint(x: 0.4238*width, y: 0.93233*height))
        path.addCurve(to: CGPoint(x: 0.49229*width, y: 0.9375*height), control1: CGPoint(x: 0.44615*width, y: 0.93575*height), control2: CGPoint(x: 0.46901*width, y: 0.9375*height))
        path.addCurve(to: CGPoint(x: 0.56079*width, y: 0.93233*height), control1: CGPoint(x: 0.51558*width, y: 0.9375*height), control2: CGPoint(x: 0.53844*width, y: 0.93575*height))
        path.addLine(to: CGPoint(x: 0.56079*width, y: 0.6338*height))
        path.addLine(to: CGPoint(x: 0.66293*width, y: 0.6338*height))
        path.closeSubpath()
        return path
    }
}
