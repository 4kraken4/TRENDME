//
//  ContentView.swift
//  TRENDME
//

import SwiftUI

struct ContentView: View {
    @State private var showSignUp: Bool = false
    @State private var isKeyBoardShowing: Bool = false
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom)){
            NavigationStack() {
                LoginView(showSignUp: $showSignUp)
                    .navigationDestination(isPresented: $showSignUp) {
                        SignUpView(showSignUp: $showSignUp)
                    }
                
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                        if !showSignUp {
                            isKeyBoardShowing = true
                        }
                    })
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                        isKeyBoardShowing = false
                    })
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
