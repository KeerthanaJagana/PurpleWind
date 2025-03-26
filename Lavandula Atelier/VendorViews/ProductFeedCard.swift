//
//  ProductFeedCard.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/25/25.
//

import SwiftUI

struct ProductFeedCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Horizontal image carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(product.imageURLs, id: \.self) { url in
                        AsyncImage(url: URL(string: url)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 250, height: 250)
                        .cornerRadius(10)
                    }
                }
            }

            Text(product.productTitle)
                .font(.headline)

            Text("By \(product.brandName)")
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                Button(action: {}) {
                    Label("Like", systemImage: "heart")
                }

                Button(action: {}) {
                    Label("Comment", systemImage: "message")
                }

                Spacer()

                Button(action: {}) {
                    Label("Buy", systemImage: "bag")
                        .foregroundColor(.purple)
                }
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}



