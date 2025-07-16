//
//  ToDo.swift
//  MindBloom
//
//  Created by rin on 7/16/25.
//

import SwiftUI
struct Task: Identifiable, Equatable {
    let id = UUID()
    var text: String
}
struct ToDo: View {
    
    @State private var tasks: [Task] = []
    @State private var newTask: String = ""
    @State private var selectedTask: Task? = nil
    @State private var editedText: String = ""
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    let signatureColor = Color(red: 180 / 255, green: 202 / 255, blue: 233 / 255)
    
    var body: some View {
        VStack(spacing: 16) {
            Text("To Do")
                .font(.custom("LibertinusMath-Regular", size: 30))
                .bold()
                .foregroundColor(.black)
            if let selected = selectedTask {
                VStack (alignment: .leading, spacing: 10) {
                    Text("Editing Note")
                        .font(.headline)
                        .foregroundColor(signatureColor)
                    TextEditor(text: $editedText)
                        .frame(height:150)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(signatureColor, lineWidth: 1))
                    HStack {
                        Button("Save") {
                            saveEditedTask()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(signatureColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Cancel") {
                            selectedTask = nil
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(signatureColor)
                    }
                }
                .padding()
            } else {
                HStack {
                    TextField("Type task...", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Button(action: addTask) {
                        Image(systemName: "plus.cicrcle.fill")
                            .resizable()
                            .frame(width:32, height: 32)
                            .foregroundColor(signatureColor)
                    }
                    .padding(.trailing)
                }
            }
            List {
                ForEach(tasks) { task in
                    Button  {
                        selectTask(task)
                    } label: {
                        Text(task.text)
                            .lineLimit(1)
                            .foregroundColor(.primary)
                    }
                }
                .onDelete(perform: deleteTask)
            }
        }
        .padding(.top)
        .background(Color.white)
    }
    func addTask() {
        let trimmed = newTask.trimmingCharacters(in:.whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tasks.insert(Task(text: trimmed), at: 0)
        newTask = ""
    }
    
    func selectTask(_ task: Task) {
        selectedTask = task
        editedText = task.text
    }
    
    func saveEditedTask() {
        guard let selected = selectedTask else { return }
        if let index = tasks.firstIndex(of:selected) {
            tasks[index].text = editedText
        }
        selectedTask = nil
    }
}
#Preview {
    let view = ToDo ()
    return view
}


