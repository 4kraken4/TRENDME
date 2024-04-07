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
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .frame(height: 80)
            .background(.black.opacity(0.8))
            .font(.system(size: 20, weight: .semibold))
            .fontDesign(.rounded)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 24))
        }
    }
}

#Preview {
    CustomButton(title: "click me", icon: "arrow", onClick: {})
}


