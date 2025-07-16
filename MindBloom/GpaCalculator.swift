//
//  GpaCalculator.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//
import SwiftUI

// MARK: - Custom Color
extension Color {
    static let customBlue = Color(hex: "#B4CADF")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Model
struct Course: Identifiable {
    let id = UUID()
    var selectedGrade: String = "A"
    var credits: String = ""
}

struct GpaCalculator: View {
    @State private var courses: [Course] = [Course()]
    @State private var calculatedGPA: Double?
    @State private var showCreditWarning = false

    let gradeOptions = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "F"]

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

        
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach($courses) { $course in
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Course \(courses.firstIndex(where: { $0.id == course.id })! + 1)")
                                    .font(.headline)
                                    .foregroundColor(.customBlue)

                                HStack(spacing: 16) {
                                    // Grade Picker
                                    Picker("Grade", selection: $course.selectedGrade) {
                                        ForEach(gradeOptions, id: \.self) { grade in
                                            Text(grade)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)

                                    // Credits Field
                                    TextField("Credits", text: $course.credits)
                                        .keyboardType(.decimalPad)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .onDelete(perform: deleteCourse)
                    }
                    .padding(.top)
                }

                if showCreditWarning {
                    Text("⚠️ Don’t forget to add your credits")
                        .foregroundColor(.red)
                        .padding(.bottom, 5)
                }

                HStack {
                    Button(action: {
                        courses.append(Course())
                    }) {
                        Label("Add Course", systemImage: "plus")
                            .foregroundColor(.customBlue)
                    }
                    .padding(.leading)

                    Spacer()

                    EditButton()
                        .foregroundColor(.customBlue)
                        .padding(.trailing)
                }

                Button(action: {
                    if courses.contains(where: { $0.credits.trimmingCharacters(in: .whitespaces).isEmpty }) {
                        showCreditWarning = true
                        calculatedGPA = nil
                    } else {
                        showCreditWarning = false
                        calculatedGPA = calculateGPA()
                    }
                }) {
                    Text("Calculate GPA")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.customBlue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                if let gpa = calculatedGPA {
                    Text("GPA: \(gpa, specifier: "%.2f")")
                        .font(.title2)
                        .padding(.top, 10)
                        .foregroundColor(.customBlue)
                }

                Spacer()
            }
            .navigationBarItems(leading:
                Text("GPA Calculator")
                    .font(.custom("LibertinusMath-Regular", size: 40))
            )
        }
    }

    // MARK: - Delete Course
    func deleteCourse(at offsets: IndexSet) {
        courses.remove(atOffsets: offsets)
    }

    // MARK: - GPA Calculation
    func calculateGPA() -> Double {
        var totalQualityPoints = 0.0
        var totalCredits = 0.0

        for course in courses {
            guard let credits = Double(course.credits), credits > 0 else { continue }
            let gradeValue = convertGradeToPoint(course.selectedGrade)

            let qualityPoints = gradeValue * credits
            totalQualityPoints += qualityPoints
            totalCredits += credits
        }

        return totalCredits > 0 ? totalQualityPoints / totalCredits : 0.0
    }

    func convertGradeToPoint(_ grade: String) -> Double {
        switch grade {
        case "A+", "A": return 4.0
        case "A-": return 3.7
        case "B+": return 3.3
        case "B": return 3.0
        case "B-": return 2.7
        case "C+": return 2.3
        case "C": return 2.0
        case "C-": return 1.7
        case "D+": return 1.3
        case "D": return 1.0
        case "F": return 0.0
        default: return 0.0
        }
    }
}

#Preview {
    GpaCalculator()
}
