//
//  CustomButton.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation
import SwiftUI

struct CustomButton : View {
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 15, content: {
                Text(title)
                Image(systemName: icon)
            })
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom), in: .capsule)
        }
    }
}

#Preview {
    CustomButton(title: "click me", icon: "arrow", onClick: {})
}


