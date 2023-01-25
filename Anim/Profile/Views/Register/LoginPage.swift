//
//  Login.swift
//  Anim
//
//  Created by Manovski on 12/6/22.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var loginData = UserViewModel()
      
    // MARK: - View
    var body: some View {
        
        ZStack {
            Image("AppIcon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            VStack(spacing: 25){
                Text("unsplash")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Spacer()
                
                SignInWithAppleButton { (request) in
                    //requesting parameters from apple login
                    loginData.nonce = randomNonceString()
                    request.requestedScopes = [.email, .fullName]
                    request.nonce = sha256(loginData.nonce)
                    
                } onCompletion: { (result) in
                    
                    
                    switch result{
                    case .success(let user):
                        print("success")
                        guard let credential  = user.credential as? ASAuthorizationAppleIDCredential else {
                            print("error with firebase")
                            return
                        }
                        loginData.authenticate(credential: credential)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .signInWithAppleButtonStyle(.white)
                .frame(height:55)
                .clipShape(Capsule())
            }
            
        }
        
//        VStack {
//            Spacer()
//            Text("LOGIN")
//                .frame(alignment: .center)
//                .font(.system(size: 30))
//                .fontWeight(.bold)
//
//            VStack(alignment: .leading, spacing: 15) {
//              TextField("Email", text: self.$email)
//                    .padding()
//              SecureField("Password", text: self.$password)
//                    .padding()
//            }
//            Text("Already have an account? Sign in")
//            Spacer()
//        }
//        .padding()
//        .frame(
//              minWidth: 0,
//              maxWidth: .infinity,
//              minHeight: 0,
//              maxHeight: .infinity
//            )
    }
}
