//
//  Login1.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/17/25.
//

import SwiftUI

struct SignUP: View {
    @State private var email = ""
       @State private var password = ""
       @State private var selectedRole = "customer"
       @State private var showAlert = false
       @State private var alertMessage = ""

       let roles = ["customer", "vendor"]
    
    var body: some View {
        VStack {
                   TextField("Email", text: $email)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .autocapitalization(.none)
                       .padding()

                   SecureField("Password", text: $password)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()

                   Picker("Select Role", selection: $selectedRole) {
                       ForEach(roles, id: \.self) { role in
                           Text(role.capitalized)
                       }
                   }
                   .pickerStyle(SegmentedPickerStyle())
                   .padding()

                   Button("Sign Up") {
                       signUp(email: email, password: password, role: selectedRole) { success, message in
                           if success {
                               alertMessage = "Sign-up successful!"
                           } else {
                               alertMessage = message ?? "Error signing up."
                           }
                           showAlert = true
                       }
                   }
                   .buttonStyle(.borderedProminent)
                   .padding()
                   .alert(isPresented: $showAlert) {
                       Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                   }
               }
               .padding()
    }
}

#Preview {
    SignUP()
}
