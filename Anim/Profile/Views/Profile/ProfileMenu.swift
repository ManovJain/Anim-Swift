import SwiftUI

struct ProfileMenu: View {
    
    @EnvironmentObject var navModel: NavModel
    
    @State private var icon = "profile"
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                icon = "profile"
            }) {
                if icon == "profile" {
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        
                        .foregroundColor(.indigo)
                        
                }
                else {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                icon = "anim"
            }) {
                if icon == "anim" {
                    Image(systemName: "bird.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                        
                }
                else {
                    Image(systemName: "bird")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                icon = "badge"
            }) {
                if icon == "badge" {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        
                        .foregroundColor(.indigo)
                        
                }
                else {
                    Image(systemName: "star")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                icon = "searchFilter"
            }) {
                if icon == "searchFilter" {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 20))
                        
                        .foregroundColor(.indigo)
                        
                }
                else {
                    Image(systemName: "leaf")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                icon = "settings"
            }) {
                if icon == "settings" {
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        
                        .foregroundColor(.indigo)
                        
                }
                else {
                    Image(systemName: "gear")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
        }
        .frame(width: 40,height: 200)
        .background(Color(.lightGray).opacity(0.75))
        .clipShape(Capsule())
    }
    
    func getIcon() -> String{
        return icon
    }
}



struct ProfileMenu_Previews: PreviewProvider {
    static var previews: some View {
        PillTabBar()
    }
}
