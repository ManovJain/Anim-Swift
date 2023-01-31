////
////  Login.swift
//  Anim
//
//  Created by Manovski on 12/6/22.
//
import SwiftUI
import _AuthenticationServices_SwiftUI
import GoogleSignIn
//import GoogleSignInSwift
struct LoginPage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var loginModel = UserViewModel()
    
    var body: some View {
        //        ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 15){
            Image(systemName: "triangle")
                .font(.system(size:38))
                .foregroundColor(.indigo)
            Text("welcome to Anim")
            Text("Login to continue")
            //GOOGLE SIGN IN
            GoogleSignInButton()
                .padding()
                .onTapGesture {
                    loginModel.signIn() { data in
                        userViewModel.userModel = data!
                    }
                }
            Spacer()
            //APPLE SIGN IN
            SignInWithAppleButton { (request) in
                //requesting parameters from apple login
                loginModel.nonce = randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = sha256(loginModel.nonce)
            } onCompletion: { (result) in
                switch result{
                case .success(let user):
                    print("success")
                    guard let credential  = user.credential as? ASAuthorizationAppleIDCredential else {
                        print("error with firebase")
                        return
                    }
                    loginModel.authenticate(credential: credential) { data in
                        userViewModel.userModel = data!
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(width: 200, height: 50)
            .clipShape(Capsule())
        }
    }
    
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
