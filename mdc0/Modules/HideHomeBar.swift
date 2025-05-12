//
//  HideHomeBar.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct HideHomeBar: View {
    @State private var homeBarStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Hide Home Bar", systemImage: "arrow.down.to.line.compact") {
                homeBarStatus = execFile("/System/Library/PrivateFrameworks/MaterialKit.framework/Assets.car") ? "Success" : "Failed"
                Drops.show(Drop(
                    title: "Hide Home Bar",
                    subtitle: homeBarStatus,
                    icon: UIImage(systemName: "arrow.down.to.line.compact")
                ))
            }
            Divider()
            statusRow(label: "Home Bar Hiding Status", status: homeBarStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.orange)
    }
}

#Preview {
    HideHomeBar()
}
