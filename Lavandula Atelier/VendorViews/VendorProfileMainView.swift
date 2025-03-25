//
//  VendorProfileMainView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/24/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct VendorProfileMainView: View {
    @State private var name: String = ""
    @State private var brandName: String = ""
    @State private var age: Int = 0
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("👤 \(name)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("🧵 Brand: \(brandName)")
                            .font(.headline)
                        Text("🎂 Age: \(age)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()

                    // Edit icon
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.purple)
                    }
                }
                .padding()

                Spacer()
            }
            .navigationTitle("My Profile")
            .onAppear(perform: fetchProfileData)
            .background(
                NavigationLink(
                    destination: VendorProfileView(),
                    isActive: $isEditing,
                    label: { EmptyView() }
                )
            )
        }
    }

    func fetchProfileData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(userId).getDocument { document, error in
            if let data = document?.data() {
                self.name = data["name"] as? String ?? "Vendor"
                self.brandName = data["brandName"] as? String ?? "Your Brand"
                self.age = data["age"] as? Int ?? 0
            }
        }
    }
}


#Preview {
    VendorProfileMainView()
}
