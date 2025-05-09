//
//  ContentView.swift
//  mdc0
//
//  Created by Huy Nguyen on 9/5/25.
//

import SwiftUI
import Drops

struct ContentView: View {
    @State private var darkDockStatus: String = ""
    @State private var lightDockStatus: String = ""
    @State private var transparentStatus: String = ""
    @State private var homeBarStatus: String = ""
    @State private var lockscreenIconsStatus: String = ""
    @State private var respringStatus: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Available Tweaks") {
                    VStack(alignment: .leading) {
                        Button("Hide Dock", systemImage: "dock.rectangle") {
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
                            Drops.show(Drop(title: "Hide Dock", subtitle: "Light: \(lightDockStatus), Dark: \(darkDockStatus)", icon: UIImage(systemName: "dock.rectangle")))

                        }
                        Divider()
                        HStack {
                                Text("Dark Dock Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(darkDockStatus.isEmpty ? Color(uiColor: .lightGray) : darkDockStatus == "Success" ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                        HStack {
                                Text("Light Dock Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(lightDockStatus.isEmpty ? Color(uiColor: .lightGray) : lightDockStatus == "Success" ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(Color.blue)
                    
                    
                    VStack(alignment: .leading) {
                        Button("Transparent Noti & Media Player", systemImage: "square.stack.3d.forward.dottedline") {
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
                            Drops.show(Drop(title: "Transparent Noti & Media Player", subtitle: transparentStatus, icon: UIImage(systemName: "square.stack.3d.forward.dottedline")))

                        }
                        Divider()
                        HStack {
                                Text("Transparent Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(transparentStatus.isEmpty ? Color(uiColor: .lightGray) : transparentStatus.contains("Success") ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.purple)
                    
                    VStack(alignment: .leading) {
                        Button("Hide Home Bar", systemImage: "arrow.down.to.line.compact") {
                            let path = strdup("/System/Library/PrivateFrameworks/MaterialKit.framework/Assets.car")
                            let result = poc(path)
                            homeBarStatus = result == 0 ? "Success" : "Failed"
                            free(path)
                            Drops.show(Drop(title: "Hide Home Bar", subtitle: homeBarStatus, icon: UIImage(systemName: "arrow.down.to.line.compact")))

                        }
                        Divider()
                        HStack {
                                Text("Home Bar Hiding Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(homeBarStatus.isEmpty ? Color(uiColor: .lightGray) : homeBarStatus.contains("Success") ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.orange)
                    
                    VStack(alignment: .leading) {
                        Button("Hide LS Flash & Camera", systemImage: "bolt.slash.fill") {
                            let path = strdup("/System/Library/PrivateFrameworks/CoverSheet.framework/Assets.car")
                            let result = poc(path)
                            lockscreenIconsStatus = result == 0 ? "Success" : "Failed"
                            free(path)
                            Drops.show(Drop(title: "Hide LS Flash & Camera", subtitle: lockscreenIconsStatus, icon: UIImage(systemName: "bolt.slash.fill")))

                        }
                        .symbolRenderingMode(.hierarchical)
                        HStack {
                                Text("Lockscreen Icon Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(lockscreenIconsStatus.isEmpty ? Color(uiColor: .lightGray) : lockscreenIconsStatus.contains("Success") ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.cyan)
                }
                Section("Colors") {
                    HStack {
                        Text("None")
                            .foregroundStyle(.white)
                        Spacer()
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color(uiColor: .lightGray))
                            .background {
                                Circle()
                                    .stroke(.white, lineWidth: 3)
                            }
                    }
                    HStack {
                        Text("Success")
                            .foregroundStyle(.white)
                        Spacer()
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.green)
                            .background {
                                Circle()
                                    .stroke(.white, lineWidth: 3)
                            }
                    }
                    HStack {
                        Text("Failed")
                            .foregroundStyle(.white)
                        Spacer()
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.red)
                            .background {
                                Circle()
                                    .stroke(.white, lineWidth: 3)
                            }
                    }
                }
                .listRowBackground(Color.teal)

                Section {
                    // Credit
                    Text("Using CVE-2025-24203 and my old mdc/kfd stuff\nSupport iOS 15.0 - 18.3.2, you need to respring by hand to take effect using Library trick")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("mdc0")
            .toolbar {
                Button("Info", systemImage: "info.circle") {
                    UIApplication.shared.open(URL(string: "https://github.com/34306/mdc0")!)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}


#Preview {
    ContentView()
}
