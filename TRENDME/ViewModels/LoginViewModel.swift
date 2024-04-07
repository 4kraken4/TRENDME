//
//  LoginViewModel.swift
//  TRENDME
//
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var errorMessage : String = ""
    @Published var success : Bool = false
    @Published var isError : Bool = false
    @Published var isAuthenticated: Bool = false
    private let apiService = APIService.shared
    
    
    func verifyLogin () {
        if email.isEmpty || password.isEmpty {
            setError(errorMessage: "Fill in uesername and password fileds")
        }
        if !( email.lowercased() == "user" && password == "password" ) {
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
        let defaults = UserDefaults.standard
        apiService.postData(endpoint: "/auth/login", body: LoginRequest(email: email, password: password)) {
            (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let loginResponse):
                guard let token = Optional(loginResponse.token) else {
                    return
                }
                defaults.setValue(token, forKey: "token")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
