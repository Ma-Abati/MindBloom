//
//  BalanceCalculator.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 16/07/25.
//

import SwiftUI

func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM yyyy" // "16 Jul 2025"
    return formatter.string(from: date)
}

extension Color {
    static let signatureColor = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255) // #B4CADF
    static let softGray = Color(red: 240/255, green: 240/255, blue: 240/255)
}

struct BalanceCalculator: View {
    @State private var studyHoursText = ""
    @State private var selfCareHoursText = ""
    @State private var ratio: Double? = nil
    @State private var message: String = ""
    @State private var emoji: String = ""
    
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

        
        ScrollView {
            VStack(spacing: 30) {
                Text(" Study / Self-Care Balance ")
                    .font(.custom("LibertinusMath-Regular", size: 32))
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)

                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Hours Studied per Day:")
                            .font(.custom("LibertinusMath-Regular", size: 18))
                            .bold()
                        TextField("e.g. 4", text: $studyHoursText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.signatureColor.opacity(0.3))
                            .cornerRadius(10)
                    }

                    Group {
                        Text("Hours Spent on Self-Care:")
                            .font(.custom("LibertinusMath-Regular", size: 18))
                            .bold()
                        TextField("e.g. 2", text: $selfCareHoursText)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.signatureColor.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                HStack(spacing: 15) {
                    Button(action: calculateRatio) {
                        Text("Calculate")
                            .font(.custom("LibertinusMath-Regular", size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.signatureColor)
                            .cornerRadius(15)
                    }

                    Button(action: resetCalculator) {
                        Text("Reset")
                            .font(.custom("LibertinusMath-Regular", size: 20))
                            .foregroundColor(.signatureColor)
                            .padding()
                            .background(Color.signatureColor.opacity(0.15))
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal)

                if let ratio = ratio {
                    VStack(spacing: 15) {
                        Text(String(format: "Study to Self-Care Ratio: %.2f", ratio))
                            .font(.custom("LibertinusMath-Regular", size: 22))
                            .bold()
                            .foregroundColor(.signatureColor)
                        
                        Text(emoji)
                            .font(.system(size: 50))

                        ProgressView(value: progressValue(for: ratio))
                            .progressViewStyle(LinearProgressViewStyle(tint: .signatureColor))
                            .padding(.horizontal)

                        Text(message)
                            .font(.custom("LibertinusMath-Regular", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }

                Spacer()

                Text("✨ Remember: Balance looks different every day. Do your best.")
                    .font(.custom("LibertinusMath-Regular", size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .padding(.horizontal)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    func calculateRatio() {
        guard let study = Double(studyHoursText),
              let selfCare = Double(selfCareHoursText),
              selfCare > 0 else {
            ratio = nil
            message = "Please enter valid positive numbers. Self-care must be more than 0."
            emoji = "⚠️"
            return
        }

        let result = study / selfCare
        ratio = result

        switch result {
        case ..<0.5:
            message = "You're giving self-care the attention it deserves 💆‍♀️"
            emoji = "🌷"
        case 0.5...1.5:
            message = "You're balancing things well, keep it up! ✨"
            emoji = "⚖️"
        default:
            message = "Try adding a bit more self-care to your routine ☕"
            emoji = "💡"
        }
    }

    func resetCalculator() {
        studyHoursText = ""
        selfCareHoursText = ""
        ratio = nil
        message = ""
        emoji = ""
    }

    func progressValue(for ratio: Double) -> Double {
        // Clamp ratio between 0...2 for display purposes
        let clamped = min(max(ratio / 2.0, 0), 1)
        return clamped
    }
}

#Preview {
    BalanceCalculator()
}
