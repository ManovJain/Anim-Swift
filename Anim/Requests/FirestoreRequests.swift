//
//  FirestoreRequests.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/26/23.
//

import Foundation
import Alamofire
import SwiftUI
import Firebase

class FirestoreRequests {
    
    func getUser(_ userID: String, completion: @escaping (User?) -> ()) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(userID)
        
        user.getDocument{(document, error) in
            if let document = document, document.exists {
                let uid = document.get("uid") as! String
                let username = document.get("username") as! String
                let email = document.get("email") as! String
                let productsFromSearch = document.get("productsFromSearch") as! Int
                let productsScanned = document.get("productsScanned") as! Int
                let productsViewed = document.get("productsViewed") as! [String]
                let likes = document.get("likes") as! [String]
                let dislikes = document.get("dislikes") as! [String]
                let favorites = document.get("favorites") as! [String]
                let allergens = document.get("allergens") as! [String]
                let recentSearches = document.get("recentSearches") as! [String]
                let anim = document.get("anim") as! String
                let earnedAnims = document.get("earnedAnims") as! [String]
                let foundUser = User(uid: uid, username: username, email: email, productsFromSearch: productsFromSearch, productsScanned: productsScanned, productsViewed: productsViewed, likes: likes, dislikes: dislikes, favorites: favorites, allergens: allergens, recentSearches: recentSearches, anim: anim, earnedAnims: earnedAnims)
                completion(foundUser)
            }
        }
    }
    
    func createUser(uid: String, username: String, email: String, completion: @escaping (User?) -> ()) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.setData(["uid": uid,
                      "username": username,
                      "email": email,
                      "productsFromSearch": 0,
                      "productsScanned": 0,
                      "productsViewed": [],
                      "likes": [],
                      "dislikes": [],
                      "favorites": [],
                      "allergens": [],
                      "recentSearches": [],
                      "anim": "default",
                      "earnedAnims": []]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                completion(User(uid: uid, username: username, email: email, productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default", earnedAnims: []))
            }
        }
    }
    
    func deleteAccount(uid: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            }
            else {
                print("Document successfully removed!")
            }
        }
    }
    
    func setIcon(uid: String, icon: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "anim": icon
        ])
    }
    
    func addProductScanned(uid: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "productsScanned": FieldValue.increment(Int64(1))
        ])
    }
    
    func addProductFromSearch(uid: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "productsFromSearch": FieldValue.increment(Int64(1))
        ])
    }
    
    func addBarcodeToArray(uid: String, array: String, barcode: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            array: FieldValue.arrayUnion([barcode])
        ])
    }
    
    func addBarcodeToMissing(array: String, barcode: String) {
        
        let db = Firestore.firestore()
        
        let barcode = db.collection(array).document(barcode)
        
        barcode.setData(["barcode": barcode]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
        }
                      
    }
    
    
    func removeItemFromArray(uid: String, array: String, barcode: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            array: FieldValue.arrayRemove([barcode])
        ])
    }
    
    func updateUser(uid: String, user: User) {
        let db = Firestore.firestore()
        
        let firestoreUser = db.collection("users").document(uid)
        
        firestoreUser.updateData([
            "productsFromSearch": user.productsFromSearch,
            "productsScanned": user.productsScanned,
            "productsViewed": user.productsViewed,
            "likes": user.likes,
            "dislikes": user.dislikes,
            "favorites": user.favorites,
            "allergens": user.allergens,
            "recentSearches": user.recentSearches,
            "anim": user.anim,
            "earnedAnims": user.earnedAnims
        ])
    }
}
