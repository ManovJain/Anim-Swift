//
//  Login.swift
//  Anim
//
//  Created by Manovski on 12/6/22.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
      
    // MARK: - View
    var body: some View {
        VStack {
            Spacer()
            Text("LOGIN")
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 15) {
              TextField("Email", text: self.$email)
                    .padding()
              SecureField("Password", text: self.$password)
                    .padding()
            }
            Text("Already have an account? Sign in")
            Spacer()
        }
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity
            )
    }
}
