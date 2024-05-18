//
//  MainContainer.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/18/24.
//

import SwiftUI
import UserNotifications

struct MainContainer: View {
    @State private var isFirstAppear = true
    
    var body: some View {
        ReminderList()
            .onAppear {
                if isFirstAppear {
                    isFirstAppear = false
                    
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}

func addNotification(r: Reminder) -> Void {
    let content = UNMutableNotificationContent()
    content.title = r.name
    content.subtitle = r.description
    content.sound = UNNotificationSound.default

    // show this notification five seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: r.date.timeIntervalSinceNow, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // add our notification request
    UNUserNotificationCenter.current().add(request)
}

#Preview {
    MainContainer()
}
