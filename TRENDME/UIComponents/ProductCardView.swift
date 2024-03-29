//
//  ProductCardView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI
import CoreImage
import UIKit

struct ProductCardView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    
    var product: ProductModel
    var cardColor: Color = Color.orange
    
    init(product: ProductModel) {
            self.product = product
            
            if let image = UIImage(named: product.image.replacingOccurrences(of: ".jpg", with: "")) {
                let averageColor = image.averageColor()
                let enhancedColor = averageColor.enhanced()
                self.cardColor = Color(enhancedColor)
            } else {
                self.cardColor = Color.orange // Fallback color if image is not available
            }
        }
    
    var body: some View {
        ZStack {
            
            Image(product.image.replacingOccurrences(of: ".jpg", with: ""))
                .resizable()
                .scaledToFit()
                .scaleEffect(0.8)
                .rotationEffect(Angle(degrees: 0))
                .blendMode(.multiply)
                .offset(x: 50, y: -30)
            
            ZStack {
                VStack(alignment: .leading) {
                    Text("\(product.name)")
                        .font(.system(size: 36, weight: .semibold))
                        .frame(width: 140)
                        .foregroundStyle(.white)
                        .padding(.bottom, 0)
                        .fontDesign(.rounded)
                        .blendMode(.difference)
                    
                    Text("\(product.category)")
                        .font(.callout)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.black.opacity(0.5))
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                    Spacer()
                    
                    HStack {
                        Text("$\(product.unitPrice.formatted())")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            cartVM.addToCart(product: product)
                        } label: {
                            Image(systemName: "basket")
                                .imageScale(.large)
                                .frame(width: 90, height: 68)
                                .background(.black)
                                .clipShape(.capsule)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, -10)
                    }
                    .padding(.leading)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.white.opacity(0.9))
                    .clipShape(.capsule)
                }
            }.padding(30)
                .frame(width: 336, height: 422)
        }
        .frame(width: 336, height: 422)
        .background(cardColor.opacity(0.6))
        .clipShape(.rect(cornerRadius: 57))
        .padding(.leading, 20)
    }
}

#Preview {
    ProductCardView(product: ProductModel(itemCode: "I001", name: "Cool Summer Shirt", category: "Men", unitPrice: 59.99, image: "MIG001"))
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


