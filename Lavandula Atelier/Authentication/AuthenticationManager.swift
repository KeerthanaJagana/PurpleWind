//
//  AuthenticationManager.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/17/25.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

func signUp(email: String, password: String, role: String, completion: @escaping (Bool, String?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
        if let error = error {
            print("🔥 Firebase Sign-Up Error: \(error.localizedDescription)")
            completion(false, error.localizedDescription)
        } else if let user = result?.user {
            let db = Firestore.firestore()
            let userData: [String: Any] = [
                "email": email,
                "role": role,
                "createdAt": Timestamp()
            ]
            db.collection("users").document(user.uid).setData(userData) { err in
                if let err = err {
                    completion(false, err.localizedDescription)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
}

//func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
//    Auth.auth().signIn(withEmail: email, password: password) { result, error in
//        if let error = error {
//            completion(false, error.localizedDescription)
//        } else {
//            completion(true, nil)
//        }
//    }
//}

func fetchUserRole(completion: @escaping (String?) -> Void) {
    guard let userID = Auth.auth().currentUser?.uid else {
        completion(nil)
        return
    }

    let db = Firestore.firestore()
    db.collection("users").document(userID).getDocument { document, error in
        if let document = document, document.exists {
            completion(document.data()?["role"] as? String)
        } else {
            completion(nil)
        }
    }
}

