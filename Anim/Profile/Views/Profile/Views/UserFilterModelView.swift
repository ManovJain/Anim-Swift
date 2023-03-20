//
//  UserFilterModelView.swift
//  Anim
//
//  Created by Manovski on 3/4/23.
//

import SwiftUI
import Firebase

struct UserFilterModalView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selectedgeoPreferenceMessage = "Show US products only"
    
    @State var selectedGradeFilterMessage = "Select below to filter by grade"
    
    @State var selectedAllergensFilterMessage = "Filter by allergens"
    
    var fireStoreRequests = FirestoreRequests()
    
    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .center){
                Text(selectedgeoPreferenceMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Button{
                        userViewModel.user.geoPreference = "world"
                        userViewModel.geoPreference = .world
                        selectedgeoPreferenceMessage = "Show products from all countries"
                    } label: {
                        GeoButton(location: "world", filterVal: userViewModel.user.geoPreference!)
                    }
                    .buttonStyle(.plain)
                    Button{
                        userViewModel.user.geoPreference = "us"
                        userViewModel.geoPreference = .us
                        selectedgeoPreferenceMessage = "Show US products only"
                    } label: {
                        GeoButton(location: "us", filterVal: userViewModel.user.geoPreference!)
                    }
                    .buttonStyle(.plain)
                    Button{
                        userViewModel.user.geoPreference = "es"
                        userViewModel.geoPreference = .es
                        selectedgeoPreferenceMessage = "Show Spanish products only"
                    } label: {
                        GeoButton(location: "es", filterVal: userViewModel.user.geoPreference!)
                    }
                    .buttonStyle(.plain)
                }
                //NUTRITION GRADES
                Text(selectedGradeFilterMessage)
                    .font(Font.custom("DMSans-Medium", size: 12))
                HStack {
                    Spacer()
                    Button{
                        userViewModel.user.gradePreference = "a"
                        userViewModel.gradePreference = .a
                        selectedGradeFilterMessage = "Show only products with an A grade"
                    } label: {
                        if userViewModel.gradePreference != .a {
                            GradeButton(grade: "A", noColor: true)
                        }
                        else {
                            GradeButton(grade: "A", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.user.gradePreference = "b"
                        userViewModel.gradePreference = .b
                        selectedGradeFilterMessage = "Show only products with a B grade"
                    } label: {
                        if userViewModel.gradePreference != .b {
                            GradeButton(grade: "B", noColor: true)
                        }
                        else {
                            GradeButton(grade: "B", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.user.gradePreference = "c"
                        userViewModel.gradePreference = .c
                        selectedGradeFilterMessage = "Show only products with a C grade"
                    } label: {
                        if userViewModel.gradePreference != .c {
                            GradeButton(grade: "C", noColor: true)
                        }
                        else {
                            GradeButton(grade: "C", noColor: false)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button{
                        userViewModel.user.gradePreference = "d"
                        userViewModel.gradePreference = .d
                        selectedGradeFilterMessage = "Show only products with a D grade"
                    } label: {
                        if userViewModel.gradePreference != .d {
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
                    userViewModel.geoPreference = .us
                    userViewModel.gradePreference = .none
                    selectedgeoPreferenceMessage = "Show US products only"
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
    }
}

