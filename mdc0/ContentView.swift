//
//  ContentView.swift
//  mdc0
//
//  Created by Huy Nguyen on 9/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var darkDockStatus: String = ""
    @State private var lightDockStatus: String = ""
    @State private var transparentStatus: String = ""
    @State private var homeBarStatus: String = ""
    @State private var lockscreenIconsStatus: String = ""
    @State private var respringStatus: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            VStack {
                Button("Hide Dock") {
                    // Process dark dock material
                    let darkPath = strdup("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockDark.materialrecipe")
                    let darkResult = poc(darkPath)
                    darkDockStatus = darkResult == 0 ? "Success" : "Failed"
                    free(darkPath)
                    
                    // Process light dock material
                    let lightPath = strdup("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockLight.materialrecipe")
                    let lightResult = poc(lightPath)
                    lightDockStatus = lightResult == 0 ? "Success" : "Failed"
                    free(lightPath)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if !darkDockStatus.isEmpty {
                    Text("Dark Dock: \(darkDockStatus)")
                        .foregroundColor(darkDockStatus == "Success" ? .green : .red)
                }
                
                if !lightDockStatus.isEmpty {
                    Text("Light Dock: \(lightDockStatus)")
                        .foregroundColor(lightDockStatus == "Success" ? .green : .red)
                }
            }
            
            VStack {
                Button("Transparent Noti & Media Player") {
                    // Process all files for transparent notifications and media player
                    let paths = [
                        "/System/Library/PrivateFrameworks/CoreMaterial.framework/platterStrokeLight.visualstyleset",
                        "/System/Library/PrivateFrameworks/CoreMaterial.framework/platterStrokeDark.visualstyleset",
                        "/System/Library/PrivateFrameworks/CoreMaterial.framework/plattersDark.materialrecipe",
                        "/System/Library/PrivateFrameworks/SpringBoardHome.framework/folderLight.materialrecipe",
                        "/System/Library/PrivateFrameworks/SpringBoardHome.framework/folderDark.materialrecipe",
                        "/System/Library/PrivateFrameworks/CoreMaterial.framework/platters.materialrecipe"
                    ]
                    
                    var successCount = 0
                    for pathString in paths {
                        let path = strdup(pathString)
                        let result = poc(path)
                        if result == 0 {
                            successCount += 1
                        }
                        free(path)
                    }
                    
                    transparentStatus = "Success: \(successCount)/\(paths.count) files processed"
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if !transparentStatus.isEmpty {
                    Text(transparentStatus)
                        .foregroundColor(.green)
                }
            }
            
            VStack {
                Button("Hide Home Bar") {
                    let path = strdup("/System/Library/PrivateFrameworks/MaterialKit.framework/Assets.car")
                    let result = poc(path)
                    homeBarStatus = result == 0 ? "Success" : "Failed"
                    free(path)
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if !homeBarStatus.isEmpty {
                    Text("Home Bar: \(homeBarStatus)")
                        .foregroundColor(homeBarStatus == "Success" ? .green : .red)
                }
            }
            
            VStack {
                Button("Hide LS Flash & Camera") {
                    let path = strdup("/System/Library/PrivateFrameworks/CoverSheet.framework/Assets.car")
                    let result = poc(path)
                    lockscreenIconsStatus = result == 0 ? "Success" : "Failed"
                    free(path)
                }
                .padding()
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if !lockscreenIconsStatus.isEmpty {
                    Text("Lockscreen Icons: \(lockscreenIconsStatus)")
                        .foregroundColor(lockscreenIconsStatus == "Success" ? .green : .red)
                }
            }
            
            // Credit
            Text("Using CVE-2025-24203 and my old mdc/kfd stuff\nSupport iOS 15.0 - 18.3.2, you need to respring by hand to take effect using Library trick")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
