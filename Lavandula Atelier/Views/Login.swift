//
//  Login.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/17/25.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                login(email: email, password: password) { success, message in
                    if success {
                        alertMessage = "Login successful!"
                    } else {
                        alertMessage = message ?? "Error logging in."
                    }
                    showAlert = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}


#Preview {
    Login()
}
