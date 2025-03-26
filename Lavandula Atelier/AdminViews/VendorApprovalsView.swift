//
//  VendorApprovalsView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/21/25.
//
import SwiftUI
import FirebaseFirestore
//import FirebaseFirestoreSwift

struct VendorApprovalsView: View {
    @State private var pendingProducts: [Product] = []
    @State private var showMessage = false
    @State private var messageText = ""
    @State private var messageColor = Color.green

    private let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(pendingProducts) { product in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(product.productTitle)
                                .font(.headline)

                            Text("Brand: \(product.brandName)")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(product.imageURLs, id: \.self) { imageURL in
                                        AsyncImage(url: URL(string: imageURL)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                    }
                                }
                            }

                            HStack {
                                Button(action: {
                                    updateStatus(for: product, to: "approved")
                                }) {
                                    Label("Approve", systemImage: "checkmark.circle")
                                        .foregroundColor(.green)
                                }

                                Button(action: {
                                    updateStatus(for: product, to: "rejected")
                                }) {
                                    Label("Reject", systemImage: "xmark.circle")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.top, 4)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .navigationTitle("Pending Approvals")

                // ✅ Confirmation Toast
                if showMessage {
                    Text(messageText)
                        .foregroundColor(.white)
                        .padding()
                        .background(messageColor)
                        .cornerRadius(8)
                        .transition(.opacity)
                        .zIndex(1)
                        .padding(.bottom, 40)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .onAppear(perform: fetchPendingProducts)
        }
    }

    // MARK: - Fetch
    func fetchPendingProducts() {
        db.collection("products")
            .whereField("status", isEqualTo: "pending")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.pendingProducts = documents.compactMap {
                    try? $0.data(as: Product.self)
                }
            }
    }

    // MARK: - Update status
    func updateStatus(for product: Product, to newStatus: String) {
        guard let id = product.id else {
            print("❌ Error: Product ID is nil")
            return
        }

        db.collection("products").document(id).updateData([
            "status": newStatus
        ]) { error in
            if let error = error {
                print("Error updating status: \(error.localizedDescription)")
            } else {
                showFeedback(message: newStatus.capitalized + "!", color: newStatus == "approved" ? .green : .red)
            }
        }
    }

    func showFeedback(message: String, color: Color) {
        messageText = message
        messageColor = color
        withAnimation {
            showMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showMessage = false
            }
        }
    }
}


#Preview {
    VendorApprovalsView()
}
