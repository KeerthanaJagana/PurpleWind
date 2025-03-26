//
//  SessionManager.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/25/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SessionManager: ObservableObject {
    @Published var isUserLoggedIn: Bool = Auth.auth().currentUser != nil
    @Published var userRole: String?

    private let db = Firestore.firestore()

    init() {
        if isUserLoggedIn {
            fetchUserRole()
        }
    }

    func fetchUserRole() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.userRole = nil
            return
        }

        db.collection("users").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                self.userRole = document.data()?["role"] as? String
            } else {
                self.userRole = nil
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
            userRole = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
