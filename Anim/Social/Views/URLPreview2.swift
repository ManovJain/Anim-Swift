import SwiftUI
import LinkPresentation

struct URLPreview2: View {
    let urlString: String
    @State private var title: String = ""
    @State private var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            if !title.isEmpty {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
        .onAppear {
            guard let url = URL(string: urlString) else { return }

            let provider = LPMetadataProvider()

            provider.startFetchingMetadata(for: url) { metadata, error in
                guard let metadata = metadata, error == nil else { return }

                DispatchQueue.main.async {
                    self.title = metadata.title ?? ""
                    if let imageProvider = metadata.imageProvider {
                        imageProvider.loadObject(ofClass: UIImage.self) { image, error in
                            if let image = image as? UIImage {
                                self.image = image
                            }
                        }
                    }
                }
            }
        }
    }
}
