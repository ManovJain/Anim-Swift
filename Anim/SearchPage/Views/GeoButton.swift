//
//  Geo.swift
//  Anim
//
//  Created by Manovski on 2/26/23.
//

import SwiftUI


struct GeoButton: View {
    
    var location: String
    var filterVal: String
    
    
    var body: some View {
        Text(getLocation(location: location))
            .font(Font.custom("DMSans-Medium", size: 15))
            .padding(5)
            .background(filterColor(location: location, filterVal: filterVal))
            .clipShape(Circle())
            .foregroundColor(.primary)
    }
    
    func getLocation(location: String) -> String {
        if location == "us" {
            return "πΊπΈ"
        }
        else if location == "es"{
            return "πͺπΈ"
        }
        else {
            return "π"
        }
    }
    
    func filterColor(location: String, filterVal: String) -> Color{
        if filterVal == location {
            return Color("AnimGreen")
        }
        else {
            return Color.white
        }
    }
}
