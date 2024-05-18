//
//  ColorGrid.swift
//  NotAReminder
//
//  Created by Yonatan Kremer on 5/16/24.
//

import SwiftUI

struct ColorGrid: View {
    let colors: [Color] = [.black, .gray, .green, .brown, .red, .cyan, .yellow]
    
    var body: some View {
        Group {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50), spacing: 25)], content: {
                ForEach(colors, id: \.self) { color in
                    Button {
                     print("hry")
                    } label: {
                        Circle()
                            .foregroundStyle(color)
                            .padding(5)
                    }
                    
                }
            })
            .background(.fill)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        }
    }
}

#Preview {
    ColorGrid()
}
