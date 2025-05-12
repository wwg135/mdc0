//
//  Transparent.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct Transparent: View {
    @State private var transparentStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Transparent Noti & Media Player", systemImage: "square.stack.3d.forward.dottedline") {
                let paths = [
                    "/System/Library/PrivateFrameworks/CoreMaterial.framework/platterStrokeLight.visualstyleset",
                    "/System/Library/PrivateFrameworks/CoreMaterial.framework/platterStrokeDark.visualstyleset",
                    "/System/Library/PrivateFrameworks/CoreMaterial.framework/plattersDark.materialrecipe",
                    "/System/Library/PrivateFrameworks/SpringBoardHome.framework/folderLight.materialrecipe",
                    "/System/Library/PrivateFrameworks/SpringBoardHome.framework/folderDark.materialrecipe",
                    "/System/Library/PrivateFrameworks/CoreMaterial.framework/platters.materialrecipe"
                ]
                let successCount = execFiles(paths)
                transparentStatus = "Success: \(successCount)/\(paths.count) files processed"
                Drops.show(Drop(
                    title: "Transparent Noti & Media Player",
                    subtitle: transparentStatus,
                    icon: UIImage(systemName: "square.stack.3d.forward.dottedline")
                ))
            }
            Divider()
            statusRow(label: "Transparent Status", status: transparentStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.purple)
        
    }
}

#Preview {
    Transparent()
}
