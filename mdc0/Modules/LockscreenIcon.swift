//
//  LockscreenIcon.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct LockscreenIcon: View {
    @State private var lockscreenIconsStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Hide LS Flash & Camera", systemImage: "bolt.slash.fill") {
                lockscreenIconsStatus = execFile("/System/Library/PrivateFrameworks/CoverSheet.framework/Assets.car") ? "Success" : "Failed"
                Drops.show(Drop(
                    title: "Hide LS Flash & Camera",
                    subtitle: lockscreenIconsStatus,
                    icon: UIImage(systemName: "bolt.slash.fill")
                ))
            }
            .symbolRenderingMode(.hierarchical)

            statusRow(label: "Lockscreen Icon Status", status: lockscreenIconsStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.cyan)
    }
}

#Preview {
    LockscreenIcon()
}
