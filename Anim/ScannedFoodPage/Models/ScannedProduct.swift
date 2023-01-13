//
//  ScannedProduct.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation


import Foundation

struct ScannedBarcode: Codable {
    let code: String?
    let product: Product?
    let status: Int?
    let status_verbose: String?
}

