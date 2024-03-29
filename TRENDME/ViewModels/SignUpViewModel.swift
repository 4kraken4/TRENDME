//
//  SignUpViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation

class SignUpViewModel : ObservableObject {
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var email : String = ""
    @Published var errorMessage : String = ""
    @Published var success : Bool = false
    @Published var isError : Bool = false
    
    func verifyLogin () {
        if username.isEmpty || password.isEmpty {
            setError(errorMessage: "Fill in uesername and password fileds")
        }
        if !( username.lowercased() == "user" && password == "password" ) {
            setError(errorMessage: "Username/ password incorrect. Try again!")
        } else {
            setError(errorMessage: "")
            success = true
        }
    }
    
    
    func setError(errorMessage : String) {
        if !errorMessage.isEmpty {
            isError = true
        }
        isError = false
        self.errorMessage = errorMessage
    }
    
    func login() {
        WebService().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                print(token)
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
