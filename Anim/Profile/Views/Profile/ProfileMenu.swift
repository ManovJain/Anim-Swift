import SwiftUI

struct ProfileMenu: View {
    
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    
    @State private var icon = "profile"
    @State private var anim = "bird"
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                profileMenuViewModel.icon = .user
            }) {
                if profileMenuViewModel.icon.rawValue == "user" {
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
                profileMenuViewModel.icon = .animManager
            }) {
                if profileMenuViewModel.icon.rawValue == "animManager" {
                    Image(systemName: anim + ".fill")
                        .font(.system(size: 20))
                        .foregroundColor(.indigo)
                }
                else {
                    Image(systemName: anim)
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            
            Button(action: {
                profileMenuViewModel.icon = .favorites
            }) {
                if profileMenuViewModel.icon.rawValue == "favorites" {
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
                profileMenuViewModel.icon = .settings
            }) {
                if profileMenuViewModel.icon.rawValue == "settings" {
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
//        .position(x: UIScreen.screenWidth/2.5, y:UIScreen.screenHeight/3.5)
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
