////
////  SearchResult.swift
////  Anim
////
////  Created by Manovski on 12/9/22.
////
//
//import Foundation
//import SwiftUI
//import CachedAsyncImage
//
//struct SearchResult: View {
//    var body: some View {
//        HStack{
//            if let name = result.product_name_en{
//                if name != ""{
//                    Text(name)
//                }
//            }
//            CachedAsyncImage(
//                url: URL(string: result.image_front_url ?? "https://spng.pngfind.com/pngs/s/5-56881_apple-icon-apple-icon-cartoon-png-transparent-png.png")) { image in
//                    image.resizable()
//                                .frame(width: 45, height: 45)
//                } placeholder: {
//                    ProgressView()
//                }
//        }
//    }
//}
