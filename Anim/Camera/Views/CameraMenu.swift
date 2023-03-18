import SwiftUI
import Combine

struct CameraMenu: View {
    
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    @State var opacity = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                withAnimation {
                    opacity = 1
                }
                cameraViewModel.addingToFridge = false
            }) {
                if cameraViewModel.addingToFridge == false {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color("AnimGreen"))
                }
                else {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                withAnimation {
                    opacity = 1
                }
                cameraViewModel.addingToFridge = true
            }) {
                if cameraViewModel.addingToFridge == true {
                    Image(systemName: "refrigerator.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color("AnimGreen"))
                }
                else {
                    Image(systemName: "refrigerator")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
        }
        .frame(width: 40,height: 150)
        .background(Color(.lightGray).opacity(0.75))
        .clipShape(Capsule())
        .opacity(opacity)
    }
    
}

