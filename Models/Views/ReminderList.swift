//
//  ReminderList.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/16/24.
//

import SwiftUI

struct ReminderList: View {
    @State private var reminders = [Reminder.sample]
    @State private var showingNewReminderSheet = false
    @State private var showingEditReminderSheet = false
    @State private var trigger = false
    @State private var currentReminderIndex = 0
    
    var body: some View {
        NavigationStack {
            Section {
                List($reminders) { reminder in
                    ReminderCard(reminder: reminder, trigger: $trigger)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                    reminders.remove(
                                        at: reminder.wrappedValue.getIndex(list: reminders))
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                currentReminderIndex = reminder.wrappedValue.getIndex(list: reminders)
                                showingEditReminderSheet = true
                            } label: {
                                Image(systemName: "gearshape.2")
                            }
                            .tint(.blue)
                        }
                }
                .onChange(of: trigger) {
                    withAnimation(.smooth) {
                        reminders = reminders.sorted {
                            $0.isBefore(r: $1)
                        }
                    }
                }
            }
            .navigationTitle("Not a Reminder App")
            .toolbar {
                Button {
                    showingNewReminderSheet.toggle()
                } label: {
                    Image(systemName: "plus").padding()
                }
                .sheet(isPresented: $showingNewReminderSheet) {
                    NewReminder(reminders: $reminders, isShowingView: $showingNewReminderSheet, trigger: $trigger)
                }
                .sheet(isPresented: $showingEditReminderSheet) {
                    EditReminder(reminder: $reminders[currentReminderIndex], reminders: $reminders, isShowingView: $showingEditReminderSheet, trigger: $trigger)
                }
            }
        }
    }
}

extension Reminder {
    func isBefore(r: Reminder) -> Bool {
        if !self.isDone && r.isDone {
            return true
        }
        return self.createdIn > r.createdIn
    }
    
    func getIndex(list: [Reminder]) -> Int {
        for i in 0..<list.count {
            if self.id == list[i].id {
                return i
            }
        }
        return -1
    }
    
}

#Preview {
    ReminderList()
}
