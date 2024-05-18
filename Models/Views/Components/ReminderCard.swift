//
//  ReminderView.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/16/24.
//

import SwiftUI

struct ReminderCard: View {
    @Binding var reminder: Reminder
    @State private var showingEdit = false
    @Binding var trigger: Bool
    
    var body: some View {
        HStack {
            
            Button("") {
                reminder.isDone.toggle()
                trigger.toggle()
            }
            .buttonStyle(ReminderCardButtonStyle(color: reminder.color, isPressed: $reminder.isDone))
            
            VStack(alignment: .leading) {
                Text(reminder.name)
                    .fontWeight(.medium)
                
                Text(reminder.description)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                    Text("\(reminder.date.formatted(date: .numeric, time:.omitted))")
                }
                
                    HStack {
                        Image(systemName: "clock")
                        Text("\(reminder.date.formatted(date: .omitted, time: .shortened))")
                    }
            }
            .foregroundStyle(reminder.date < Date.now ? .red : .black.weightedAverage(reminder.color, by: 0.5))
        }
        .padding()
        .opacity(reminder.isDone ? 0.5 : 1)
    }
}

extension Color {
    func weightedAverage(_ other: Color = .primary, by: Double) -> Color {
        
        if by > 1 {
            return other
        }
        
        if by < 0 {
            return self
        }
        
        let selfRgb = UIColor(self).cgColor.components ?? UIColor.red.cgColor.components!
        let otherRgb = UIColor(other).cgColor.components ?? UIColor.red.cgColor.components!
        
        let newRed = ((1-by)*selfRgb[0] + by*otherRgb[0])/2
        let newGreen = ((1-by)*selfRgb[1] + by*otherRgb[1])/2
        let newBlue = ((1-by)*selfRgb[2] + by*otherRgb[2])/2
        
        return Self.init(red: newRed, green: newGreen, blue: newBlue)
    }
}

#Preview {
    ReminderCard(reminder: Binding.constant(Reminder.sample), trigger: .constant(false))
}

