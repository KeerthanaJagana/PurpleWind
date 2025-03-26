//
//  VendorDashboardView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/21/25.
//
import SwiftUI
import FirebaseFirestore

struct VendorDashboardView: View {
    @State private var approvedProducts: [Product] = []
    @State private var navigateToSubmissions = false

    var body: some View {
        NavigationView{
            VStack {
                // Top Bar
                HStack {
                    Text("Vendor Feed")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: MySubmissionsView()) {
                        Label("My Submissions", systemImage: "clock.arrow.circlepath")
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Divider()
                
                // Feed
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(approvedProducts) { product in
                            ProductFeedCard(product: product)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .onAppear(perform: fetchApprovedProducts)
        }
    }
    func fetchApprovedProducts() {
        Firestore.firestore().collection("products")
            .whereField("status", isEqualTo: "approved")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.approvedProducts = documents.compactMap {
                    try? $0.data(as: Product.self)
                }
            }
    }
}

#Preview {
    VendorDashboardView()
}
