//
//  Extensions.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    @ViewBuilder
    func cSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
}

extension UIImage {
    func averageColor() -> UIColor {
        guard let inputImage = CIImage(image: self) else { return .clear }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return .clear }
        guard let outputImage = filter.outputImage else { return .clear }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
    }
}

extension UIColor {
    func enhanced() -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            // Check if brightness is close to white
            let threshold: CGFloat = 0.1 // Adjust the threshold as needed
            if brightness > threshold {
                // Reduce brightness to make it darker
                brightness = max(brightness - 0.01, 0.0) // Adjust the value to control darkness
            } else {
                // Otherwise, leave it unchanged
            }
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        } else {
            return self
        }
    }
}
