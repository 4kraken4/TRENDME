//
//  PasswordResetViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation

class PasswordResetViewModel : ObservableObject {
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
}
