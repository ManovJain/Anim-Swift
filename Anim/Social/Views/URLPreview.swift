//
//  URLPreview.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import Foundation
import SwiftUI
import LinkPresentation

struct URLPreview : UIViewRepresentable {
    var previewURL: URL
    //Add binding
    @Binding var togglePreview: Bool

    func makeUIView(context: Context) -> LPLinkView {
        let view = LPLinkView(url: previewURL)
        
        let provider = LPMetadataProvider()

        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                    view.sizeToFit()
                    self.togglePreview.toggle()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: LPLinkView, context: UIViewRepresentableContext<URLPreview>) {
    }
}

