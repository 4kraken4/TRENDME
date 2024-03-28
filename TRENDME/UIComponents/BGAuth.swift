//
//  BGAuth.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-26.
//

import SwiftUI

struct BGAuth: View {
    var body: some View {
        ZStack(content: {
            Circle()
                .offset(x: 150, y: -400)
                .frame(width: 200)
                .foregroundStyle(.yellow.opacity(0.8))
            
            Circle()
                .offset(x: -180, y: 400)
                .frame(width: 200)
                .foregroundStyle(.blue.opacity(0.7))
            
            Circle()
                .offset(x: -210, y: -350)
                .frame(width: 80)
                .foregroundStyle(.indigo.opacity(0.8))
            
            Circle()
                .offset(x: 110, y: 260)
                .frame(width: 45)
                .foregroundStyle(.mint.opacity(0.5))
            
            Circle()
                .offset(x: 130, y: 480)
                .frame(width:240)
                .foregroundStyle(.orange.opacity(0.9))        })
        .blur(radius: 15.0)
    }
}

#Preview {
    BGAuth()
}
