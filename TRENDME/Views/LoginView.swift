//
//  LoginView.swift
//  TRENDME
//
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    @State private var showPass : Bool = false
    @State private var showForgotPasswordView: Bool = false
    @State var showResetView: Bool = false
    @Binding var showSignUp: Bool
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 15, content: {
            Spacer(minLength: 0)
            
            Text("Login")
                .font(.system(size: 36))
                .fontDesign(.rounded)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                
                CustomTextField(sfIcon: "at", hint: "Email", value: $loginVM.email)
                CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $loginVM.password )
                    .padding(.top, 5)
                
                Button {
                    showForgotPasswordView.toggle()
                }label: {
                    Text("Forgot Password?")
                        .font(.callout)
                        .fontDesign(.rounded)
                        .tint(.blue)
                        .hSpacing(.trailing)
                }
                
                CustomButton(title: "Sign In", icon: "arrow.right") {
                    
                    // Login logic
                    loginVM.login()
                    loginVM.getUserFromToken()
                    
                }.hSpacing(.trailing)
                    .disableWithOpacity(loginVM.email.isEmpty || loginVM.password.isEmpty)
                
                NavigationLink(destination: HomeView(), isActive: $loginVM.isAuthenticated) {
                    EmptyView()
                }
                
            }.padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button{
                    showSignUp.toggle()
                } label: {
                    Text("Sing Up")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
            }.hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        // Asking email for password resetting
        .sheet(isPresented: $showForgotPasswordView, content: {
            if #available(iOS 16.4, *) {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
            }
        })
        
        // resetting the pasword
        
        .sheet(isPresented: $showResetView, content: {
            if #available(iOS 16.4, *) {
                PasswordResetView()
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                PasswordResetView()
                    .presentationDetents([.height(300)])
            }
        })
        
        
    }
    
}

#Preview {
    LoginView(showSignUp: Binding.constant(true))
}
