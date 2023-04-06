//
//  CreatePostView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import SwiftUI

struct CreatePostView: View {
    @State private var link: String = ""
    @State private var caption: String = ""
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var togglePreview = false
    
    var body: some View {
        VStack {
            if verifyUrl(urlString: link) {
                Spacer()
                    .frame(height: 25)
                URLPreview(previewURL: URL(string: link)!, togglePreview: self.$togglePreview)
                    .fixedSize()
                    .frame(height: 200)
                    .padding()
            }
            else {
                Spacer()
            }
            Spacer()
                .frame(height: 50)
            if (!(verifyUrl(urlString: link) ) && !link.isEmpty) {
                Text("Invalid URL")
                    .foregroundColor(.red)
                    .font(Font.custom("DMSans-Medium", size: 12))
            }
            TextField(
                "Recipe Link",
                text: $link
            )
            .padding()
            .border(Color("AnimGreen"), width: 1)
            TextField(
                "Caption",
                text: $caption
            )
            .padding()
            .border(Color("AnimGreen"), width: 1)
            Button(action: {
                FirestoreRequests().createPost(userID: userViewModel.user.uid!, postID: UUID().uuidString, contentType: "link", content: link, caption: caption, datePosted: Date(), username: userViewModel.user.username!, isPublic: userViewModel.user.isPublic!) { data in
                    NotificationCenter.default.post(name: NSNotification.refreshPosts, object: nil)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
            {
                Text("Post")
            }
            .disabled(!verifyUrl(urlString: link))
            Spacer()
        }
        .onDisappear() {
            NotificationCenter.default.post(name: NSNotification.refreshPost, object: nil)
        }
        .padding()
        .navigationTitle("Create Post")
    }
}

func verifyUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}
