import SwiftUI

struct FoodButtonRow2: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var isLiked: Bool = false
    @State var isDisliked: Bool = false
    @State var nutriments: Nutriments
    @State var product: Product
    
    var body: some View {
        
        HStack(spacing: 35){
            Spacer()
            if nutriments.sodium_serving != nil {
                NavigationLink {
                    NutrientsPage(nutriments: nutriments, foodID: product._id!)
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 30))
                        .foregroundColor(Color("AnimGreen"))
                }
            }
            Button {
                if !(userViewModel.user.favorites!.contains((product._id)!)) {
                    userViewModel.user.favorites?.append((product._id)!)
                } else {
                    userViewModel.user.favorites = userViewModel.user.favorites?.filter { $0 != (product._id)! }
                }
            } label: {
                if !(userViewModel.user.favorites!.contains((product._id)!)) {
                    Image(systemName: "star")
                        .font(.system(size: 30))
                        .foregroundColor(Color("AnimGreen"))
                } else {
                    Image(systemName: "star.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color("AnimGreen"))
                }
            }
            .foregroundColor(Color("AnimGreen"))
            .disabled((userViewModel.state ==  .signedOut))
            if((userViewModel.user.fridgeItems!.contains(product._id!) == true)){
                Button {
                    userViewModel.user.fridgeItems?.removeAll(where: { $0 == product._id })
                } label: {
                    Image(systemName: "refrigerator.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color("AnimGreen"))
                    Text("-")
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
                    Text("+")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                }
            }
            Spacer()
        }
    }
    
}
