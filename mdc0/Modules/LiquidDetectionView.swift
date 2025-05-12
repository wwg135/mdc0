//
//  LiquidDetection.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct LiquidDetectionView: View {
    @State private var liquidDetectionStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(isIOS17OrLater() ? "Not supported on iOS 17+" : "Works on iOS 16.0 - 16.7.10, kill this app makes it disappear")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)

            HStack {
                Button(
                    liquidDetectionStatus == "Enabled"
                    ? "Disable"
                    : "Enable",
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
                .buttonStyle(.borderedProminent)
                .symbolRenderingMode(.hierarchical)

                Spacer()

                ActionStatusCircle(status: liquidDetectionStatus)
            }
        }
        .foregroundColor(.primary)
    }
}
