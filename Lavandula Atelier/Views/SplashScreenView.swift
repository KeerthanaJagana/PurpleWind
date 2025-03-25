//
//  SplashScreenView.swift
//  Lavandula Atelier
//
//  Created by Keerthana Jagana on 3/24/25.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView()  // Or LoginView()
        } else {
            ZStack {
                // Background Image with Opacity
                Image("bg") // Replace with your asset name
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.08) // 👈 Control transparency here (0.0 to 1.0)

                // Splash content (logo & text)
                VStack {
                    Image("Image") // Replace with your logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(100)

                    Text("Purple Wind")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    Text("A shopping experience like enver before")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black) // Adjust text color for contrast
                        .padding(.top, 20)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
