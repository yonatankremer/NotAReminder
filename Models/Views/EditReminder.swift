//
//  EditReminder.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/17/24.
//

import SwiftUI

struct EditReminder: View {
    @Binding var reminder: Reminder
    @Binding var reminders: [Reminder]
    @Binding var isShowingView: Bool
    @Binding var trigger: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.name)
                TextField("Description", text: $reminder.description)
                DatePicker("Date", selection: $reminder.date, in: Date.now...)
                ColorPicker("Color", selection: $reminder.color, supportsOpacity: false)
                
            }
            .navigationTitle("Edit Reminder")
            .toolbar {
                Button("Done") {
                    if (!reminder.name.isEmpty) {
                        reminders.sort(by: { a,b in
                            a.isBefore(r: b)
                        })
                        trigger.toggle()
                        // TODO: Change notification timing after edit
                    }
                    isShowingView = false
                }
            }
        }
    }
}

 #Preview {
     EditReminder(reminder: .constant(.empty), reminders: .constant([.empty]), isShowingView: .constant(true), trigger: .constant(false))
 }
