//
//  UserFilterModelView.swift
//  Anim
//
//  Created by Manovski on 3/4/23.
//

import SwiftUI

struct UserFilterModalView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selectedGeoFilterMessage = "Show US products only"
    
    @State var selectedGradeFilterMessage = "Select below to filter by grade"
    
    @State var selectedAllergensFilterMessage = "Filter by allergens"
    
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .center){
                Text(selectedGeoFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Button{
                        userViewModel.geoFilter = .world
                        selectedGeoFilterMessage = "Show products from all countries"
                    } label: {
                        GeoButton(location: "world", filterVal: userViewModel.geoFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Button{
                        userViewModel.geoFilter = .us
                        selectedGeoFilterMessage = "Show US products only"
                    } label: {
                        GeoButton(location: "us", filterVal: userViewModel.geoFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Button{
                        userViewModel.geoFilter = .es
                        selectedGeoFilterMessage = "Show Spanish products only"
                    } label: {
                        GeoButton(location: "es", filterVal: userViewModel.geoFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                }
                //NUTRITION GRADES
                Text(selectedGradeFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Spacer()
                    Button{
                        userViewModel.scoreFilter = .a
                        selectedGradeFilterMessage = "Show only products with an A grade"
                    } label: {
                        if userViewModel.scoreFilter != .a {
                            GradeButton(grade: "A", noColor: true)
                        }
                        else {
                            GradeButton(grade: "A", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.scoreFilter = .b
                        selectedGradeFilterMessage = "Show only products with a B grade"
                    } label: {
                        if userViewModel.scoreFilter != .b {
                            GradeButton(grade: "B", noColor: true)
                        }
                        else {
                            GradeButton(grade: "B", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.scoreFilter = .c
                        selectedGradeFilterMessage = "Show only products with a C grade"
                    } label: {
                        if userViewModel.scoreFilter != .c {
                            GradeButton(grade: "C", noColor: true)
                        }
                        else {
                            GradeButton(grade: "C", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.scoreFilter = .d
                        selectedGradeFilterMessage = "Show only products with a D grade"
                    } label: {
                        if userViewModel.scoreFilter != .d {
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
                
                //ALLERGENS
                Text(selectedAllergensFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Spacer()
                    Button{
                        userViewModel.allergenFilter = .milk
                        selectedAllergensFilterMessage = "Show products without milk"
                    } label: {
                        AllergenButton(name: "milk", filterVal: userViewModel.allergenFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.allergenFilter = .peanuts
                        selectedAllergensFilterMessage = "Show products without peanuts"
                    } label: {
                        AllergenButton(name: "peanuts", filterVal: userViewModel.allergenFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.allergenFilter = .gluten
                        selectedAllergensFilterMessage = "Show products without gluten"
                    } label: {
                        AllergenButton(name: "gluten", filterVal: userViewModel.allergenFilter.rawValue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .frame(width: 200,height: 40)
                .background(Color("AnimGreen"))
                .clipShape(Capsule())
                
                //CLEAR FILTER
                Button {
                    userViewModel.geoFilter = .us
                    userViewModel.scoreFilter = .none
                    userViewModel.allergenFilter = .none
                    selectedGeoFilterMessage = "Show US products only"
                    selectedGradeFilterMessage = "Select below to filter by grade"
                    selectedAllergensFilterMessage = "Filter by allergens"
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
        
        //toggle
        //on toggle set userViewModel.geoFilter = user.selectedGeoFilter
    }
}

