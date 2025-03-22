//
//  AdminMainView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/18/25.
//

import SwiftUI

struct AdminMainView: View {
    @Binding var isUserLoggedIn: Bool  // Binding to update login state

    var body: some View {
        VStack {
            HeaderView(isUserLoggedIn: $isUserLoggedIn)  // 🔥 Reusable header
            Spacer()
            BottomNavView(userRole: "admin")  // 🔥 Reusable bottom navbar
        }
    }
}

#Preview {
    AdminMainView(isUserLoggedIn: .constant(true))  // Simulate logged-in state
}
