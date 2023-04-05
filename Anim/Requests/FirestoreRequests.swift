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
                let fridgeItems = document.get("fridgeItems") as! [String]
                let geoPreference = document.get("geoPreference") as! String
                let gradePreference = document.get("gradePreference") as! String
                let numNutrimentsReported = document.get("numNutrimentsReported") as! Int
                let foundUser = User(uid: uid, username: username, email: email, productsFromSearch: productsFromSearch, productsScanned: productsScanned, productsViewed: productsViewed, likes: likes, dislikes: dislikes, favorites: favorites, allergens: allergens, recentSearches: recentSearches, anim: anim, earnedAnims: earnedAnims, fridgeItems: fridgeItems, geoPreference: geoPreference, gradePreference: gradePreference, numNutrimentsReported: numNutrimentsReported)
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
                      "earnedAnims": [],
                      "fridgeItems": [],
                      "geoPreference": "us",
                      "gradePreference": "",
                      "numNutrimentsReported": 0]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                completion(User(uid: uid, username: username, email: email, productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default", earnedAnims: [], fridgeItems: [], geoPreference: "us", gradePreference: "", numNutrimentsReported: 0))
            }
            
        }
    }
    
    func getNutrition(_ userID: String, completion: @escaping (Nutrition?) -> ()) {
        
        let db = Firestore.firestore()
        
        let nutrition = db.collection("nutrition").document(userID)
        
        nutrition.getDocument{(document, error) in
            if let document = document, document.exists {
                let uid = document.get("uid") as! String
                let calories = document.get("calories") as! Int
                let carbs = document.get("carbs") as! Int
                let fat = document.get("fat") as! Int
                let protein = document.get("protein") as! Int
                let totalCalories = document.get("totalCalories") as! Int
                let totalCarbs = document.get("totalCarbs") as! Int
                let totalFat = document.get("totalFat") as! Int
                let totalProtein = document.get("totalProtein") as! Int
                let foundNutrition = Nutrition(uid: uid, calories: calories, carbs: carbs, fat: fat, protein: protein, totalCalories: totalCalories, totalCarbs: totalCarbs, totalFat: totalFat, totalProtein: totalProtein)
                completion(foundNutrition)
            } else {
                completion(Nutrition(uid: "", nutritionSet: false, calories: 0, carbs: 0, fat: 0, protein: 0, totalCalories: 1000, totalCarbs: 100, totalFat: 100, totalProtein: 100))
            }
        }
    }
    
    func createNutrition(uid: String, completion: @escaping (Nutrition?) -> ()){
        let db = Firestore.firestore()
        let nutrition = db.collection("nutrition").document(uid)
        
        nutrition.setData([
            "uid": uid,
            "calories": 0,
            "carbs": 0,
            "fat": 0,
            "protein": 0,
            "totalCalories": 2000,
            "totalCarbs": 100,
            "totalFat": 100,
            "totalProtein": 100]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                }
                else {
                    completion(Nutrition(uid: uid, calories: 0, carbs: 0, fat: 0, protein: 0, totalCalories: 2000, totalCarbs: 100, totalFat: 100, totalProtein: 100))
                }
            }
    }
    
    func updateNutrition(uid: String, nutrition: Nutrition) {
        let db = Firestore.firestore()
        
        let firestoreNutrition = db.collection("nutrition").document(uid)
        
        firestoreNutrition.updateData([
            "uid": uid,
            "calories": nutrition.calories!,
            "carbs": nutrition.carbs!,
            "fat": nutrition.fat!,
            "protein": nutrition.protein!,
            "totalCalories": nutrition.totalCalories!,
            "totalCarbs": nutrition.totalCarbs!,
            "totalFat": nutrition.totalFat!,
            "totalProtein": nutrition.totalProtein!
        ])
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
            "earnedAnims": user.earnedAnims,
            "fridgeItems": user.fridgeItems,
            "geoPreference": user.geoPreference,
            "gradePreference": user.gradePreference,
            "numNutrimentsReported": user.numNutrimentsReported
        ])
    }
    

    
    func addField(field: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let doc = db.collection("users").document(document.documentID)
                        doc.updateData([
                            field: 0
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }

                    }
                }
        }
    }
    
    func addMissingNutritionInfo(id: String, calories: Int, carbs: Float, cholesterol: Float, fat: Float, fiber: Float, protein: Float, sat_fat: Float, sodium: Float, sugar: Float, trans_fat: Float) {
        
        let db = Firestore.firestore()
        
        let item = db.collection("nutritionData").document(id)
        
        item.setData(["calories": calories,
                      "carbs": carbs,
                      "cholesterol": cholesterol,
                      "fat": fat,
                      "fiber": fiber,
                      "protein": protein,
                      "sat_fat": sat_fat,
                      "sodium": sodium,
                      "sugar": sugar,
                      "trans_fat": trans_fat]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
        }
    }
    
    func setGeoPreference(uid: String, geo: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "geoPreference": geo
        ])
    }
    
    func setGradePreference(uid: String, grade: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "gradePreference": grade
        ])
    }
    
    func setAllergensPreference(uid: String, allergens: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "allergens": allergens
        ])
    }
}
