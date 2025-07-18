//
//  FutureFeatures.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//

import SwiftUI


struct FutureFeatures: View {
    let signatureColor = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255)
    
    var body: some View {
        HStack {
            Text(formattedDate(Date()))
                .font(.callout)
                .foregroundColor(.black)

            Spacer()

            Text("MindBloom")
                .font(.custom("LibertinusMath-Regular", size: 23))
                .foregroundColor(.black)
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .zIndex(1) // Keeps it above background if needed

        
        NavigationStack {
      
            VStack(spacing: 20) {
                
                Text("More Features 🌟")
                       .font(.custom("LibertinusMath-Regular", size: 50))
                       .bold()
                       .foregroundColor(.black)
                       .multilineTextAlignment(.center)
                       .padding(.top, 40) // adjust this number as needed

                   Spacer()
                
                NavigationLink(destination: GpaCalculator()) {
                    Text("GPA Calculator")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                
                NavigationLink(destination: BalanceCalculator()) {
                    Text("Study-Care Balance Calculator")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                
                NavigationLink(destination: StudyTipsPage()) {
                    Text("Study Tips")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                
                NavigationLink(destination: AboutUs_View()) {
                    Text("About Us")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                Spacer()
            }
        }
    }
}

    
#Preview {
    FutureFeatures()
}
