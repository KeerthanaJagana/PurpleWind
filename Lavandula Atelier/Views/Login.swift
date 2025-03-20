//
//  Login.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/17/25.
//

import SwiftUI
import FirebaseAuth

struct Login: View {
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: login) {
                Text("Login")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = "Login failed: \(error.localizedDescription)"
            } else {
                self.isUserLoggedIn = true  // ✅ Update login state
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")  // ✅ Persist login state
                print("Login successful")
            }
        }
    }
}
