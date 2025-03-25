//
//  CustomerMainView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/18/25.
//

import SwiftUI

struct CustomerMainView: View {
    @Binding var isUserLoggedIn: Bool  // Binding to update login state
    
    var body: some View {
        VStack {
            
            VStack {
                        HeaderView(isUserLoggedIn: $isUserLoggedIn)
                        Spacer()
                        BottomNavView(userRole: "customer")  //  Customer's navbar
                    }
        }
        
    }
}

#Preview {
    CustomerMainView(isUserLoggedIn: .constant(true))
}
