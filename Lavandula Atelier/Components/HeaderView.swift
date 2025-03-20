//
//  HeaderView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/19/25.
//

import SwiftUI
import FirebaseAuth

struct HeaderView: View {
   
    @Environment(\.presentationMode) var presentationMode
    @Binding var isUserLoggedIn: Bool  // Used to control navigation to LoginView
    @State private var showSignOutAlert = false  // Controls the alert visibility

    var body: some View {
        HStack {
          
            Image("Image") // Replace with  actual logo asset name
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .cornerRadius(10
                )

            Spacer()

            Button(action: {
                showSignOutAlert = true  // Show confirmation alert
            }) {
                Text("Sign Out")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
            }
            .alert(isPresented: $showSignOutAlert) {
                Alert(
                    title: Text("Sign Out"),
                    message: Text("Are you sure you want to sign out?"),
                    primaryButton: .destructive(Text("Sign Out")) {
                        signOut()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .background(Color(.systemGray6)) // Light background color
        .cornerRadius(10)
    }

    // Sign Out Function
    func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
           // UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            // Update state to redirect to login screen
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

}

#Preview {
    HeaderView( isUserLoggedIn: .constant(true))
}
