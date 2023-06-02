//
//  SimpleProfile.swift
//  Anim
//
//  Created by Manovski on 4/19/23.
//

import SwiftUI
import CachedAsyncImage

struct SimpleProfile: View {
    
    var quickStats = [15, 20, 5]
    var quickNames = ["posts", "followers, following"]
    
    var body: some View {
        VStack{
            ScrollView{
                Text("Profile")
                    .font(Font.custom("DMSans-Medium", size: 25))
                ZStack{
                    Circle()
                        .frame(width: 140)
                        .foregroundColor(Color("AnimGreen"))
                    Image(systemName: "teddybear.fill")
                        .foregroundColor(Color.white)
                        .font(.system(size: 70))
                }
                Text("username")
                    .font(Font.custom("DMSans-Medium", size: 45))
                HStack{
                    Spacer()
                    VStack{
                        Text("2")
                            .font(Font.custom("DMSans-Medium", size: 30))
                        Text("Posts")
                            .font(Font.custom("DMSans-Medium", size: 20))
                    }
                    Spacer()
                    VStack{
                        Text("15")
                            .font(Font.custom("DMSans-Medium", size: 30))
                        Text("Followers")
                            .font(Font.custom("DMSans-Medium", size: 20))
                    }
                    Spacer()
                    VStack{
                        Text("30")
                            .font(Font.custom("DMSans-Medium", size: 30))
                        Text("Following")
                            .font(Font.custom("DMSans-Medium", size: 20))
                    }
                    Spacer()
                }
                .padding()
    //            Text("Posts (3)")
    //                .font(Font.custom("DMSans-Medium", size: 25))
    //                .frame(maxWidth: .infinity, alignment: .leading)
    //                .padding()
                HStack{
                    Image(systemName: "carrot.fill")
                        .foregroundColor(Color.green)
                        .font(.system(size: 30))
                    Image(systemName: "carrot.fill")
                        .foregroundColor(Color.green)
                        .font(.system(size: 30))
                    Image(systemName: "carrot.fill")
                        .foregroundColor(Color.green)
                        .font(.system(size: 30))
                }
                ScrollView(.horizontal){
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color.red)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color.red)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color.red)
                    }
                    .padding()
                }
                Button{
                    print("pressed")
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 100)
                        .foregroundColor(Color.blue)
                }
                Button{
                    print("pressed")
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 100)
                        .foregroundColor(Color.blue)
                }
                Button{
                    print("pressed")
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 100)
                        .foregroundColor(Color.blue)
                }
            }
            Spacer()
        }
    }
}

struct SimpleProfile_Previews: PreviewProvider {
    static var previews: some View {
        SimpleProfile()
    }
}
