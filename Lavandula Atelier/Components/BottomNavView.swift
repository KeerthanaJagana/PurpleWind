//
//  BottomNavView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/21/25.
//

import SwiftUI

struct BottomNavView: View {
    let userRole: String  // Determines which tabs to show

    var body: some View {
        TabView {
            switch userRole {
            case "customer":
                customerTabs
            case "vendor":
                vendorTabs
            case "admin":
                adminTabs
            default:
                Text("Invalid Role")
            }
        }
        .accentColor(.purple) // Customize color theme
    }
    
    // MARK: - Customer Tabs
    private var customerTabs: some View {
        Group {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }

    // MARK: - Vendor Tabs
    private var vendorTabs: some View {
        Group {
            VendorDashboardView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Dashboard")
                }

            AddProductView()
                .tabItem {
                    Image(systemName: "plus.app.fill")
                    Text("Add Product")
                }

            OrdersView()
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Orders")
                }

            VendorProfileMainView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }

    // MARK: - Admin Tabs
    private var adminTabs: some View {
        Group {
            AdminDashboardView()
                .tabItem {
                    Image(systemName: "shield.fill")
                    Text("Dashboard")
                }

            VendorApprovalsView()
                .tabItem {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Approvals")
                }

            ManageUsersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Users")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    BottomNavView(userRole: "admin")  // Change to "vendor" or "admin" for other views
}
