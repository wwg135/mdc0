//
//  AppSwitcherBlur.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct AppSwitcherBlur: View {
    @State private var appSwitcherBlurStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Remove App Switcher Blur", systemImage: "square.stack.fill") {
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
            }
            .symbolRenderingMode(.hierarchical)

            statusRow(label: "App Switcher Blur Status", status: appSwitcherBlurStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.indigo)
    }
}

#Preview {
    AppSwitcherBlur()
}
