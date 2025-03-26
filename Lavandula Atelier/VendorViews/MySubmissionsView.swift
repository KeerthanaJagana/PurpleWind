//
//  MySubmissionsView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/25/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
//import FirebaseFirestoreSwift

struct MySubmissionsView: View {
    @State private var submissions: [Product] = []
    private let db = Firestore.firestore()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(submissions) { product in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(alignment: .top) {
                            // First image preview
                            if let firstImage = product.imageURLs.first {
                                AsyncImage(url: URL(string: firstImage)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.productTitle)
                                    .font(.headline)

                                Text("Aesthetic: \(product.aesthetic.capitalized)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Text("Status: \(product.status.capitalized)")
                                    .font(.caption)
                                    .foregroundColor(statusColor(product.status))
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("My Submissions")
            .onAppear(perform: fetchSubmissions)
            
        }
    }

    func fetchSubmissions() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("products")
            .whereField("vendorId", isEqualTo: userId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.submissions = documents.compactMap {
                    try? $0.data(as: Product.self)
                }
            }
    }

    func statusColor(_ status: String) -> Color {
        switch status {
        case "approved": return .green
        case "rejected": return .red
        default: return .orange
        }
    }
}

#Preview {
    MySubmissionsView()
}
