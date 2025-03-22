//
//  VendorDashboardView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/21/25.
//

import SwiftUI

struct VendorMainView: View {
    @Binding var isUserLoggedIn: Bool  // Binding to update login state

    var body: some View {
        VStack {
            HeaderView(isUserLoggedIn: $isUserLoggedIn)
            Spacer()
            BottomNavView(userRole: "vendor")
        }
        
    }
}

#Preview {
    VendorMainView(isUserLoggedIn: .constant(true))
}
