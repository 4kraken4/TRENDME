//
//  ThankYouView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-07.
//

import SwiftUI

struct ThankYouView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            VStack (alignment: .center) {
                
                Image("success")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.5)
                
                
                Text("Your order has been saved")
                    .font(.title)
                    .fontDesign(.rounded)
                    .padding(.bottom, 64)
                
                
                CustomButton(title: "Next", icon: "arrow.right") {
                    
                }.hSpacing(.center)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ThankYouView()
}
