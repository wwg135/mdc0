//
//  Untitled.swift
//  mdc0
//
//  Created by straight-tamago⭐️ on 2025/05/12.
//

import SwiftUI

struct ActionStatusCircle: View {
    var status: String

    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(color(for: status))
            .background {
                Circle()
                    .stroke(.primary, lineWidth: 3)
            }
    }

    private func color(for status: String) -> Color {
        switch status {
        case "Success":
            return .green
        case "Failed":
            return .red
        default:
            return Color(uiColor: .lightGray)
        }
    }
}

struct StatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("None")
                    .foregroundStyle(.primary)
                Spacer()
                ActionStatusCircle(status: "")
            }
            HStack {
                Text("Success")
                    .foregroundStyle(.primary)
                Spacer()
                ActionStatusCircle(status: "Success")
            }
            HStack {
                Text("Failed")
                    .foregroundStyle(.primary)
                Spacer()
                ActionStatusCircle(status: "Failed")
            }
        }
    }
}
