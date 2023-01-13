//
//  SignUpPage.swift
//  Anim
//
//  Created by Manovski on 12/6/22.
//

import SwiftUI

struct SignUpPage: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Sign Up")
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

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
