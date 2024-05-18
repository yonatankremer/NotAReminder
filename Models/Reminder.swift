//
//  Reminder.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/16/24.
//

import SwiftUI

struct Reminder: Identifiable, Equatable { // TODO: Reminder - implement Codable
    var date: Date
    var name: String
    var description: String
    let id: UUID
    var isDone: Bool
    var color: Color
    let createdIn: Date
    
    
    init(date: Date, name: String, description: String, id: UUID = UUID(), color: Color = Color.primary) {
        self.date = date
        self.name = name
        self.description = description
        self.id = id
        self.isDone = false
        self.color = color
        self.createdIn = Date.now
    }
    
    static let sample = Self.init(date: .now, name: "Beach Party", description: "Go to da party")
    static let empty = Self.init(date: .now, name: "", description: "")
    
}
