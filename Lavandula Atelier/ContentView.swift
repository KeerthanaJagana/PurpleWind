//
//  ContentView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var userRole: String?
    
    var body: some View {
        if let role = userRole {
            switch role {
            case "admin":
                AdminDashboardView()
            case "vendor":
                VendorDashboardView()
            case "customer":
                CustomerHomeView()
            default:
                Text("Unknown Role")
            }
        } else {
            Login()
                .onAppear {
                    fetchUserRole { role in
                        self.userRole = role
                    }
                }
        }
    }
}
        
        #Preview {
            ContentView()
        }
    
