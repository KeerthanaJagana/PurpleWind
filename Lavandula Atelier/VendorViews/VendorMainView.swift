//
//  VendorDashboardView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/21/25.
//

import SwiftUI

struct VendorMainView: View {
    //@Binding var isUserLoggedIn: Bool  // Binding to update login state
    @EnvironmentObject var session: SessionManager  // shared session access

    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            BottomNavView(userRole: "vendor")
        }
        
    }
}

#Preview {
    VendorMainView()
        .environmentObject(SessionManager())
}
