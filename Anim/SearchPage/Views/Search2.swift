//
//  Search2.swift
//  Anim
//
//  Created by Manovski on 4/4/23.
//

import SwiftUI

struct Search2: View {
   
    @State private var searchText = ""
    @State private var index = 0
    @State var display: String = "Info"
    var displays = ["Explore", "Filter"]
    var banners = ["banner1", "banner2", "banner3"]
    
    var body: some View {
            NavigationStack() {
                VStack(alignment: .center){
                    HStack(alignment: .center, spacing: 10){
                        Spacer()
                        Button("Explore", action: {display = "Explore"})
                            .buttonStyle(MenuButtonStyle())
                            .buttonStyle(MenuButtonStyle())
                        Button("Filter", action: {display = "Filter"})
                            .buttonStyle(MenuButtonStyle())
                        Spacer()
                    }
                    TabView(selection: $index){
                        ForEach((0...banners.count-1), id: \.self) { index in
                            Image(banners[index])
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(height: 200)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    HStack(spacing: 2) {
                        ForEach((0...banners.count-1), id: \.self) { index in
                            Rectangle()
                                .fill(index == self.index ? Color("AnimGreen") : Color("AnimGreen").opacity(0.5))
                                .frame(width: 30, height: 5)

                        }
                    }
                    Spacer()
                        .frame(height: 20)
                    VStack{
                        HStack(){
                            Image(systemName: "clock")
                            Text("Recent Searches")
                        }
                        ScrollView(.horizontal){
                            HStack{
                                ForEach((0...banners.count-1), id: \.self) { index in
                                    Image(uiImage: UIImage(named: "animLogoIconGreen") ?? UIImage())
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                }
                            }
                        }
                        
                    }
                    Spacer()
                        .frame(height: 20)
                    VStack{
                        HStack(){
                            Image(systemName: "star")
                            Text("Trending Posts")
                        }
                        ScrollView(.horizontal){
                            HStack{
                                ForEach((0...banners.count-1), id: \.self) { index in
                                    Image(uiImage: UIImage(named: "animLogoIconGreen") ?? UIImage())
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                }
                            }
                        }
                    }
                    Spacer()
                }
        }
            .searchable(text: $searchText)
        
    }
}

struct Search2_Previews: PreviewProvider {
    static var previews: some View {
        Search2()
    }
}
