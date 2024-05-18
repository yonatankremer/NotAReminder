//
//  NewReminder.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/16/24.
//

import SwiftUI

struct NewReminder: View {
    @State private var name = ""
    @State private var description = ""
    @State private var date = Date.now
    @State private var color = Color.primary
    
    @Binding var reminders: [Reminder]
    @Binding var isShowingView: Bool
    @Binding var trigger: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $name)
                TextField("Description", text: $description)
                DatePicker("Date", selection: $date, in: Date.now...)
                ColorPicker("Color", selection: $color, supportsOpacity: false)
                
            }
            .navigationTitle("New Reminder")
            .toolbar {
                Button("Done") {
                    if (!name.isEmpty && date > Date.now) {
                        let r = Reminder(date: date, name: name, description: description, color: color)
                        reminders.append(r)
                        reminders.sort(by: { a,b in
                            a.isBefore(r: b)
                        })
                        addNotification(r: r)
                    }
                    isShowingView = false
                }
            }
        }
    }
}



#Preview {
    NewReminder(reminders: .constant([Reminder.sample]), isShowingView: .constant(true), trigger: .constant(false))
}
