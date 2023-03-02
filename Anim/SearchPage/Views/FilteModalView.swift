//
//  Filter.swift
//  Anim
//
//  Created by Manovski on 2/23/23.
//

import SwiftUI

struct FilterModalView: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    
    @State var selectedGeoFilterMessage = "Show US products only"
    
    @State var selectedGradeFilterMessage = "Select below to filter by grade"
    
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .center){
                Text(selectedGeoFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Button{
                        networkRequests.geoFilter = .world
                        selectedGeoFilterMessage = "Show products from all countries"
                    } label: {
                        GeoButton(location: "world", filterVal: networkRequests.geoFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Button{
                        networkRequests.geoFilter = .us
                        selectedGeoFilterMessage = "Show US products only"
                    } label: {
                        GeoButton(location: "us", filterVal: networkRequests.geoFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Button{
                        networkRequests.geoFilter = .es
                        selectedGeoFilterMessage = "Show Spanish products only"
                    } label: {
                        GeoButton(location: "es", filterVal: networkRequests.geoFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                }
                Text(selectedGradeFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Spacer()
                    Button{
                        networkRequests.scoreFilter = .a
                        selectedGradeFilterMessage = "Show only products with an A grade"
                    } label: {
                        if networkRequests.scoreFilter != .a {
                            GradeButton(grade: "A", noColor: true)
                        }
                        else {
                            GradeButton(grade: "A", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.scoreFilter = .b
                        selectedGradeFilterMessage = "Show only products with a B grade"
                    } label: {
                        if networkRequests.scoreFilter != .b {
                            GradeButton(grade: "B", noColor: true)
                        }
                        else {
                            GradeButton(grade: "B", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.scoreFilter = .c
                        selectedGradeFilterMessage = "Show only products with a C grade"
                    } label: {
                        if networkRequests.scoreFilter != .c {
                            GradeButton(grade: "C", noColor: true)
                        }
                        else {
                            GradeButton(grade: "C", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.scoreFilter = .d
                        selectedGradeFilterMessage = "Show only products with a D grade"
                    } label: {
                        if networkRequests.scoreFilter != .d {
                            GradeButton(grade: "D", noColor: true)
                        }
                        else {
                            GradeButton(grade: "D", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .frame(width: 200,height: 40)
                .background(Color("AnimGreen"))
                .clipShape(Capsule())
                
                Button {
                    networkRequests.geoFilter = .us
                    networkRequests.scoreFilter = .none
                    selectedGeoFilterMessage = "Show US products only"
                    selectedGradeFilterMessage = "Select below to filter by grade"
                } label: {
                    Text("Clear Filter")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(.blue)
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
    }
}

