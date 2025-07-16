//
//  StudyTipsPage.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 16/07/25.
//
//
//  StudyTipsPage.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 16/07/25.
//

//
//  StudyTipsPage.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 16/07/25.
//

import SwiftUI

// MARK: - Custom Color Extension
extension Color {
    init(hexString: String) {
        let scanner = Scanner(string: hexString.trimmingCharacters(in: .whitespacesAndNewlines))
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }

    static let signature = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255) // #B4CADF
}


// MARK: - Models
struct StudyTip: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let subjects: [String] // "All" for general
}

// MARK: - Main View
struct StudyTipsPage: View {
    let allSubjects = ["Math", "Biology", "History", "Chemistry", "Physics", "English", "Geography"]

    @State private var selectedSubjects: Set<String> = []
    @State private var showTips = false

    // Subject colors (pastel)
    let subjectColors: [String: Color] = [
        "Math": Color(hexString:"#FFD6D6"),
        "Biology": Color(hex: "#D6FFD6"),
        "History": Color(hex: "#FFF5D6"),
        "Chemistry": Color(hex: "#D6F0FF"),
        "Physics": Color(hex: "#F0D6FF"),
        "English": Color(hex: "#FFE6D6"),
        "Geography": Color(hex: "#E6FFE6")
    ]

    // General Tips
    let generalTips: [StudyTip] = [
        .init(title: "Goal‑setting & Schedule", detail: "Define target grades and create a flexible study timetable.", subjects: ["All"]),
        .init(title: "Skim Before Lecture", detail: "Preview upcoming content to interrupt the forgetting curve.", subjects: ["All"]),
        .init(title: "Energy Tracking", detail: "Study when your energy peaks, not when it's convenient.", subjects: ["All"]),
        .init(title: "Active Recall & Spaced Repetition", detail: "Use flashcards & repeat quizzes over time.", subjects: ["All"])
    ]

    // Subject-Specific Tips
    let subjectTips: [StudyTip] = [
        .init(title: "Solve Past Papers", detail: "Practicing math problems helps spot patterns.", subjects: ["Math"]),
        .init(title: "Use Concept Maps", detail: "Biology is visual. Draw cycles and processes.", subjects: ["Biology"]),
        .init(title: "Build Timelines", detail: "For History, placing events chronologically boosts recall.", subjects: ["History"]),
        .init(title: "Learn Mnemonics", detail: "Chemistry facts stick better with acronyms.", subjects: ["Chemistry"]),
        .init(title: "Understand Formulas", detail: "Physics problems become easier once you grasp the formulas.", subjects: ["Physics"]),
        .init(title: "Quote and Context", detail: "Practice matching quotes with literary themes.", subjects: ["English"]),
        .init(title: "Use Maps & Diagrams", detail: "For Geography, visual memory is powerful. Practice map labeling.", subjects: ["Geography"])
    ]

    var filteredGeneralTips: [StudyTip] {
        generalTips.filter { $0.subjects.contains("All") }
    }

    func tips(for subject: String) -> [StudyTip] {
        subjectTips.filter { $0.subjects.contains(subject) }
    }

    func backgroundColor(for subject: String) -> Color {
        subjectColors[subject] ?? Color.gray.opacity(0.1)
    }

    var body: some View {
        NavigationView {
            if !showTips {
                // Subject Selection
                VStack {
                    Text("Choose your subjects:")
                        .font(.title2)
                        .padding()

                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(allSubjects, id: \.self) { subject in
                                Button(action: {
                                    if selectedSubjects.contains(subject) {
                                        selectedSubjects.remove(subject)
                                    } else {
                                        selectedSubjects.insert(subject)
                                    }
                                }) {
                                    Text(subject)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(selectedSubjects.contains(subject) ? Color.signature.opacity(0.6) : Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Button("Show Tips") {
                        showTips = true
                    }
                    .padding()
                    .background(Color.signature)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
                }
                .navigationBarHidden(true)

            } else {
                // Tips Screen
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        // General Tips Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("General Study Tips")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.signature)
                                .padding(.horizontal)

                            ForEach(filteredGeneralTips) { tip in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(tip.title)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text(tip.detail)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                                .background(Color.signature.opacity(0.2))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }

                        // Subject-Specific Tips Section
                        ForEach(Array(selectedSubjects), id: \.self) { subject in
                            VStack(alignment: .leading, spacing: 16) {
                                Text("\(subject) Tips")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.signature)
                                    .padding(.horizontal)

                                ForEach(tips(for: subject)) { tip in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(tip.title)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Text(tip.detail)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                    }
                                    .padding()
                                    .background(backgroundColor(for: subject))
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                }
                            }
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.top)
                }
                .navigationTitle("Study Tips")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back") {
                            showTips = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    StudyTipsPage()
}
