//
//  Notes.swift
//  MindBloom
//
//  Created by Maia Fattori Abati on 15/07/25.
//
import SwiftUI

struct Note: Identifiable, Equatable {
    let id = UUID()
    var text: String
}

struct Notes: View {
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }

    @State private var notes: [Note] = []
    @State private var newNote: String = ""
    @State private var selectedNote: Note? = nil
    @State private var editedText: String = ""
    
    let signatureColor = Color(red: 180 / 255, green: 202 / 255, blue: 223 / 255) // #B4CADF
    
    var body: some View {
        VStack(spacing: 16) {
            Text(" My Notes")
                .font(.title)
                .bold()
                .foregroundColor(.black)
            
            if let selected = selectedNote {
                // Edit mode
                VStack(alignment: .leading, spacing: 10) {
                    Text("Editing Note")
                        .font(.headline)
                        .foregroundColor(signatureColor)
                    
                    TextEditor(text: $editedText)
                        .frame(height: 150)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(signatureColor, lineWidth: 1))
                    
                    HStack {
                        Button("Save") {
                            saveEditedNote()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(signatureColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Cancel") {
                            selectedNote = nil
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(signatureColor)
                    }
                }
                .padding()
            } else {
                // Add mode
                HStack {
                    TextField("Type a note...", text: $newNote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: addNote) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(signatureColor)
                    }
                    .padding(.trailing)
                }
            }
            
            // Notes list
            List {
                ForEach(notes) { note in
                    Button {
                        selectNote(note)
                    } label: {
                        Text(note.text)
                            .lineLimit(1)
                            .foregroundColor(.primary)
                    }
                }
                .onDelete(perform: deleteNote)
            }
        }
        .padding(.top)
        .background(Color.white)
    }
    
    // MARK: - Logic
    
    func addNote() {
        let trimmed = newNote.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        notes.insert(Note(text: trimmed), at: 0)
        newNote = ""
    }
    
    func selectNote(_ note: Note) {
        selectedNote = note
        editedText = note.text
    }
    
    func saveEditedNote() {
        guard let selected = selectedNote else { return }
        if let index = notes.firstIndex(of: selected) {
            notes[index].text = editedText
        }
        selectedNote = nil
    }
}
    #Preview {
       Notes()
    }
