//
//  ContentView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/14/25.
//
import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var session = SessionManager()

    var body: some View {
        if session.isUserLoggedIn {
            if let role = session.userRole {
                switch role {
                case "admin":
                    AdminMainView()
                        .environmentObject(session)
                case "vendor":
                    VendorMainView()
                        .environmentObject(session)
                case "customer":
                    CustomerMainView()
                        .environmentObject(session)
                default:
                    Text("Unknown Role")
                }
            } else {
                ProgressView()
                    .onAppear {
                        session.fetchUserRole()
                    }
            }
        } else {
            Login()
                .environmentObject(session)
        }
    }
}

#Preview {
    ContentView()
}
