//
//  HideDock.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct HideDock: View {
    @State private var darkDockStatus: String = ""
    @State private var lightDockStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Hide Dock", systemImage: "dock.rectangle") {
                darkDockStatus = execFile("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockDark.materialrecipe") ? "Success" : "Failed"
                lightDockStatus = execFile("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockLight.materialrecipe") ? "Success" : "Failed"
                Drops.show(Drop(
                    title: "Hide Dock",
                    subtitle: "Light: \(lightDockStatus), Dark: \(darkDockStatus)",
                    icon: UIImage(systemName: "dock.rectangle")
                ))
            }
            Divider()
            statusRow(label: "Dark Dock Status", status: darkDockStatus)
            statusRow(label: "Light Dock Status", status: lightDockStatus)
        }
        .foregroundStyle(.white)
        .listRowBackground(Color.blue)
    }
}

#Preview {
    HideDock()
}
