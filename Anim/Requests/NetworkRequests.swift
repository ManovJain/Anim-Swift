//
//  NetworkRequests.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/30/22.
//

import Foundation
import Alamofire
import SwiftUI


class NetworkRequests: ObservableObject {
    
//    func getFoodSearch(searchTerm: String, completion: @escaping (SearchResult?) -> ()) {
//        let url = "https://api.jsonbin.io/v3/qs/63900bab962da34f5389ac91"
//        AF.request(url, method: .get, parameters: nil).validate(statusCode: 200 ..< 299).responseData { response in
//            switch response.result {
//            case .success(let data):
//                let jsonData = try? JSONDecoder().decode(SearchResultsTemp.self, from: data).record
//                completion(jsonData)
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func getOpenFoodSearch(searchTerm: String, completion: @escaping (SearchResult?) -> ()) {
//            let url = "https://us.openfoodfacts.org/cgi/search.pl?action=process&tagtype_0=categories&tag_contains_0=contains&tag_0=\(searchTerm)&json=true"
        let url = "https://us.openfoodfacts.org/cgi/search.pl?search_terms=\(searchTerm)&json=true"
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
            AF.request(url, method: .get, parameters: nil).validate(statusCode: 200 ..< 299).responseData { response in
                switch response.result {
                case .success(let data):
                    let jsonData = try? JSONDecoder().decode(ScannedBarcode.self, from: data)
                    completion(jsonData)
                    
                case .failure(let error):
                    print("it didnt' worked")
                    print(error)
                }
            }
        }
    
}
