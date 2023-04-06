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
    
    //MARK: User Stuff
    
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
                let followers = document.get("followers") as! [String]
                let following = document.get("following") as! [String]
                let likedPosts = document.get("likedPosts") as! [String]
                let isPublic = document.get("isPublic") as! Bool
                let hasSetUsername = document.get("hasSetUsername") as! Bool
                let foundUser = User(uid: uid, username: username, email: email, productsFromSearch: productsFromSearch, productsScanned: productsScanned, productsViewed: productsViewed, likes: likes, dislikes: dislikes, favorites: favorites, allergens: allergens, recentSearches: recentSearches, anim: anim, earnedAnims: earnedAnims, fridgeItems: fridgeItems, geoPreference: geoPreference, gradePreference: gradePreference, numNutrimentsReported: numNutrimentsReported, followers: followers, following: following, likedPosts: likedPosts, isPublic: isPublic, hasSetUsername: hasSetUsername)
                completion(foundUser)
            }
        }
    }
    
    func createUser(uid: String, username: String, email: String, completion: @escaping (User?) -> ()) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.setData(["uid": uid,
                      "username": "",
                      "email": email,
                      "productsFromSearch": 0,
                      "productsScanned": 0,
                      "productsViewed": [String](),
                      "likes": [String](),
                      "dislikes": [String](),
                      "favorites": [String](),
                      "allergens": [String](),
                      "recentSearches": [String](),
                      "anim": "default",
                      "earnedAnims": [String](),
                      "fridgeItems": [String](),
                      "geoPreference": "us",
                      "gradePreference": "",
                      "numNutrimentsReported": 0,
                      "followers" : [String](),
                      "following" : [String](),
                      "likedPosts" : [String](),
                      "isPublic" : false,
                      "hasSetUsername" : false
                     ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                completion(User(uid: uid, username: username, email: email, productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default", earnedAnims: [], fridgeItems: [], geoPreference: "us", gradePreference: "", numNutrimentsReported: 0, followers: [], following: [], likedPosts: [], isPublic: false, hasSetUsername: false))
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
            "numNutrimentsReported": user.numNutrimentsReported,
            "followers" : user.followers,
            "following" : user.following,
            "likedPosts" : user.likedPosts,
            "isPublic" : user.isPublic,
            "hasSetUsername": user.hasSetUsername,
            "username" : user.username
        ])
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
    
    //MARK: Product Stuff
    
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
    
    
    //MARK: addField function
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
                            field: false
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
    
    //MARK: Creating Database FUnction
    
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
    
    
    func addProduct(addProduct: Product) {
        
        let db = Firestore.firestore()
        
        let product = db.collection("Products").document(addProduct._id!)
        
        product.getDocument { (document, error) in
            if document!.exists {
                print("product in database")
            } else {
                product.setData([
                    "_id": addProduct._id ?? "",
                    "_keywords": addProduct._keywords ?? [],
                    "allergens": addProduct.allergens ?? "none",
                    "allergens_tags": addProduct.allergens_tags ?? [],
                    "brand_owner": addProduct.brand_owner ?? "none",
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                product.updateData([
                    "brand_owner_imported": addProduct.brand_owner_imported ?? "none",
                    "brands": addProduct.brands ?? "none",
                    "brands_tags": addProduct.brands_tags ?? [],
                    "categories_hierarchy": addProduct.categories_hierarchy ?? [],
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                product.updateData([
                    "countries": addProduct.countries ?? "none",
                    "food_groups_tags": addProduct.food_groups_tags ?? [],
                    "generic_name_en": addProduct.generic_name_en ?? "none",
                    "product_name_es": addProduct.product_name_es ?? "none",
                    "product_name": addProduct.product_name ?? "none",
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                product.updateData([
                    "image_front_url": addProduct.image_front_url ?? "none",
                    "image_ingredients_url": addProduct.image_ingredients_url ?? "none",
                    "image_nutrition_url": addProduct.image_front_url ?? "none",
                    "ingredients_ids_debug": addProduct.ingredients_ids_debug ?? []
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                product.updateData([
                    "ingredients_that_may_be_from_palm_oil_n": addProduct.ingredients_that_may_be_from_palm_oil_n ?? 0,
                    "labels_old": addProduct.labels_old ?? "none",
                    "labels_tags": addProduct.labels_tags ?? [],
                    "manufacturing_places_tags": addProduct.manufacturing_places_tags ?? [],
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                product.updateData([
                    "nutriscore_grade": addProduct.nutriscore_grade ?? "none",
                    "nutriscore_score": addProduct.nutriscore_score ?? 0,
                    "origins": addProduct.origins ?? "none",
                    "packaging_tags": addProduct.packaging_tags ?? [],
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                product.updateData([
                    "product_name_en": addProduct.product_name_en ?? "none",
                    "serving_size": addProduct.serving_size ?? "none",
                    "traces_hierarchy": addProduct.traces_hierarchy ?? [],
                    "vitamins_tags": addProduct.vitamins_tags ?? [],
                    "generic_name" : "none"
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
            }
        }
    }
    
    func addNutriments(addNutriment: Nutriments, productID: String) {
        
        let db = Firestore.firestore()
        
        let nutriment = db.collection("Nutriments").document(productID)
        
        nutriment.getDocument { (document, error) in
            if document!.exists {
                print("nutriment in database")
            } else {
                nutriment.setData([
                    "calcium_serving": addNutriment.calcium_serving ?? 0.0,
                    "calcium_unit": addNutriment.calcium_unit ?? "none",
                    "carbohydrates_serving": addNutriment.carbohydrates_serving ?? 0.0,
                    "carbohydrates_unit": addNutriment.carbohydrates_unit ?? "none",
                    "cholesterol_serving": addNutriment.cholesterol_serving ?? 0.0,
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                nutriment.updateData([
                    "cholesterol_unit": addNutriment.cholesterol_unit ?? "none",
                    "energy_kcal_serving": addNutriment.energy_kcal_serving ?? 0.0,
                    "energy_unit": addNutriment.energy_unit ?? "none",
                    "fat_serving": addNutriment.fat_serving ?? 0.0,
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                nutriment.updateData([
                    "fat_unit": addNutriment.fat_unit ?? "none",
                    "saturated_fat_serving": addNutriment.saturated_fat_serving ?? 0.0,
                    "saturated_fat_unit": addNutriment.saturated_fat_unit ?? "none",
                    "trans_fat_serving": addNutriment.trans_fat_serving ?? 0.0,
                    "trans_fat_unit": addNutriment.trans_fat_unit ?? "none",
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                nutriment.updateData([
                    "fiber_serving": addNutriment.fiber_serving ?? 0.0,
                    "fiber_unit": addNutriment.fiber_unit ?? "none",
                    "iron_serving": addNutriment.iron_serving ?? 0.0,
                    "iron_unit": addNutriment.iron_unit ?? "none"
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                nutriment.updateData([
                    "proteins_serving": addNutriment.proteins_serving ?? 0.0,
                    "proteins_unit": addNutriment.proteins_unit ?? "none",
                    "salt_serving": addNutriment.salt_serving ?? 0.0,
                    "salt_unit": addNutriment.salt_unit ?? "none",
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
                
                nutriment.updateData([
                    "sodium_serving": addNutriment.sodium_serving ?? 0.0,
                    "sodium_unit": addNutriment.sodium_unit ?? "none",
                    "sugars_serving": addNutriment.sugars_serving ?? 0.0,
                    "sugars_unit": addNutriment.sugars_unit ?? "none",
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
            }
        }
    }
    
    func addNutrientLevels(nutrientLevels: NutrientLevels, productID: String) {
        
        let db = Firestore.firestore()
        
        let levels = db.collection("NutrientLevels").document(productID)
        
        levels.getDocument { (document, error) in
            if document!.exists {
                print("nutrient levels in database")
            } else {
                levels.setData([
                    "fat": nutrientLevels.fat ?? "none",
                    "salt": nutrientLevels.salt ?? "none",
                    "saturatedFat": nutrientLevels.saturatedFat ?? "none",
                    "sugars": nutrientLevels.sugars ?? "none",
                ]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    }
                }
            }
        }
    }
    
    //MARK: Social Stuff
    
    func createPost(userID: String, postID: String, contentType: String, content: String, caption: String, datePosted: Date, username: String, isPublic: Bool,completion: @escaping (Post?) -> ()) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("Posts").document(postID)
        
        user.setData(["userID": userID,
                      "postID": postID,
                      "contentType": contentType,
                      "content": content,
                      "caption": caption,
                      "datePosted": datePosted,
                      "likedBy": [String](),
                      "username" : username,
                      "numLikes": 0,
                      "isPublic" : isPublic
                     ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                completion(Post(id: postID, userID: userID, username: username, contentType: contentType, content: content, caption: caption, datePosted: datePosted, numLikes: 0, likedBy: [], isPublic: isPublic))
            }
        }
    }
    
    func deletePost(postID: String) {
        let db = Firestore.firestore()
        
        db.collection("Posts").document(postID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            }
            else {
                print("Document successfully removed!")
            }
        }
    }
    
    func createComment(userID: String, postID: String, commentID: String, content: String, datePosted: Date, username: String, completion: @escaping (Comment?) -> ()) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("Comments").document(commentID)
        
        user.setData(["userID": userID,
                      "postID": postID,
                      "commentID" : commentID,
                      "content": content,
                      "datePosted": datePosted,
                      "username" : username
                     ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                completion(Comment(id: commentID, postID: postID, userID: userID, content: content, datePosted: datePosted, username: username))
            }
        }
    }
    
    func deleteComment(commentID: String) {
        let db = Firestore.firestore()
        
        db.collection("Comments").document(commentID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            }
            else {
                print("Document successfully removed!")
            }
        }
    }
    
    
    func likePost(postID: String, userID: String) {
        
        let db = Firestore.firestore()
        
        let post = db.collection("Posts").document(postID)
        
        post.updateData([
            "numLikes": FieldValue.increment(Int64(1))
        ])
        
        post.updateData([
            "likedBy": FieldValue.arrayUnion([userID])
        ])
        
    }
    
    func unLikePost(postID: String, userID: String) {
        
        let db = Firestore.firestore()
        
        let post = db.collection("Posts").document(postID)
        
        post.updateData([
            "numLikes": FieldValue.increment(Int64(-1))
        ])
        
        post.updateData([
            "likedBy": FieldValue.arrayRemove([userID])
        ])
        
    }
    
    func getAllPosts(completion: @escaping ([Post]?) -> ()) {
        let db = Firestore.firestore()
        var allPosts = [Post]()
        db.collection("Posts")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let doc = db.collection("Posts").document(document.documentID)
                        let id = document.get("postID") as! String
                        let userID = document.get("userID") as! String
                        let contentType = document.get("contentType") as! String
                        let content = document.get("content") as! String
                        let caption = document.get("caption") as! String
                        let datePosted = document.get("datePosted") as! Timestamp
                        let numLikes = document.get("numLikes") as! Int
                        let likedBy = document.get("likedBy") as! [String]
                        let username = document.get("username") as! String
                        let isPublic = document.get("isPublic") as! Bool
                        let tempPost = Post(id: id, userID: userID, username: username, contentType: contentType, content: content, caption: caption, datePosted: datePosted.dateValue(), numLikes: numLikes, likedBy: likedBy, isPublic: isPublic)
                        if isPublic {
                            allPosts.append(tempPost)
                        }
                    }
                    completion(allPosts)
                }
            }
    }
    
    func getFollowingPosts(following: [String], completion: @escaping ([Post]?) -> ()) {
        let db = Firestore.firestore()
        var allPosts = [Post]()
        db.collection("Posts")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let doc = db.collection("Posts").document(document.documentID)
                        let id = document.get("postID") as! String
                        let userID = document.get("userID") as! String
                        let contentType = document.get("contentType") as! String
                        let content = document.get("content") as! String
                        let caption = document.get("caption") as! String
                        let datePosted = document.get("datePosted") as! Timestamp
                        let numLikes = document.get("numLikes") as! Int
                        let likedBy = document.get("likedBy") as! [String]
                        let username = document.get("username") as! String
                        let isPublic = document.get("isPublic") as! Bool
                        let tempPost = Post(id: id, userID: userID, username: username, contentType: contentType, content: content, caption: caption, datePosted: datePosted.dateValue(), numLikes: numLikes, likedBy: likedBy, isPublic: isPublic)
                        if following.contains(userID) {
                            allPosts.append(tempPost)
                        }
                    }
                    completion(allPosts)
                }
            }
    }
    
    func getPost(postID: String, completion: @escaping (Post) -> ()) {
        let db = Firestore.firestore()
        
        let post = db.collection("Posts").document(postID)
        
        post.getDocument{(document, error) in
            if let document = document, document.exists {
                let id = document.get("postID") as! String
                let userID = document.get("userID") as! String
                let contentType = document.get("contentType") as! String
                let content = document.get("content") as! String
                let caption = document.get("caption") as! String
                let datePosted = document.get("datePosted") as! Timestamp
                let numLikes = document.get("numLikes") as! Int
                let likedBy = document.get("likedBy") as! [String]
                let username = document.get("username") as! String
                let isPublic = document.get("isPublic") as! Bool
                let tempPost = Post(id: id, userID: userID, username: username, contentType: contentType, content: content, caption: caption, datePosted: datePosted.dateValue(), numLikes: numLikes, likedBy: likedBy, isPublic: isPublic)
                completion(tempPost)
            }
        }
    }
    
    func getCommentsForPost(post: String ,completion: @escaping ([Comment]?) -> ()) {
        let db = Firestore.firestore()
        var allComments = [Comment]()
        db.collection("Comments")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let id = document.get("commentID") as! String
                        let userID = document.get("userID") as! String
                        let postID = document.get("postID") as! String
                        let content = document.get("content") as! String
                        let datePosted = document.get("datePosted") as! Timestamp
                        let username = document.get("username") as! String
                        let tempComment = Comment(id: id, postID: postID, userID: userID, content: content, datePosted: datePosted.dateValue(), username: username)
                        if postID == post {
                            allComments.append(tempComment)
                        }
                    }
                    completion(allComments)
                }
            }
    }
    
    func addUsernameToArray(username: String) {
        
        let db = Firestore.firestore()
        
        let usernames = db.collection("usernames").document("7hicMTCyRJA7UlCKDXVJ")
        
        usernames.updateData([
            "usernames": FieldValue.arrayUnion([username])
        ])
        
    }
    
    
    func checkUsername(username: String, completion: @escaping (Bool) -> ()) {
        
        let db = Firestore.firestore()
        
        let usernames = db.collection("usernames").document("7hicMTCyRJA7UlCKDXVJ")
        
        var foundName = false
        
        usernames.getDocument { (document, error) in
            if let document = document {
                if let names = document.get("usernames") as? [String] {
                    if names.contains(username) {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
                
            }
        }
    }
    
    func followUser(posterID: String, followerID: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(posterID)
        
        user.updateData([
            "followers": FieldValue.arrayUnion([followerID])
        ])
        
    }
    
    func unFollowUser(posterID: String, followerID: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(posterID)
        
        user.updateData([
            "followers": FieldValue.arrayRemove([followerID])
        ])
        
    }
    
    
    func publicUser(uid: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "isPublic": true
        ])
        
        db.collection("Posts")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let postID = document.get("postID") as! String
                        let userID = document.get("userID") as! String
                        if userID == uid {
                            let temp = db.collection("Posts").document(postID)
                            
                            temp.updateData([
                                "isPublic": true
                            ])
                        }
                    }
                }
            }
    }
    
    func privateUser(uid: String) {
        
        let db = Firestore.firestore()
        
        let user = db.collection("users").document(uid)
        
        user.updateData([
            "isPublic": false
        ])
        
        db.collection("Posts")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let postID = document.get("postID") as! String
                        let userID = document.get("userID") as! String
                        if userID == uid {
                            let temp = db.collection("Posts").document(postID)
                            
                            temp.updateData([
                                "isPublic": false
                            ])
                        }
                    }
                }
            }
    }
}

