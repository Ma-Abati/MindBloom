//
//  AboutUs View.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 16/07/25.
//

import SwiftUI

// Signature color (if needed elsewhere)
extension Color {
    static let appSignature = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255) // #B4CADF
}

// Hex color initializer (use this once!)
extension Color {
    /// Initialize Color from hex string like "#RRGGBB"
    init(fromHexString hexString: String) {
        let scanner = Scanner(string: hexString.trimmingCharacters(in: .whitespacesAndNewlines))
        _ = scanner.scanString("#") // skip leading #

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

// Creator model
struct CreatorInfo: Identifiable {
    let id = UUID()
    let name: String
    let from: String
    let favoriteColor: String
    let favoriteSubject: String
    let petPreference: String
    let favoriteFood: String
    let repeatSong: String
    let favoriteDrink: String
}

// Question/Answer view
struct QuestionAnswer: View {
    let question: String
    let answer: String
    
   
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            Text(question)
                .font(.body)
                .bold()
                .foregroundColor(.black)
            Text(answer)
                .font(.body)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        
    }
    
}

struct AboutUs_View: View {
    
    // Pastel colors for each creator's box
    let boxColors: [String: Color] = [
        "Maia F. Abati": Color(fromHexString: "#FFF9D6"),     // light yellow pastel
        "Thirrin Itchon": Color(fromHexString: "#FFD6E8"),    // pastel pink
        "Hafsa": Color(fromHexString: "#E6D6FF")               // pastel purple
    ]
    
    let creators: [CreatorInfo] = [
        .init(name: "Maia F. Abati",
              from: "São Paulo, Brazil",
              favoriteColor: "Don't really have one, but if I have to choose I guess light yellow or pink",
              favoriteSubject: "Biology",
              petPreference: "Flamingos, of course",
              favoriteFood: "Japanese AND Italian",
              repeatSong: "I wanna be the one you call by Benson Boone",
              favoriteDrink: "Hot Chocolate!!!"),
        
        .init(name: "Thirrin Itchon",
              from: "Florida, USA",
              favoriteColor: "My fav color is PINK",
              favoriteSubject: "English",
              petPreference: "Flamingos",
              favoriteFood: "Soba Noodles",
              repeatSong: "TV by mico",
              favoriteDrink: "Tea"),
        
        .init(name: "Hafsa",
              from: "Pakistan",
              favoriteColor: "It's purple",
              favoriteSubject: "English!",
              petPreference: "DOGS",
              favoriteFood: "Sandwiches",
              repeatSong: "Close to you by Gracie Abrams",
              favoriteDrink: "Hot chocolate!")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("About Us!")
                    .font(.custom("LibertinusMath-Regular", size: 40))
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                Text("Here are some fun facts about the creators of this app!!!")
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ForEach(creators) { creator in
                    VStack(alignment: .leading, spacing: 14) {
                        QuestionAnswer(question: "What's your name?", answer: creator.name)
                        QuestionAnswer(question: "Where are you from?", answer: creator.from)
                        QuestionAnswer(question: "What’s your favorite color?", answer: creator.favoriteColor)
                        QuestionAnswer(question: "Favorite subject in school?", answer: creator.favoriteSubject)
                        QuestionAnswer(question: "Dogs or cats (or... flamigos)?", answer: creator.petPreference)
                        QuestionAnswer(question: "What's your favorite food?", answer: creator.favoriteFood)
                        QuestionAnswer(question: "What’s one song you could listen to on repeat?", answer: creator.repeatSong)
                        QuestionAnswer(question: "Coffee, tea, or hot chocolate?", answer: creator.favoriteDrink)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 400) // Minimum height, grows if needed
                    .background(boxColors[creator.name] ?? Color.appSignature)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 40)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}


#Preview {
    AboutUs_View()
}
