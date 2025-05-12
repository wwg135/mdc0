//
//  AppSwitcherBlur.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct RemoveAppSwitcherBlurView: View {
    @State private var appSwitcherBlurStatus: String = ""
    
    var body: some View {
        HStack {
            Button("Apply") {
                let paths = [
                    "/System/Library/PrivateFrameworks/SpringBoard.framework/homeScreenBackdrop-application.materialrecipe",
                    "/System/Library/PrivateFrameworks/SpringBoard.framework/homeScreenBackdrop-switcher.materialrecipe"
                ]
                let successCount = execFiles(paths)
                appSwitcherBlurStatus = "Success: \(successCount)/\(paths.count) files processed"
                Drops.show(Drop(
                    title: "Remove App Switcher Blur",
                    subtitle: appSwitcherBlurStatus,
                    icon: UIImage(systemName: "square.stack.fill")
                ))
                appSwitcherBlurStatus = successCount == paths.count ? "Success" : "Failed"
            }
            .buttonStyle(.borderedProminent)

            Spacer()

            ActionStatusCircle(status: appSwitcherBlurStatus)
        }
        .foregroundColor(.primary)
    }
}
