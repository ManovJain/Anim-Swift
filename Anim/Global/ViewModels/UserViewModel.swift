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
    
    let defaults = UserDefaults.standard
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var user: User = User(uid: "", username: "", email: "", productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default")
    @Published var nutrition: Nutrition = Nutrition(uid: "", nutritionSet: false, calories: 0, carbs: 0, fat: 0, protein: 0, totalCalories: 1000, totalCarbs: 100, totalFat: 100, totalProtein: 100)
    @Published var nonce = ""
    @Published var state: SignInState = .signedOut
    @Published var test = "not changed"
    
    //USER FILTERS
    @Published var gradePreference: GradePreference = .none
    @Published var geoPreference: GeoPreference = .us
    
    
    var firestoreRequests = FirestoreRequests()
    
    func authenticate(credential: ASAuthorizationAppleIDCredential, completion: @escaping (User?) -> ()) {
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
            
            
            self.defaults.set(true, forKey: "signedIn")
            
            
            self.state = .signedIn
            
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
    func signIn(completion: @escaping (User?) -> ()) {
        // 1
        if GIDSignIn.sharedInstance.hasPreviousSignIn() && Auth.auth().currentUser != nil {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error) {
                    firestoreRequests.getUser(Auth.auth().currentUser!.uid) { data in
                        completion(data!)
                    }
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
                authenticateUser(for: user, with: error) {
                    
                    let db = Firestore.firestore()
                    
                    let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)
                    
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            self.firestoreRequests.getUser(Auth.auth().currentUser!.uid) { data in
                                completion(data!)
                            }
                        } else {
                            self.firestoreRequests.createUser(uid: Auth.auth().currentUser!.uid, username: (user?.profile?.name) ?? "", email: user?.profile?.email ?? "") { data in
                                completion(data!)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?, completion: @escaping () -> ()) {
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
                defaults.set(true, forKey: "signedIn")
                completion()
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
            self.state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteAccount() {
        
        Auth.auth().currentUser?.delete() { error in
            if let error = error {
                print(error)
            }
            else {
                self.state = .signedOut
            }
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
