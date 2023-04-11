import SwiftUI
import CachedAsyncImage

struct ProductImage: View {
        var imageURL: String
        var grade: String
        
        @Binding var gradeAlertShown: Bool
        
        var body: some View {
            VStack(){
                CachedAsyncImage(
                    url: URL(string: imageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 160, height: UIScreen.screenWidth - 160)
                            .padding(5)
                    } placeholder: {
                        ProgressView()
                    }
                    .overlay(GradeOverlay(grade: grade, gradeAlertShown: $gradeAlertShown), alignment: .topLeading)
                    .padding(.bottom)
            }
        }
    }


