//
//  Calendar.swift
//  MindBloom
//
//  Created by Hafsa Ahmad on 15/07/2025.
//

import SwiftUI

struct Event: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let title: String
    let notes: String
}

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var events: [Event] = []
    @State private var showingAddEvent = false
    @State private var newEventTitle = ""
    @State private var newEventNotes = ""
    @State private var selectedDate = Date()
    
    let customBlue = Color(red: 180/255, green: 202/255, blue: 223/255)
    private var groupedEvents: [GroupedEvents] {
        let grouped = Dictionary(grouping: events) { event in
            Calendar.current.startOfDay(for: event.date)
        }
        
        return grouped.map { date, events in
            GroupedEvents(date: date, events: events.sorted { $0.date > $1.date })
        }.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 15) {
                HStack {
                    Button(action: { changeMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .foregroundColor(customBlue)
                    }
                    
                    Text(monthYearFormatter.string(from: currentDate))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(customBlue)
                    
                    Button(action: { changeMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .font(.headline)
                            .foregroundColor(customBlue)
                    }
                }
                .padding(.horizontal)
                
                let daySymbols = ["S", "M", "T", "W", "T", "F", "S"]
                HStack {
                    ForEach(daySymbols, id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(daysInMonth(for: currentDate), id: \.self) { date in
                        if Calendar.current.isDate(date, equalTo: currentDate, toGranularity: .month) {
                            DateView(
                                date: date,
                                isToday: isToday(date),
                                isSelected: isSelected(date),
                                hasEvents: hasEvents(on: date),
                                action: { selectedDate = date }
                            )
                        } else {
                            Text("").frame(height: 30)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .padding()
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            List {
                if groupedEvents.isEmpty {
                    Text("No events added yet")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                } else {
                    ForEach(groupedEvents) { group in
                        Section(header:
                            Text(group.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        ) {
                            ForEach(group.events) { event in
                                EventRow(event: event)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            deleteEvent(event)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            
            Button(action: { showingAddEvent = true }) {
                Label("Add New Event", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .tint(customBlue)
            
        }
        .navigationTitle("Calendar")
        .sheet(isPresented: $showingAddEvent) {
            addEventView
        }
    }
    
    private var addEventView: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                TextField("Title", text: $newEventTitle)
                TextField("Notes", text: $newEventNotes)
            }
            .navigationTitle("New Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showingAddEvent = false
                        clearForm()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newEvent = Event(
                            date: selectedDate,
                            title: newEventTitle,
                            notes: newEventNotes
                        )
                        events.append(newEvent)
                        showingAddEvent = false
                        clearForm()
                    }
                    .disabled(newEventTitle.isEmpty)
                }
            }
        }
    }
    
    private struct EventRow: View {
        let event: Event
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                Text(event.notes)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(event.date.formatted(date: .omitted, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
    }
    
    private struct DateView: View {
        let date: Date
        let isToday: Bool
        let isSelected: Bool
        let hasEvents: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                VStack(spacing: 2) {
                    Text("\(Calendar.current.component(.day, from: date))")
                        .frame(width: 30, height: 30)
                        .background(isToday ? Color.customBlue : (isSelected ? Color.gray.opacity(0.3) : Color.clear))
                        .foregroundColor(isToday ? .white : .primary)
                        .clipShape(Circle())
                    
                    if hasEvents {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 5, height: 5)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
    
    struct GroupedEvents: Identifiable {
        let id = UUID()
        let date: Date
        let events: [Event]
    }
    
    private func clearForm() {
        newEventTitle = ""
        newEventNotes = ""
    }
    
    private func hasEvents(on date: Date) -> Bool {
        events.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    private func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
    
    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
    
    private func isSelected(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: selectedDate)
    }
    
    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: Date())
    }
    
    private func daysInMonth(for date: Date) -> [Date] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: date),
              let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }
        
        return (0..<42).compactMap { dayOffset in
            Calendar.current.date(byAdding: .day, value: dayOffset, to: monthFirstWeek.start)
        }
    }
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
