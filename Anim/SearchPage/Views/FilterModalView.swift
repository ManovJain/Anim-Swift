//
//  Filter.swift
//  Anim
//
//  Created by Manovski on 2/23/23.
//

import SwiftUI

struct FilterModalView: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selectedgeoPreferenceMessage = "Show US products only"
    
    @State var selectedGradeFilterMessage = "Select below to filter by grade"
    
    @State var selectedAllergensFilterMessage = "Filter by allergens"
    
    @State var userPrefs: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .center){
                Text(selectedgeoPreferenceMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Button{
                        networkRequests.geoPreference = .world
                        selectedgeoPreferenceMessage = "Show products from all countries"
                    } label: {
                        GeoButton(location: "world", filterVal: networkRequests.geoPreference.rawValue)
                    }
                    .buttonStyle(.plain)
                    Button{
                        networkRequests.geoPreference = .us
                        selectedgeoPreferenceMessage = "Show US products only"
                    } label: {
                        GeoButton(location: "us", filterVal: networkRequests.geoPreference.rawValue)
                    }
                    .buttonStyle(.plain)
                    Button{
                        networkRequests.geoPreference = .es
                        selectedgeoPreferenceMessage = "Show Spanish products only"
                    } label: {
                        GeoButton(location: "es", filterVal: networkRequests.geoPreference.rawValue)
                    }
                    .buttonStyle(.plain)
                }
                //NUTRITION GRADES
                Text(selectedGradeFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Spacer()
                    Button{
                        networkRequests.gradePreference = .a
                        selectedGradeFilterMessage = "Show only products with an A grade"
                    } label: {
                        if networkRequests.gradePreference != .a {
                            GradeButton(grade: "A", noColor: true)
                        }
                        else {
                            GradeButton(grade: "A", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.gradePreference = .b
                        selectedGradeFilterMessage = "Show only products with a B grade"
                    } label: {
                        if networkRequests.gradePreference != .b {
                            GradeButton(grade: "B", noColor: true)
                        }
                        else {
                            GradeButton(grade: "B", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.gradePreference = .c
                        selectedGradeFilterMessage = "Show only products with a C grade"
                    } label: {
                        if networkRequests.gradePreference != .c {
                            GradeButton(grade: "C", noColor: true)
                        }
                        else {
                            GradeButton(grade: "C", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.gradePreference = .d
                        selectedGradeFilterMessage = "Show only products with a D grade"
                    } label: {
                        if networkRequests.gradePreference != .d {
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
                        networkRequests.allergenPreference = .milk
                        selectedAllergensFilterMessage = "Show products without milk"
                    } label: {
                        AllergenButton(name: "milk", filterVal: networkRequests.allergenPreference.rawValue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.allergenPreference = .peanuts
                        selectedAllergensFilterMessage = "Show products without peanuts"
                    } label: {
                        AllergenButton(name: "peanuts", filterVal: networkRequests.allergenPreference.rawValue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        networkRequests.allergenPreference = .gluten
                        selectedAllergensFilterMessage = "Show products without gluten"
                    } label: {
                        AllergenButton(name: "gluten", filterVal: networkRequests.allergenPreference.rawValue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .frame(width: 200,height: 40)
                .background(Color("AnimGreen"))
                .clipShape(Capsule())
                
                //CLEAR FILTER
                Button {
                    setUserPrefs(userPrefs: false)
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
        //on toggle set networkRequests.geoPreference = user.selectedgeoPreference
        Toggle("Use user's preferences", isOn: $userPrefs)
            .onChange(of: userPrefs){ value in
                networkRequests.geoPreference = userViewModel.geoPreference
                networkRequests.gradePreference = userViewModel.gradePreference
                networkRequests.allergenPreference = userViewModel.allergenPreference
                setUserPrefs(userPrefs: userPrefs)
                print("user values set")
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("AnimGreen")))
    }
    func setUserPrefs(userPrefs: Bool){
        if userPrefs == true {
            networkRequests.geoPreference = userViewModel.geoPreference
            networkRequests.gradePreference = userViewModel.gradePreference
            networkRequests.allergenPreference = userViewModel.allergenPreference
        }
        else {
            networkRequests.geoPreference = .us
            networkRequests.gradePreference = .none
            networkRequests.allergenPreference = .none
            selectedgeoPreferenceMessage = "Show US products only"
            selectedGradeFilterMessage = "Select below to filter by grade"
            selectedAllergensFilterMessage = "Filter by allergens"
        }
    }
}

