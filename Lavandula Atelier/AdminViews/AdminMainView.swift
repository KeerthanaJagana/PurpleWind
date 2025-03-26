//
//  AdminMainView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/18/25.
//

import SwiftUI

struct AdminMainView: View {
    //@Binding var isUserLoggedIn: Bool  // Binding to update login state
    @EnvironmentObject var session: SessionManager  // shared session access
    var body: some View {
        VStack {
            HeaderView()  // 🔥 Reusable header
            Spacer()
            BottomNavView(userRole: "admin")  // 🔥 Reusable bottom navbar
        }
    }
}

#Preview {
    AdminMainView()  // Simulate logged-in state
        .environmentObject(SessionManager())
}
