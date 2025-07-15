//
//  GpaCalculator.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//
import SwiftUI
struct  GpaCalculator: View {
            let signatureColor = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255)

            @State private var grades: [String] = Array(repeating: "", count: 5)
            @State private var credits: [String] = Array(repeating: "", count: 5)

            var body: some View {
                NavigationStack {
                    VStack(spacing: 30) {
                        Text("MindBloom GPA Calculator")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(signatureColor)
                            .padding(.top, 40)

                        VStack(spacing: 15) {
                            ForEach(0..<5) { index in
                                HStack {
                                    TextField("Grade (e.g. 4.0)", text: $grades[index])
                                        .keyboardType(.decimalPad)
                                        .padding()
                                        .background(signatureColor.opacity(0.2))
                                        .cornerRadius(10)
                                        .frame(maxWidth: .infinity)

                                    TextField("Credits", text: $credits[index])
                                        .keyboardType(.numberPad)
                                        .padding()
                                        .background(signatureColor.opacity(0.2))
                                        .cornerRadius(10)
                                        .frame(width: 80)
                                }
                            }
                        }
                        .padding(.horizontal)

                        Button(action: {
                            // Calculate GPA action (to implement)
                        }) {
                            Text("Calculate GPA")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(signatureColor)
                                .cornerRadius(15)
                                .shadow(color: signatureColor.opacity(0.5), radius: 5, x: 0, y: 3)
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .background(Color.white.ignoresSafeArea())
                }
            }
        }

    



#Preview {
    GpaCalculator()
}
