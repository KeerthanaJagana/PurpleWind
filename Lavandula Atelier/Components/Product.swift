//
//  Product.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/25/25.
//

import Foundation
import FirebaseFirestore

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var productTitle: String
    var imageURLs: [String]
    var vendorId: String
    var brandName: String
    var status: String
    var timestamp: Date
    var aesthetic: String
}


