//  FoodButtonRow.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import SwiftUI

struct FoodButtonRow: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var isLiked: Bool = false
    @State var isDisliked: Bool = false
    @State var nutriments: Nutriments
    @State var product: Product
    
    var body: some View {
        
        VStack{
            HStack(alignment: .center, spacing: 10){
                Spacer()
                if nutriments.sodium_serving != nil {
                    NavigationLink {
                        NutrientsPage(nutriments: nutriments, foodID: product._id!)
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AnimGreen"))
                    }
                    .edgesIgnoringSafeArea(.all)
                    Text("info")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                }
                Spacer()
                Button {
                    if !(userViewModel.user.favorites!.contains((product._id)!)) {
                        userViewModel.user.favorites?.append((product._id)!)
                    } else {
                        userViewModel.user.favorites = userViewModel.user.favorites?.filter { $0 != (product._id)! }
                    }
                } label: {
                    if !(userViewModel.user.favorites!.contains((product._id)!)) {
                        Text("favorite")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                        Image(systemName: "star")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AnimGreen"))
                    } else {
                        Text("unfavorite")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AnimGreen"))
                    }
                }
                .foregroundColor(Color("AnimGreen"))
                .disabled((userViewModel.state ==  .signedOut))
                Spacer()
            }
            Spacer()
                .frame(height: 10)
            HStack(alignment: .center, spacing: 10){
                Spacer()
                if((userViewModel.user.fridgeItems!.contains(product._id!) == true)){
                    Button {
                        userViewModel.user.fridgeItems?.removeAll(where: { $0 == product._id })
                    } label: {
                        Image(systemName: "refrigerator.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AnimGreen"))
                        Text("Remove from Fridge")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                    }
                }
                else {
                    Button {
                        userViewModel.user.fridgeItems!.append(product._id!)
                    } label: {
                        Image(systemName: "refrigerator")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AnimGreen"))
                        Text("Add to Fridge")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                    }
                }
                Spacer()
                if nutriments.sodium_serving != nil {
                    Button {
                        addFood()
                    } label: {
                        Text("Log")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("AnimGreen"))
                    }
                }
                Spacer()
            }
        }
//        .frame(width: UIScreen.screenWidth,height: 50)
//        .background(Color("background"))
//        .border(width: 0.75, edges: [.top, .bottom], color: Color("AnimGreen"))
//        .padding(.bottom)
        
//        HStack {
//            Spacer()
////            if nutriments.sodium_serving != nil {
////                NavigationLink {
////                    NutrientsPage(nutriments: nutriments, foodID: product._id!)
////                } label: {
////                    Image(systemName: "info.circle")
////                        .font(.system(size: 50))
////                        .foregroundColor(Color("AnimGreen"))
////                }
////            }
//            Spacer()
////            Button {
////                if !(userViewModel.user.favorites!.contains((product._id)!)) {
////                    userViewModel.user.favorites?.append((product._id)!)
////                } else {
////                    userViewModel.user.favorites = userViewModel.user.favorites?.filter { $0 != (product._id)! }
////                }
////            } label: {
////                if !(userViewModel.user.favorites!.contains((product._id)!)) {
////                    Image(systemName: "star")
////                        .font(.system(size: 50))
////                        .foregroundColor(Color("AnimGreen"))
////                } else {
////                    Image(systemName: "star.fill")
////                        .font(.system(size: 50))
////                        .foregroundColor(Color("AnimGreen"))
////                }
////            }
////            .foregroundColor(Color("AnimGreen"))
////            .disabled((userViewModel.state ==  .signedOut))
//            Spacer()
////            if((userViewModel.user.fridgeItems!.contains(product._id!) == true)){
////                Button {
////                    userViewModel.user.fridgeItems?.removeAll(where: { $0 == product._id })
////                } label: {
////                    Image(systemName: "refrigerator.fill")
////                        .font(.system(size: 50))
////                        .foregroundColor(Color("AnimGreen"))
////                }
////            }
////            else {
////                Button {
////                    userViewModel.user.fridgeItems!.append(product._id!)
////                } label: {
////                    Image(systemName: "refrigerator")
////                        .font(.system(size: 50))
////                        .foregroundColor(Color("AnimGreen"))
////                }
////            }
//            Spacer()
////            if nutriments.sodium_serving != nil {
////                Button {
////                    addFood()
////                } label: {
////                    Image(systemName: "plus.circle")
////                        .font(.system(size: 50))
////                        .foregroundColor(Color("AnimGreen"))
////                }
////            }
//            Spacer()
//        }
    }
    
    func addFood(){
        if product.nutriments?.energy_kcal_serving != nil {
            userViewModel.nutrition.calories! += Int(product.nutriments?.energy_kcal_serving ?? 0)
        }
        print(userViewModel.nutrition.calories!)
        
        if product.nutriments?.carbohydrates_serving != nil {
            userViewModel.nutrition.carbs! += Int(product.nutriments?.carbohydrates_serving ?? 0)
        }
        print(userViewModel.nutrition.carbs!)
        
        if product.nutriments?.fat_serving != nil {
            userViewModel.nutrition.fat! += Int(product.nutriments?.fat_serving ?? 0)
        }
        print(userViewModel.nutrition.fat!)
        
        if product.nutriments?.proteins_serving != nil {
            userViewModel.nutrition.protein! += Int(product.nutriments?.proteins_serving ?? 0)
        }
        print(userViewModel.nutrition.protein!)
    }
    
}
