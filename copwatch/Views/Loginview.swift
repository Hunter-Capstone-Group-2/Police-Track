//
//  Loginview.swift
//  copwatch
//
//  Created by Ramy on 2/23/23.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct Loginview: View {
    @Binding var currentShowingView: String
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                Color("Color").edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Text("CopWatchNYC")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
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
                            self.currentShowingView = "signup"
                        }
                        
                        
                    }) {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.5))
                        
                    }
                    
                    
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print(error)
                                return
                            }
                            // if user is authorized change view to mapview
                            if let authResult = authResult {
                                print(authResult.user.uid)
                                path.append("Mapview")
                            }
                            
                        }
                        
                    }, label: {
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
                        
                    })
                    
                    Button(action: {
                        
                        //                    let signInConfig = GIDConfiguration.init(clientID: KGoogle.clientID)
                        //
                        //                    GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                        //                    guard error == nil else { return }
                        //                    guard let user = user else { return }
                        //
                        //                    if let profiledata = user.profile {
                        //
                        //                        let userId : String = user.userID ?? ""
                        //                        let givenName : String = profiledata.givenName ?? ""
                        //                        let familyName : String = profiledata.familyName ?? ""
                        //                        let email : String = profiledata.email
                        //
                        //                        if let imgurl = user.profile?.imageURL(withDimension: 100) {
                        //                            let absoluteurl : String = imgurl.absoluteString
                        //                            //HERE CALL YOUR SERVER API
                        //                        }
                        //                    }
                        //
                        //                }
                        
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
                    
                    Button(action: {}) {
                        HStack {
                            Image("Apple Logo")
                                .resizable()
                                .frame(width: 40.0, height: 40.0)
                            Text("Continue with Apple")
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
                    
                    // sets path to mapview upon clicking
                    .navigationDestination(for: String.self) { view in
                        if view == "Mapview" {
                            Mapview()
                        }
                    }
                    
                    
                }
                
            }
        }

        .onAppear {
            // if logged in when app runs, navigate to map and skip login
            if Auth.auth().currentUser != nil {
                path.append("Mapview")
            }
        }
    }
        
}
