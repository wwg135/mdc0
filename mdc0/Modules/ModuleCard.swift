//
//  ModuleCard.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI

struct ModuleCard<Content: View>: View {
    let title: String
    let icon: String
    let backgroundColor: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding([.top, .horizontal])

            content
                .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(color: backgroundColor.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}
