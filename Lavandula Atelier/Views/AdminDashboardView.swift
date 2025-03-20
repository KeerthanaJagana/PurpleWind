//
//  AdminDashboardView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/18/25.
//

import SwiftUI

struct AdminDashboardView: View {
    @Binding var isUserLoggedIn: Bool  // Binding to update login state

    var body: some View {
        VStack {
            HeaderView(isUserLoggedIn: $isUserLoggedIn)
            Spacer()
            Text("Welcome to the Dashboard!")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text("Hello, Admin!")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AdminDashboardView(isUserLoggedIn: .constant(true))  // Simulate logged-in state
}
