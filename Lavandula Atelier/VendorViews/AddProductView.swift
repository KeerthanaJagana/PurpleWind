//
//  AddProductView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/21/25.
//

import SwiftUI

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct AddProductView: View {
    @State private var productTitle = ""
    @State private var aesthetic = ""
    @State private var selectedImages: [UIImage] = []
    @State private var showImagePicker = false
    @State private var imageURLs: [String] = []
    @State private var isSubmitting = false

    let aesthetics = ["Goth", "Vintage", "Floral", "Old Money", "Cottagecore"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Info")) {
                    TextField("Product Title", text: $productTitle)

                    Picker("Select Aesthetic", selection: $aesthetic) {
                        ForEach(aesthetics, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Product Images")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(selectedImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }

                    Button("Add Images") {
                        showImagePicker = true
                    }
                }

                Section {
                    Button("Submit for Approval") {
                        uploadAllImagesAndSubmit()
                    }
                    .disabled(selectedImages.isEmpty || productTitle.isEmpty || aesthetic.isEmpty)
                }

                if isSubmitting {
                    ProgressView("Uploading...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationTitle("New Product")
            .sheet(isPresented: $showImagePicker) {
                MultiImagePicker(selectedImages: $selectedImages)
            }
        }
    }

    // MARK: - Upload all images first, then save Firestore
    func uploadAllImagesAndSubmit() {
        isSubmitting = true
        let storageRef = Storage.storage().reference()
        let group = DispatchGroup()
        var urls: [String] = []

        for image in selectedImages {
            group.enter()
            let imageName = UUID().uuidString
            let imageRef = storageRef.child("product_images/\(imageName).jpg")

            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                group.leave()
                continue
            }

            imageRef.putData(imageData, metadata: nil) { _, error in
                if error == nil {
                    imageRef.downloadURL { url, _ in
                        if let url = url {
                            urls.append(url.absoluteString)
                        }
                        group.leave()
                    }
                } else {
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.imageURLs = urls
            saveProductToFirestore()
        }
    }

    // MARK: - Save Product Data to Firestore
    func saveProductToFirestore() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userRef = Firestore.firestore().collection("users").document(userId)
        userRef.getDocument { document, error in
            let data = document?.data()
            let vendorName = data?["name"] as? String ?? "Unknown Vendor"
            let brandName = data?["brandName"] as? String ?? "Unknown Brand"

            let productData: [String: Any] = [
                "productTitle": productTitle,
                "imageURLs": imageURLs,
                "vendorId": userId,
                "vendorName": vendorName,
                "brandName": brandName,
                "aesthetic": aesthetic.lowercased(),
                "status": "pending",
                "timestamp": Timestamp()
            ]

            Firestore.firestore().collection("products").addDocument(data: productData) { error in
                isSubmitting = false
                if let error = error {
                    print("❌ Error uploading product: \(error.localizedDescription)")
                } else {
                    print("✅ Product submitted successfully!")
                    resetForm()
                }
            }
        }
    }

    func resetForm() {
        productTitle = ""
        aesthetic = ""
        selectedImages.removeAll()
        imageURLs.removeAll()
    }
}

#Preview {
    AddProductView()
}
