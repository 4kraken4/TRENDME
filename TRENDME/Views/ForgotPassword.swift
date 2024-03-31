//
//  ForgotPassword.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import SwiftUI

struct ForgotPassword: View {
    @StateObject var signUpVM: SignUpViewModel = SignUpViewModel()
    @Binding var showResetView: Bool
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }.padding(.top, 10)
            
            Text("Forgot Pasword")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Text("Please enter your email to reset the password")
                .font(.callout)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomTextField(sfIcon: "at", hint: "Email", value: $signUpVM.email)
                    .padding(.top, 5)
                
                CustomButton(title: "Send Link", icon: "arrow.right") {
                    
                    // Logic
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        showResetView = true
                    }
                    
                    
                }.hSpacing(.trailing)
                    .disableWithOpacity(signUpVM.email.isEmpty)
                    
            }.padding(.top, 20)
            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
        
    }
    
}

#Preview {
    ForgotPassword(showResetView: Binding.constant(false))
}
