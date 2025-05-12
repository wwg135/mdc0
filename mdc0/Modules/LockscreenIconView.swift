//
//  LockscreenIcon.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct LockscreenIconView: View {
    @State private var lockscreenIconsStatus: String = ""
    
    var body: some View {
        HStack {
            Button("Apply") {
                lockscreenIconsStatus = execFile("/System/Library/PrivateFrameworks/CoverSheet.framework/Assets.car") ? "Success" : "Failed"
                Drops.show(Drop(
                    title: "Hide LS Flash & Camera",
                    subtitle: lockscreenIconsStatus,
                    icon: UIImage(systemName: "bolt.slash.fill")
                ))
            }
            .buttonStyle(.borderedProminent)

            Spacer()

            ActionStatusCircle(status: lockscreenIconsStatus)
        }
        .foregroundColor(.primary)
    }
}