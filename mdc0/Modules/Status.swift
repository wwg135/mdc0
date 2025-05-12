//
//  Untitled.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI

struct Status: View {
    var body: some View {
        Section("Status") {
            HStack {
                Text("None")
                    .foregroundStyle(.white)
                Spacer()
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(uiColor: .lightGray))
                    .background {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
            }
            HStack {
                Text("Success")
                    .foregroundStyle(.white)
                Spacer()
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .background {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
            }
            HStack {
                Text("Failed")
                    .foregroundStyle(.white)
                Spacer()
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.red)
                    .background {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
            }
        }
        .listRowBackground(Color.teal)
    }
}


