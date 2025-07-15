//
//  FutureFeatures.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//

import SwiftUI

import SwiftUI

struct FutureFeatures: View {
    let signatureColor = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255)
    
    var body: some View {
        NavigationStack {
      
            VStack(spacing: 20) {
                
                Text("🌟 More Features 🌟")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                Spacer()                    
                
                NavigationLink(destination: GpaCalculator) {
                    Text("GPA Calculator")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                
                NavigationLink(destination: Text("Destination")) {
                    Text("Study-Care Balance")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                
                NavigationLink(destination: Text("Destination")) {
                    Text("Study Tips")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(signatureColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                
                NavigationLink(destination: Text("Destination")) {
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
