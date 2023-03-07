//
//  Signupview.swift
//  copwatch
//
//  Created by Ramy on 2/23/23.
//

import SwiftUI
import FirebaseAuth
import Firebase
import GoogleSignIn

struct Signupview: View {
    @Binding var currentShowingView: String
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack{
            Color("Color 2").edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("CopWatchNYC")
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
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0) {
                        
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                        
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                }
                
                .padding()
                
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                    
                    if(password.count != 0) {
                        Image(systemName: password.isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(password.isValidPassword(password) ? .green : .red)
                    }
                    
                    
                }
                .foregroundColor(.white)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 15)
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
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            
                        }
                    }
                    
                } label: {
                    Text("Register your Account ")
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
                Button(action: {
                    
                    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                    
                    // Create Google Sign In configuration object.
                    let config = GIDConfiguration(clientID: clientID)
                    GIDSignIn.sharedInstance.configuration = config
                    
                    // Start the sign in flow!
                    GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                        guard error == nil else {
                            // ...
                            return
                        }
                        
                        guard let user = result?.user,
                              let idToken = user.idToken?.tokenString
                        else {
                            // ...
                            return
                        }
                        
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: user.accessToken.tokenString)
                        
                        Auth.auth().signIn(with: credential) { result, error in
                            guard error == nil else {
                                return
                            }
                            
                            print("Signed In")
                        }
                    }
                    
                }) {
                    HStack {
                        Image("Google Logo")
                            .resizable()
                            .frame(width: 35.0, height: 35.0)
                        Text(" Continue with Google")
                    }
                }
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
