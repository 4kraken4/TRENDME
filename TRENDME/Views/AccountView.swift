//
//  AccountView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-25.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var loginVM : LoginViewModel = LoginViewModel()
    @State private var showSignUp: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 124))
                    .foregroundStyle(.blue.opacity(0.8))
                    .background {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 170, height: 170)
                    }
                    .padding(32)
                    .clipShape(.circle)
                
                Text(loginVM.getUserName())
                    .font(.title)
                    .fontDesign(.rounded)
                
                Text(loginVM.getUserEmail())
                    .font(.footnote)
                    .fontDesign(.rounded)
                
                HStack {
                    Spacer()
                    Button {
                        loginVM.logout()
                        showSignUp = true
                    } label: {
                        Text("Sign Out")
                            .padding()
                            .font(.system(size: 16))
                            .foregroundStyle(.blue)
                    }
                    
                    NavigationLink(destination: LoginView(showSignUp: $showSignUp), isActive: $loginVM.isAuthenticated) {
                        EmptyView()
                    }
                    
                }
                
                Spacer()
            }
            .padding(.top, 64)
            .padding(.horizontal)
            .ignoresSafeArea()
        }
        .onAppear {
            
        }
    }
}

#Preview {
    AccountView()
}
