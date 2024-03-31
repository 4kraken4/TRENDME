//
//  ProductCardViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-31.
//

import Foundation
import SwiftUI
import Kingfisher

class ProductCardViewModel: ObservableObject {
    @Published var cardColor: Color = .white
    private let zoomFactor: CGFloat = 4
    
    func loadImage(from imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        let resource = KF.ImageResource(downloadURL: url)
        let imageView = UIImageView()
        imageView.kf.setImage(with: resource) { result in
            switch result {
            case .success(let imageResult):
                let zoomedRect = CGRect(x: 0, y: 0, width: imageResult.image.size.width * self.zoomFactor, height: imageResult.image.size.height * self.zoomFactor)
                UIGraphicsBeginImageContextWithOptions(zoomedRect.size, false, 0.0)
                imageResult.image.draw(in: zoomedRect)
                let zoomedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                if let zoomedImage = zoomedImage {
                    let averageColor = zoomedImage.averageColor()
                    let enhancedColor = averageColor.enhanced()
                    DispatchQueue.main.async {
                        self.cardColor = Color(enhancedColor)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.cardColor = Color.black.opacity(0.3) // Fallback color if image is not available
                    }
                }
            case .failure(let error):
                print("Error loading image: \(error)")
                DispatchQueue.main.async {
                    self.cardColor = Color.black.opacity(0.3) // Fallback color if image loading fails
                }
            }
        }
    }
}
