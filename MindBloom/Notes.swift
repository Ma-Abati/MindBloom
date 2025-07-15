//
//  Notes.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//

import SwiftUI

struct Notes: View {

        @State private var notes: [String] = []
        @State private var newNote: String = ""

        var body: some View {
            VStack {
                // Input field and Add button
                HStack {
                    TextField("Type a note...", text: $newNote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: addNote) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                // Notes list
                List {
                    ForEach(notes, id: \.self) { note in
                        Text(note)
                    }
                    .onDelete(perform: deleteNote)
                }
            }
        }

        // Add note if it's not empty
        func addNote() {
            let trimmed = newNote.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { return }
            notes.insert(trimmed, at: 0)
            newNote = ""
        }

        // Swipe to delete
        func deleteNote(at offsets: IndexSet) {
            notes.remove(atOffsets: offsets)
        }
    }



#Preview {
    Notes()
}
