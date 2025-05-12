//
//  HideHomeBar.swift
//  mdc0
//
//  Created by straight-tamago⭐️ on 2025/05/12.
//

import SwiftUI
import Drops

struct HideHomeBarView: View {
    @State private var homeBarStatus: String = ""
    
    var body: some View {
        HStack() {
            Button("Apply") {
                homeBarStatus = execFile("/System/Library/PrivateFrameworks/MaterialKit.framework/Assets.car") ? "Success" : "Failed"
                Drops.show(Drop(
                    title: "Hide Home Bar",
                    subtitle: homeBarStatus,
                    icon: UIImage(systemName: "arrow.down.to.line.compact")
                ))
            }
            .buttonStyle(.borderedProminent)

            Spacer()
            ActionStatusCircle(status: homeBarStatus)
        }
        .foregroundColor(.primary)
    }
}