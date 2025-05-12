//
//  LiquidDetection.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct LiquidDetection: View {
    @State private var liquidDetectionStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(isIOS17OrLater() ? "Not supported on iOS 17+" : "Works on iOS 16.0 - 16.7.10, kill this app makes it disappear")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.bottom, 5)

            Button(
                liquidDetectionStatus == "Enabled"
                ? "Disable Liquid Detection Icon"
                : "Enable Liquid Detection Icon",
                systemImage: liquidDetectionStatus == "Enabled" ? "drop" : "drop.fill"
            ) {
                let willEnable = liquidDetectionStatus != "Enabled"
                let isSupported = toggleLiquidDetectionIcon(isEnabled: willEnable)

                if isSupported {
                    liquidDetectionStatus = willEnable ? "Enabled" : "Disabled"
                    Drops.show(Drop(
                        title: "Liquid Detection",
                        subtitle: willEnable ? "Icon enabled" : "Icon disabled",
                        icon: UIImage(systemName: willEnable ? "drop.fill" : "drop")
                    ))
                } else {
                    Drops.show(Drop(
                        title: "Liquid Detection",
                        subtitle: "Not supported on iOS 17+",
                        icon: UIImage(systemName: "exclamationmark.triangle")
                    ))
                }
            }
            .symbolRenderingMode(.hierarchical)

            statusRow(label: "Liquid Detection Status", status: liquidDetectionStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.blue)
    }
}

#Preview {
    LiquidDetection()
}
