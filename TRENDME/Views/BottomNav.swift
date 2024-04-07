//
//  BottomNav.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-06.
//

import SwiftUI

enum Tab : String, CaseIterable {
    case gear
    case home = "house"
    case search = "magnifyingglass"
}


struct BottomNav: View {
    
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue
    }
    
    var body: some View {
        VStack  {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) {tab in
                    Spacer()
                    
                    Image(systemName: tab == selectedTab ? fillImage : tab.rawValue)
                        .font(.system(size: 22))
                        .scaleEffect(tab == selectedTab ? 1.3 : 1)
                        .foregroundStyle(tab == selectedTab ? .blue : .gray)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    
                    Spacer()
                }
                
            }
            .frame(width: nil, height: 84)
            .background(.thinMaterial)
            .cornerRadius(24)
        }
    }
}

#Preview {
    BottomNav(selectedTab: Binding.constant(Tab.search))
}
