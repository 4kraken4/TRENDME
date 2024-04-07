//
//  CustomTabView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-07.
//

import SwiftUI

enum Screen {
    case home
    case search
    case settings
}


final class TabRouter : ObservableObject {
    @Published var screen: Screen = .home
    
    func cahnge(to: Screen) {
        self.screen = screen
    }
}


struct CustomTabView: View {
    @StateObject var router = TabRouter()
    
    var body: some View {
        TabView(selection: $router.screen) {
            
            SearchView()
                .tag(Screen.search)
                .environmentObject(router)
                .tabItem {
                    Label("", image: "magnifyingglass")
                }
            HomeView()
                .tag(Screen.home)
                .environmentObject(router)
                .tabItem {
                    Label("", image: "house")
                }
            
            SearchView()
                .tag(Screen.search)
                .environmentObject(router)
                .tabItem {
                    Label("", image: "magnifyingglass")
                }
            
        }
    }
}

#Preview {
    CustomTabView()
}
