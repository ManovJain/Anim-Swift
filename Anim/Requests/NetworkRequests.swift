//
//  NetworkRequests.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/30/22.
//

import Foundation
import Alamofire
import SwiftUI


enum GradePreference: String {
    case none = ""
    case a = "&nutrition_grades_tags=a"
    case b = "&nutrition_grades_tags=b"
    case c = "&nutrition_grades_tags=c"
    case d = "&nutrition_grades_tags=d"
    case e = "&nutrition_grades_tags=e"
}

enum GeoPreference: String {
    case world = "world"
    case us = "us"
    case es = "es"
}

enum AllergenPreference: String {
    case none = "none"
    case milk = "milk"
    case gluten = "gluten"
    case soybeans = "soybeans"
    case eggs = "eggs"
    case nuts = "nuts"
    case fish = "fish"
    case mustard = "mustard"
    case peanuts = "peanuts"
}

struct AllergensList: List {
    case none = []
}

//AllergenPreference: [] {
//
//}


class NetworkRequests: ObservableObject {
    @Published var gradePreference: GradePreference = .none
    @Published var geoPreference: GeoPreference = .us
    @Published var allergenPreference: AllergenPreference = .none

    func getOpenFoodSearch(searchTerm: String, completion: @escaping (SearchResult?) -> ()) {
        let url = "https://\(geoPreference.rawValue).openfoodfacts.org/cgi/search.pl?search_terms=\(searchTerm)\(gradePreference.rawValue)&json=true"
            AF.request(url, method: .get, parameters: nil).validate(statusCode: 200 ..< 299).responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonData = try? JSONDecoder().decode(SearchResult.self, from: data)
                    completion(jsonData)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    func getFoodByBarcode(barcode: String, completion: @escaping (ScannedBarcode?) -> ()) {
            let url = "https://world.openfoodfacts.org/api/v0/product/\(barcode).json"
            AF.request(url, method: .get, parameters: nil).validate(statusCode: 200 ..< 600).responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonData = try? JSONDecoder().decode(ScannedBarcode.self, from: data)
                    completion(jsonData)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    
//    func setUserPrefs(userPrefs: Bool){
//        if userPrefs == true {
//            geoPreference = userViewModel.geoPreference
//            gradePreference = userViewModel.gradePreference
//            allergenFilter = userViewModel.allergenFilter
//        }
//        else {
//            
//        }
//        
//    }
    
}
