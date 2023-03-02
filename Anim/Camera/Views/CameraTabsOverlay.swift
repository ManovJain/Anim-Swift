import SwiftUI

struct CameraTabsOverlay: View {
    
    @State var discoverSelected: Bool = true
    
    @EnvironmentObject var camerViewModel: CameraViewModel
    
    var body: some View {
        HStack(spacing: 0){
            Button{
                discoverSelected = true
                camerViewModel.addingToFridge = false
            } label: {
                Text("Discover")
                    .foregroundColor(Color("background"))
                    .font(Font.custom("DMSans-Medium", size: 12))
                    .frame(width: 50)
                    .padding(8)
            }
            .background(Color("AnimGreen").opacity(discoverSelected ? 0.95 : 0.3))
            Button{
                discoverSelected = false
                camerViewModel.addingToFridge = true
            } label: {
                Text("Fridge")
                    .foregroundColor(Color("background"))
                    .font(Font.custom("DMSans-Medium", size: 12))
                    .frame(width: 50)
                    .padding(8)
            }
            .background(Color("AnimGreen").opacity(discoverSelected ? 0.3 : 0.95))
        }
        .clipShape(Capsule())
    }
}

struct CameraTabsOverlay_Previews: PreviewProvider {
    static var previews: some View {
        CameraTabsOverlay()
    }
}
