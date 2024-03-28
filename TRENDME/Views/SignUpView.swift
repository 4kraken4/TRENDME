//
//  SignUpView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-26.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    @Namespace var animation
    @State private var showPass : Bool = false
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            
            Color.Neumorphic.main.ignoresSafeArea(.all)
            
            
            BGAuth()
            
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40, content: {
                
                //                 Login controls
                VStack (alignment: .center, spacing: 2, content: {
                    HStack(spacing: 32, content: {
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.primary.opacity(0.8))
                            .frame(width: 32)
                            .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        VStack(spacing: 6, content: {
                            TextField("Username", text: $loginVM.username)
                                .multilineTextAlignment(.leading)
                                .mask(alignment: .leading) {
                                    Capsule()
                                        .frame(width: 270, height: 45)
                                        .offset(x: -5)
                                }
                        })
                    })
                    .padding(.all)
                    .background(Color.Neumorphic.main)
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .softOuterShadow()
                    
                    
                    HStack(spacing: 32, content: {
                        
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.primary.opacity(0.8))
                            .frame(width: 32)
                            .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        VStack(spacing: 6, content: {
                            TextField("Email", text: $loginVM.username)
                                .multilineTextAlignment(.leading)
                                .mask(alignment: .leading) {
                                    Capsule()
                                        .frame(width: 270, height: 45)
                                        .offset(x: -5)
                                }
                        })
                    })
                    .padding(.all)
                    .background(Color.Neumorphic.main)
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .softOuterShadow()
                    
                    
                    
                    HStack(spacing: 32, content: {
                        
                        Image(systemName: "lock.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.primary.opacity(0.8))
                            .frame(width: 32)
                            .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        
                        VStack(spacing: 6, content: {
                            SecureField("Password", text: $loginVM.password)
                                .multilineTextAlignment(.leading)
                                .mask(alignment: .leading) {
                                    Capsule()
                                        .frame(width: 240, height: 45)
                                        .offset(x: -20)
                                }
                            
                            
                        }).overlay(alignment: .trailing) {
                            Image(systemName: showPass ? "eye.slash.fill" : "eye.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(showPass ? Color.primary.opacity(0.8) : Color.red.opacity(0.6))
                                .onTapGesture {
                                    showPass.toggle()
                                }
                        }
                        
                    })
                    .padding(.all)
                    .background(Color.Neumorphic.main)
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .softOuterShadow()
                })
                
                //                 Devider
                VStack( alignment: .center, spacing: 0, content: {
                    
                    Divider()
                        .padding(.vertical, 1)
                        .overlay {
                            Capsule()
                                .foregroundStyle(.gray.opacity(0.1))
                        }
                        .padding(.horizontal, 50)
                        .overlay {
                            Capsule()
                                .frame(width: 140, height: 32)
                                .foregroundStyle(Color.Neumorphic.main)
                                .overlay {
                                    Text("Social Logins")
                                        .fontWeight(.light)
                                        .foregroundStyle(.gray.opacity(0.5))
                                        .fontDesign(.rounded)
                                        .tracking(1.5)
                                }
                        }
                })
                
                //                 Social logins
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 32, content: {
                    Button(action: {}, label: {
                        FacebookLogo()
                            .frame(width: 38, height: 38)
                            .padding(0)
                    })
                    .softButtonStyle(Circle(), mainColor: Color.Neumorphic.main, textColor: Color.blue, pressedEffect: .flat)
                    .padding(0)
                    
                    
                    Button(action: {}, label: {
                        FacebookLogo()
                            .frame(width: 38, height: 38)
                            .padding(0)
                    })
                    .softButtonStyle(Circle(), mainColor: Color.Neumorphic.main, textColor: Color.blue, pressedEffect: .flat)
                    .padding(0)
                    
                    
                    Button(action: {}, label: {
                        FacebookLogo()
                            .frame(width: 38, height: 38)
                            .padding(0)
                    })
                    .softButtonStyle(Circle(), mainColor: Color.Neumorphic.main, textColor: Color.blue, pressedEffect: .flat)
                    .padding(0)
                })
                
            })
            
            
        })
        
    }
}

#Preview {
    SignUpView()
}
