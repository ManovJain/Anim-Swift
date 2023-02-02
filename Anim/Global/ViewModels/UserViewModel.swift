//
//  UserViewModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/24/23.
//

import Foundation
import Firebase
import GoogleSignIn
import CryptoKit
import AuthenticationServices

final class UserViewModel: ObservableObject {
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var userModel: UserModel = UserModel(uid: "", username: "", email: "", productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default")
    @Published var nonce = ""
    @Published var state: SignInState = .signedOut
    @Published var test = "not changed"
    //    @AppStorage("log_status") var log_Status = false
    
    
    var firestoreRequests = FirestoreRequests()
    
    func authenticate(credential: ASAuthorizationAppleIDCredential, completion: @escaping (UserModel?) -> ()) {
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
            
            let db = Firestore.firestore()
            
            let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    self.firestoreRequests.getUser(Auth.auth().currentUser!.uid) { data in
                        completion(data!)
                    }
                } else {
                    self.firestoreRequests.createUser(uid: Auth.auth().currentUser!.uid, username: "", email: "") { data in
                        completion(data!)
                    }
                }
            }
            
            
            self.firestoreRequests.getUser(Auth.auth().currentUser!.uid) { data in
                completion(data!)
            }
        }
    }
    
    //GOOGLE SIGN IN
    func signIn(completion: @escaping (UserModel?) -> ()) {
        // 1
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                firestoreRequests.getUser(Auth.auth().currentUser!.uid) { data in
                    completion(data!)
                }
            }
        } else {
            // 2
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // 3
            let configuration = GIDConfiguration(clientID: clientID)
            
            // 4
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // 5
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                firestoreRequests.createUser(uid: Auth.auth().currentUser!.uid, username: (user?.profile?.name) ?? "", email: user?.profile?.email ?? "") { data in
                    completion(data!)
                }
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        // 1
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // 2
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        // 3
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .signedIn
            }
        }
    }
    
    func signOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
            // 2
            try Auth.auth().signOut()
            
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    //    func logGoogleUser(user: GIDGoogleUser){
    //        guard let idToken = user.idToken else {return}
    //        let accessToken = user.accessToken
    //
    //        let credential = OAuthProvider.credential(withProviderID: idToken, accessToken: accessToken)
    //
    //        try await Auth.auth().signIn(with: credential)
    //
    //        print("success")
    //    }
    
    
    
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

//Google log in helper
@available(iOS 9.0, *)
func application(_ application: UIApplication, open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any])
-> Bool {
    return GIDSignIn.sharedInstance.handle(url)
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
