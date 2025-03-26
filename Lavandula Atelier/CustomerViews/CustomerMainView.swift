//
//  CustomerMainView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/18/25.
//

import SwiftUI

struct CustomerMainView: View {
    //@Binding var isUserLoggedIn: Bool  // Binding to update login state
    @EnvironmentObject var session: SessionManager  // shared session access

    var body: some View {
        VStack {
            
            VStack {
                        HeaderView()
                        Spacer()
                        BottomNavView(userRole: "customer")  //  Customer's navbar
                    }
        }
        
    }
}

#Preview {
    CustomerMainView()
        .environmentObject(SessionManager())
}
