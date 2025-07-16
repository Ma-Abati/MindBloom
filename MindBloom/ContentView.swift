//
//  ContentView.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//

import SwiftUI
import SwiftData 

struct ContentView: View {
    let currentDate = Date()
    let quotes = [
        "Believe in yourself.",
        "Brains, beauty, both.",
        "Dream big. Start small.",
        "Make today count.",
        "Progress, not perfection.",
        "Boss mode: ON.",
        "Study hard, glow harder.",
        "Pretty focused.",
        "Bloom where you're planted.",
        "You're doing better than you think.",
        "Let yourself bloom.",
        "Balance is power.",
        "You’re growing, even on slow days.",
        "Focused, not perfect.",
        "Your future is built today.",
        "Notes now, naps later.",
        "You're not behind. You're building.",
        "Your potential is blooming.",
        "Girls with goals run the world.",
        "Confidence looks good on you.",
        "Keep glowing, keep growing.",
        "Success is your vibe.",
        "You’re unstoppable, babe.",
        "Smart looks good on you.",
        "Dream it. Plan it. Do it.",
        "Your mind is your superpower.",
        "Study now, shine later.",
        "Turn the page, level up.",
        "Every page you read is a step closer.",
        "A little progress every day = big results.",
        "Fuel your focus.",
        "Grades don’t define you — effort does.",
    ]
    
    @State private var selectedQuote = ""
    
    var body: some View {
        NavigationStack {
        VStack {
            HStack {
                Text(formattedDate(currentDate))
                    .font(.callout)
                    .foregroundColor(.black)
                Spacer() // Push content to the left
                Text("MindBloom")
                    .font(.custom("LibertinusMath-Regular",size: 23) )
            
            }
            .padding(.horizontal)
            .padding(.top, 10)
            Spacer()
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all) // Full-screen background color

                Image("MindBloomflower") // Replace with your image asset name
                    .resizable()
                    .scaledToFit()
                    .opacity(0.4) // Optional: makes sure it doesn't overpower the text
                    .frame(maxWidth: 400, maxHeight: 400) // Adjust size as needed

                Text(selectedQuote)
                    .font(.custom("LibertinusMath-Regular",size: 30) )
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .onAppear {
                selectedQuote = quotes.randomElement() ?? ""
            }
        
            Spacer()
           
           
                HStack {
                    NavigationLink(destination: Notes()) {
                        Image("NotesIcon")
                            .resizable()
                            .frame(width: 70, height: 70) // size of the image
                    }
                    NavigationLink(destination: CalendarView()) {
                        Image("CalendarIcon")
                            .resizable()
                            .frame(width: 70, height: 70) // size of the image
                    }
                    NavigationLink(destination: ContentView()) {
                        Image("HomeIcon")
                            .resizable()
                            .frame(width: 70, height: 70) // size of the image
                    }
                    NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        Image("ToDoIcon")
                            .resizable()
                            .frame(width: 70, height: 70) // size of the image
                    }
                    NavigationLink(destination: FutureFeatures()) {
                        Image("SettingsIcon")
                            .resizable()
                            .frame(width: 70, height: 70) // size of the image
                    }
                }
            }
           
        }
    }
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)}
    
  
    }



#Preview {
    ContentView()
}
