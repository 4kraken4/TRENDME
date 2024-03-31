//
//  SignUpView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-26.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var signUpVM: SignUpViewModel = SignUpViewModel()
    @State private var showPass : Bool = false
    @Binding var showSignUp: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            Button {
                showSignUp = false
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }.padding(.top, 10)
            
            Text("Sign Up")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                
                CustomTextField(sfIcon: "person", hint: "Username", value: $signUpVM.username)
                CustomTextField(sfIcon: "at", hint: "Email", value: $signUpVM.email)
                CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $signUpVM.password )
                    .padding(.top, 5)
                
                CustomButton(title: "Sign Up", icon: "arrow.right") {
                    
                    // Sign Up Logic
                    
                    signUpVM.signUp()
                    
                }.hSpacing(.trailing)
                    .disableWithOpacity(signUpVM.email.isEmpty || signUpVM.password.isEmpty || signUpVM.username.isEmpty)
                    
            }.padding(.top, 20)
            
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button{
                    showSignUp = false
                } label: {
                    Text("Login")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
            }.hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        
    }
    
}

#Preview {
    SignUpView(showSignUp: Binding.constant(false))
}
