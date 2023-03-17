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
    
    var allergensList = ["peanuts", "milk", "gluten", "soybeans", "eggs", "nuts", "fish"]
    
    let rows = [
        GridItem(.fixed(70))
    ]
    
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
                setUserPrefs(userPrefs: userPrefs)
                print("user values set")
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("AnimGreen")))
    }
    func setUserPrefs(userPrefs: Bool){
        if userPrefs == true {
            networkRequests.geoPreference = userViewModel.geoPreference
            networkRequests.gradePreference = userViewModel.gradePreference
            networkRequests.allergens.removeAll()
            networkRequests.allergens = userViewModel.user.allergens!
        }
        else {
            networkRequests.geoPreference = .us
            networkRequests.gradePreference = .none
            networkRequests.allergens.removeAll()
            selectedgeoPreferenceMessage = "Show US products only"
            selectedGradeFilterMessage = "Select below to filter by grade"
            selectedAllergensFilterMessage = "Filter by allergens"
        }
    }
    
    func updateAllergens(input: String){
        if((networkRequests.allergens.contains(input)) == true){
            networkRequests.allergens.removeAll(where: { $0 == input })
            print(networkRequests.allergens)
        }
        else {
            networkRequests.allergens.append(input)
            print(networkRequests.allergens)
        }
    }
    
}

