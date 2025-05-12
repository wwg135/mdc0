//
//  HideDock.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct HideDockView: View {
    @State private var darkDockStatus: String = ""
    @State private var lightDockStatus: String = ""
    
    var body: some View {
        HStack {
            Button("Apply") {
                darkDockStatus = execFile("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockDark.materialrecipe") ? "Success" : "Failed"
                lightDockStatus = execFile("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockLight.materialrecipe") ? "Success" : "Failed"
                Drops.show(Drop(
                    title: "Hide Dock",
                    subtitle: "Light: \(lightDockStatus), Dark: \(darkDockStatus)",
                    icon: UIImage(systemName: "dock.rectangle")
                ))
            }
            .buttonStyle(.borderedProminent)

            Spacer()

            ActionStatusCircle(status: determineOverallDockStatus())
        }
        .foregroundColor(.primary)
    }

    private func determineOverallDockStatus() -> String {
        if darkDockStatus.isEmpty && lightDockStatus.isEmpty {
            return ""
        }
        if darkDockStatus == "Success" && lightDockStatus == "Success" {
            return "Success"
        }
        if darkDockStatus == "Failed" || lightDockStatus == "Failed" || (darkDockStatus == "Success" && lightDockStatus.isEmpty) || (lightDockStatus == "Success" && darkDockStatus.isEmpty) {
            return "Failed"
        }
        return "" 
    }
}