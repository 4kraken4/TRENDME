//
//  LoginView.swift
//  TRENDME
//
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    @Namespace var animation
    var body: some View {
        VStack {
            
            Color.black.opacity(0.2)
                .ignoresSafeArea(.all)
            
            
        }
        
    }
}

#Preview {
    LoginView()
}
