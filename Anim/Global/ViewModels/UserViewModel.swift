//
//  UserViewModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/24/23.
//

import Foundation
import GoogleSignIn
import CryptoKit
import AuthenticationServices
import Firebase
import FirebaseAuth

final class UserViewModel: ObservableObject {

    
    @Published var user: User?
    @Published var nonce = ""
//    @AppStorage("log_status") var log_Status = false
    
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        //getting Token
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        //Token String
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("error with Token")
            return
        }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: tokenString,
                                                        rawNonce: nonce)
        
        Auth.auth().signIn(with: credential) { (result, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            //user successfully logged into firebaes
            print("Log in success")
            print(Auth.auth().currentUser!.uid)
        }
    }
    
}

//helpers for Apple login with firebase

@available(iOS 13, *)
func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}
