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
                       AdminMainView(isUserLoggedIn: $isUserLoggedIn)
                   case "vendor":
                       VendorMainView(isUserLoggedIn: $isUserLoggedIn)
                   case "customer":
                       CustomerMainView(isUserLoggedIn: $isUserLoggedIn)
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
    
