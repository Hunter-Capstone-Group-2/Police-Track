//
//  Signupview.swift
//  copwatch
//
//  Created by Ramy on 2/23/23.
//

import SwiftUI

struct Signupview: View {
    @Binding var currentShowingView: String
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack{
            Color.black .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("Create An Account")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
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
                .foregroundColor(.white)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                }
                
                .padding()
                
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                }
                
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                    
                }) {
                    Text("Already have an account? ")
                        .foregroundColor(.gray)
                    
                }
                
                
                
                
                Spacer()
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Register ")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color.white)
                        )
                        .padding(.horizontal )
                    
                }
                
                
            }
            
        }
    }
}

