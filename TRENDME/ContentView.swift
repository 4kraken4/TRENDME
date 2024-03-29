//
//  ContentView.swift
//  TRENDME
//

import SwiftUI

struct ContentView: View {
    @State private var showSignUp: Bool = false
    @State private var isKeyBoardShowing: Bool = false
    var body: some View {
        NavigationStack {
            LoginView(showSignUp: $showSignUp)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView(showSignUp: $showSignUp)
                }
            
            // checking for keybord showing ups
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                    if !showSignUp {
                        isKeyBoardShowing = true
                    }
                })
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                    isKeyBoardShowing = false
                })
            
        }.overlay {
            if #available(iOS 17, *) {
                CircleView()
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignUp)
            } else {
                CircleView()
                    .animation(.easeInOut(duration: 0.3), value: showSignUp)
            }
        }
    }
    
    @ViewBuilder
    func CircleView() -> some View {
        Circles()
            .scaleEffect(showSignUp ? 1.05 : 1)
            .blur(radius: showSignUp ? 20.0 : 10.0)
    }
}

#Preview {
    ContentView()
}
