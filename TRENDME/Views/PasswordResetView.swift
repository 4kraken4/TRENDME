//
//  PasswordResetView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import SwiftUI

struct PasswordResetView: View {
    @StateObject var passwordResetVM: PasswordResetViewModel = PasswordResetViewModel()
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
            
            Text("Reset Pasword")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            VStack(spacing: 25) {
                CustomTextField(sfIcon: "lock", hint: "New Password", isPassword: true ,value: $passwordResetVM.password)
                
                CustomTextField(sfIcon: "lock", hint: "Confirm Password", isPassword: true ,value: $passwordResetVM.password)
                    .padding(.top, 5)
                
                CustomButton(title: "Send Link", icon: "xmark") {
                    
                    // Password reset logic
                    
                    
                }.hSpacing(.trailing)
                    .disableWithOpacity(passwordResetVM.password.isEmpty || passwordResetVM.confirmPassword.isEmpty)
                    
            }.padding(.top, 20)
            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
        
    }
    
}

#Preview {
    PasswordResetView()
}
