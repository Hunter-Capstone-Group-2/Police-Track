//
//  Loginview.swift
//  copwatch
//
//  Created by Ramy on 2/23/23.
//

import SwiftUI

 struct Loginview: View {
    @Binding var currentShowingView: String
     
     
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("CopwatchNYC")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email / Username", text: $email)
                    
                    Spacer()
                    
                }
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                }
                
                .padding()
                
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                }
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                }
                
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "signup"
                    }
                    
                    
                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.5))
                    
                }
                
                
                Spacer()
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color.black )
                        )
                        .padding(.horizontal )
                    
                }
                
                
            }
            
        }
    }
}

