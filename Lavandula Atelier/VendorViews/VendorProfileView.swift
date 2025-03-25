//
//  VendorProfileView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/24/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct VendorProfileView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var age = ""
    @State private var brandName = ""
    @State private var email = Auth.auth().currentUser?.email ?? ""
    @State private var isSaved = false

    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid ?? ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vendor Info")) {
                    VStack(alignment: .leading) {
                        Text("Name:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("Your Name", text: $name)
                    }

                    VStack(alignment: .leading) {
                        Text("Age:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("Your Age", text: $age)
                            .keyboardType(.numberPad)
                    }

                    VStack(alignment: .leading) {
                        Text("Brand Name:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("Brand Name", text: $brandName)
                    }

                    VStack(alignment: .leading) {
                        Text("Contact (Email):")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(email)
                            .foregroundColor(.secondary)
                    }
                }

                Section {
                    Button("Save Profile") {
                        saveProfile()
                    }
                    .disabled(name.isEmpty || age.isEmpty || brandName.isEmpty)

                    if isSaved {
                        Text("✅ Profile updated!")
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            })
            .onAppear(perform: loadProfile)
        }
    }

    func saveProfile() {
        guard !userId.isEmpty else { return }
        db.collection("users").document(userId).setData([
            "name": name,
            "age": Int(age) ?? 0,
            "brandName": brandName,
            "role": "vendor"
        ], merge: true) { error in
            if let error = error {
                print("Error saving profile: \(error.localizedDescription)")
            } else {
                isSaved = true
            }
        }
    }

    func loadProfile() {
        guard !userId.isEmpty else { return }
        db.collection("users").document(userId).getDocument { document, error in
            if let data = document?.data() {
                self.name = data["name"] as? String ?? ""
                self.age = "\(data["age"] as? Int ?? 0)"
                self.brandName = data["brandName"] as? String ?? ""
            }
        }
    }
}

#Preview {
    VendorProfileView()
}
