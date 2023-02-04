////
////  Login.swift
//  Anim
//
//  Created by Manovski on 12/6/22.
//
import SwiftUI
import _AuthenticationServices_SwiftUI
import GoogleSignIn
import Firebase
//import GoogleSignInSwift
struct LoginPage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    
    var body: some View {
//        Spacer()
//            .frame(height: UIScreen.screenHeight/4.0)
        VStack(alignment: .center){
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .frame(width: 120, height: 120)
            Text("Welcome to Anim")
            Text("Login to continue")
            
            if(userViewModel.state == .signedOut){
                VStack{
                    //APPLE SIGN IN
                    SignInWithAppleButton { (request) in
                        //requesting parameters from apple login
                        userViewModel.nonce = randomNonceString()
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(userViewModel.nonce)
                    } onCompletion: { (result) in
                        switch result{
                        case .success(let user):
                            print("success")
                            guard let credential  = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            userViewModel.authenticate(credential: credential) { data in
                                userViewModel.userModel = data!
                                profileMenuViewModel.icon = .user
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
                            userViewModel.signIn() { data in
                                userViewModel.userModel = data!
                                profileMenuViewModel.icon = .user
                            }
                        }
                }
            }
            else {
                Button(action: {
                    userViewModel.signOut()
                    NotificationCenter.default.post(name: NSNotification.signInStateChange, object: nil) //may not need
                    profileMenuViewModel.icon = .settings
                }, label: {
                    Text("LogOut")
                })
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        
    }
    
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
