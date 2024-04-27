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
    @Published var loggedInUserId: Int = 0
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
    
    func logout() {
        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: "token")
        self.isAuthenticated = false
    }
    
    func getUserFromToken() {
        let defaults = UserDefaults.standard
        apiService.fetchData(endpoint: "/auth/me") { (result: Result<UserModel, Error>) in
            switch result {
            case .success(let response):
                guard let userId = Optional(response.userID),
                      let userName = Optional(response.username),
                      let email = Optional(response.email)
                else {
                    return
                }
                defaults.setValue(userId, forKey: "userId")
                defaults.setValue(email, forKey: "email")
                defaults.setValue(userName, forKey: "username")
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserId() -> Int {
        return UserDefaults.standard.integer(forKey: "userId")
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: "username") ?? "SampleUser"
    }
    
    func getUserEmail() -> String {
        return UserDefaults.standard.string(forKey: "email") ?? "user@gmail.com"
    }
}
