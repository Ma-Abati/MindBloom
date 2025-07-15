//
//  ContentView.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    let currentDate = Date()
    let quotes = [
        "Believe in yourself.",
        "Stay curious.",
        "Dream big. Start small.",
        "Make today count.",
        "Progress, not perfection."
    ]
    
    @State private var selectedQuote = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(formattedDate(currentDate))
                    .font(.callout)
                    .foregroundColor(.black)
                Spacer() // Push content to the left
                Text("MindBloom")
            }
            .padding(.horizontal)
            .padding(.top, 10)
            Spacer()
            ZStack {
                
                       Color.white.edgesIgnoringSafeArea(.all) // background color

                       Text(selectedQuote)
                           .font(.title2)
                           .foregroundColor(.black)
                           .multilineTextAlignment(.center)
                           .padding()
                   }
                   .onAppear {
                       selectedQuote = quotes.randomElement() ?? ""
                   }
            Spacer()
            HStack {
                Button("Notes") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Button("Calendar") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Button("HomePage") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            Button("To-do List") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            Button("More") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }
            .padding(.bottom,20)
           
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
