//
//  HeaderView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/19/25.
//

import SwiftUI
import FirebaseAuth

struct HeaderView: View {
    @EnvironmentObject var session: SessionManager
    @State private var showSignOutAlert = false

    var body: some View {
        HStack {
            Image("Image") // Your logo asset
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .cornerRadius(10)

            Spacer()

            Button(action: {
                showSignOutAlert = true
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
                        session.signOut()  // Use shared session manager
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    HeaderView()
        .environmentObject(SessionManager())
}
