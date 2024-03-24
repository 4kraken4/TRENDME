//
//  CustomTextField.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-24.
//

import SwiftUI

struct CustomTextField: View {
    var image: String = "person.crop.circle"
    var title: String = "username"
    @Binding var value: String
    var animation: Namespace.ID
    var body: some View {
        VStack(spacing: 6, content: {
            HStack (alignment:.bottom, content: {
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundStyle(.primary)
                    .frame(width: 35)
                
                VStack(alignment: .leading, spacing: 6, content: {
                    if value != "" {
                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundStyle(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                        
                        if value == "" {
                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundStyle(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                        }
                        
                        TextField("", text: $value)
                    })
                })
            })
            if value == "" {
                Divider()
            }
        })
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("txt").opacity(value != "" ? 1 : 0))
        .cornerRadius(8)
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: 5, x: 0, y: 5)
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.05), radius: 5, x: 0, y: -5)
        .padding(.horizontal)
        .padding(.top)
        .animation(.default)
    }
}
