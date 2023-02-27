//
//  Filter.swift
//  Anim
//
//  Created by Manovski on 2/23/23.
//

import SwiftUI

struct Filter: View {
    
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    var body: some View {
        VStack{
            Text("Show products from: " + filterViewModel.geoFilter.rawValue)
                .font(Font.custom("DMSans-Medium", size: 12))
            HStack {
                Button{
                    filterViewModel.geoFilter = .world
                } label: {
                    Geo(location: "world", filterVal: filterViewModel.geoFilter.rawValue)
                }
                Button{
                    filterViewModel.geoFilter = .us
                } label: {
                    Geo(location: "us", filterVal: filterViewModel.geoFilter.rawValue)
                }
                Button{
                    filterViewModel.geoFilter = .es
                } label: {
                    Geo(location: "es", filterVal: filterViewModel.geoFilter.rawValue)
                }
            }
            Text("Show products with nutriscore: " + filterViewModel.scoreFilter.rawValue)
                .font(Font.custom("DMSans-Medium", size: 12))
            HStack {
                Spacer()
                Button{
                    filterViewModel.scoreFilter = .a
                    print("A clicked")
                    print(filterViewModel.scoreFilter.rawValue)
                } label: {
                    if filterViewModel.scoreFilter != .a {
                        Grade(grade: "A", noColor: true)
                    }
                    else {
                        Grade(grade: "A", noColor: false)
                    }
                }
                Spacer()
                Button{
                    filterViewModel.scoreFilter = .b
                    print("B clicked")
                    print(filterViewModel.scoreFilter.rawValue)
                } label: {
                    if filterViewModel.scoreFilter != .b {
                        Grade(grade: "B", noColor: true)
                    }
                    else {
                        Grade(grade: "B", noColor: false)
                    }
                }
                Spacer()
                Button{
                    filterViewModel.scoreFilter = .c
                    print("B clicked")
                    print(filterViewModel.scoreFilter.rawValue)
                } label: {
                    if filterViewModel.scoreFilter != .c {
                        Grade(grade: "C", noColor: true)
                    }
                    else {
                        Grade(grade: "C", noColor: false)
                    }
                }
                Spacer()
                Button{
                    filterViewModel.scoreFilter = .d
                    print("D clicked")
                    print(filterViewModel.scoreFilter.rawValue)
                } label: {
                    if filterViewModel.scoreFilter != .d {
                        Grade(grade: "D", noColor: true)
                    }
                    else {
                        Grade(grade: "D", noColor: false)
                    }
                }
                Spacer()
            }
            .frame(width: 200,height: 40)
            .background(Color("AnimGreen"))
            .clipShape(Capsule())
        }
    }
}
//            Spacer()
//            Button(action: {
//                filterViewModel.scoreFilter = .b
//                print("B clicked")
//            }) {
//                if filterViewModel.scoreFilter != .b {
//                    Text("B")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(Color("background"))
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//                else {
//                    Text("B")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(.yellow)
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//            }
//            Spacer()
//            Button(action: {
//                filterViewModel.scoreFilter = .c
//                print("C clicked")
//            }) {
//                if filterViewModel.scoreFilter != .c {
//                    Text("C")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(Color("background"))
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//                else {
//                    Text("C")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(.yellow)
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//            }
//            Spacer()
//            Button(action: {
//                filterViewModel.scoreFilter = .d
//                print("D clicked")
//            }) {
//                if filterViewModel.scoreFilter != .d {
//                    Text("D")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(Color("background"))
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//                else {
//                    Text("D")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(.red)
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//            }
//            Spacer()
//            Button(action: {
//                filterViewModel.scoreFilter = .e
//                print("E clicked")
//            }) {
//                if filterViewModel.scoreFilter != .d {
//                    Text("E")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(Color("background"))
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//                else {
//                    Text("E")
//                        .font(Font.custom("DMSans-Medium", size: 12))
//                        .padding(10)
//                        .background(.red)
//                        .clipShape(Circle())
//                        .foregroundColor(.primary)
//                }
//            }


struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter()
    }
}
