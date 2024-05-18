//
//  ReminderCardButtonStyle.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/16/24.
//

import SwiftUI

struct ReminderCardButtonStyle: ButtonStyle {
    var color: Color
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
            Circle()
                .foregroundStyle(color)
                .opacity(0.9)
                .frame(maxWidth: 30)
                .mask(Circle().stroke(lineWidth: isPressed ? 40 : 4))
                .animation(.smooth(duration: 0.25), value: isPressed)
        }
}



fileprivate struct ButtonView: View {
    var body: some View {
        Button("yee1") {}
            .buttonStyle(ReminderCardButtonStyle(color: .yellow, isPressed: .constant(true)))
    }
}

#Preview {
    ButtonView()
}
