//
//  SharedComponents.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI

@ViewBuilder
func statusRow(label: String, status: String) -> some View {
    HStack {
        Text(label)
        Spacer()
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(status.isEmpty ? .gray : status == "Success" ? .green : .red)
            .background {
                Circle().stroke(.white, lineWidth: 3)
            }
    }
}
