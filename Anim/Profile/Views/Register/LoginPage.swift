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
        Spacer()
            .frame(height: UIScreen.screenHeight/4.0)
        VStack(alignment: .center){
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .frame(width: 120, height: 120)
            Spacer()
            Text("Welcome to Anim")
            Spacer()
            Text("Login to continue")
            Spacer()
                .frame(height: 100)
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
            .frame(width: UIScreen.screenWidth - 36, height: 40)
            .clipShape(Rectangle())
            //GOOGLE SIGN IN
            GoogleSignInButton()
                .onTapGesture {
                    loginModel.signIn() { data in
                        userViewModel.userModel = data!
                    }
                }
        }
        
    }
    
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
