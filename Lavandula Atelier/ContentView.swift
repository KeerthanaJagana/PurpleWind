//
//  ContentView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/14/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = Auth.auth().currentUser != nil
      @State private var userRole: String?
    
    var body: some View {
           if isUserLoggedIn {
               if let role = userRole {
                   switch role {
                   case "admin":
                       AdminDashboardView(isUserLoggedIn: $isUserLoggedIn)
                   case "vendor":
                       VendorDashboardView()
                   case "customer":
                       CustomerHomeView()
                   default:
                       Text("Unknown Role")
                   }
               } else {
                   ProgressView()
                       .onAppear {
                           fetchUserRole { role in
                               self.userRole = role
                           }
                       }
               }
           } else {
               Login()
           }
       }
    }

        
        #Preview {
            ContentView()
        }
    
