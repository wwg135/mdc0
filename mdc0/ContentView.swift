//
//  ContentView.swift
//  mdc0
//
//  Created by Huy Nguyen on 9/5/25.
//

import SwiftUI
import Drops
import notify

func toggleLiquidDetectionIcon(isEnabled: Bool) {
    if isEnabled {
        UIStatusBarServer.addStatusBarItem(40)
    } else {
        UIStatusBarServer.removeStatusBarItem(40)
    }
}
func applyStatusBarStyleOverride(value: Int32) {
    UIStatusBarServer.addStyleOverrides(value)
}
func removeStatusBarStyleOverride(value: Int32) {
    UIStatusBarServer.removeStyleOverrides(value)
}

struct ContentView: View {
    @State private var darkDockStatus: String = ""
    @State private var lightDockStatus: String = ""
    @State private var transparentStatus: String = ""
    @State private var homeBarStatus: String = ""
    @State private var lockscreenIconsStatus: String = ""
    @State private var appSwitcherBlurStatus: String = ""
    @State private var cameraShutterSoundStatus: String = ""
    @State private var passcodeThemeStatus: String = ""
    @State private var selectedTelephonyUIVersion: String = "TelephonyUI-9"
    @State private var liquidDetectionStatus: String = ""
    @State private var statusBarOverrideStatus: String = ""
    @State private var customOverrideValue: String = ""
    @State private var selectedOverrideValue: Int32 = 2147483647
    @State private var showingOverrideOptions: Bool = false
    @State private var respringStatus: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Available Tweaks") {
                    VStack(alignment: .leading) {
                        Button("Hide Dock", systemImage: "dock.rectangle") {
                            let darkPath = strdup("/System/Library/PrivateFrameworks/CoreMaterial.framework/dockDark.materialrecipe")
                            let darkResult = poc(darkPath)
                            darkDockStatus = darkResult == 0 ? "Success" : "Failed"
                            free(darkPath)
                            
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
                    
                    VStack(alignment: .leading) {
                        Button("Remove App Switcher Blur", systemImage: "square.stack.fill") {
                            let paths = [
                                "/System/Library/PrivateFrameworks/SpringBoard.framework/homeScreenBackdrop-application.materialrecipe",
                                "/System/Library/PrivateFrameworks/SpringBoard.framework/homeScreenBackdrop-switcher.materialrecipe"
                            ]
                            
                            var successCount = 0
                            for filePath in paths {
                                let path = strdup(filePath)
                                let result = poc(path)
                                if result == 0 {
                                    successCount += 1
                                }
                                free(path)
                            }
                            
                            appSwitcherBlurStatus = "Success: \(successCount)/\(paths.count) files processed"
                            Drops.show(Drop(title: "Remove App Switcher Blur", subtitle: appSwitcherBlurStatus, icon: UIImage(systemName: "square.stack.fill")))
                        }
                        .symbolRenderingMode(.hierarchical)
                        HStack {
                                Text("App Switcher Blur Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(appSwitcherBlurStatus.isEmpty ? Color(uiColor: .lightGray) : appSwitcherBlurStatus.contains("Success") ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.indigo)
                    
                    VStack(alignment: .leading) {
                        Text("Killing the Camera app may turn back on the sound")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                            
                        Button("Disable Camera Shutter Sound", systemImage: "camera.fill") {
                            let paths = [
                                "/System/Library/Audio/UISounds/photoShutter.caf",
                                "/System/Library/Audio/UISounds/begin_record.caf",
                                "/System/Library/Audio/UISounds/end_record.caf",
                                "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf",
                                "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf",
                                "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf"
                            ]
                            
                            var successCount = 0
                            for filePath in paths {
                                let path = strdup(filePath)
                                let result = poc(path)
                                if result == 0 {
                                    successCount += 1
                                }
                                free(path)
                            }
                            
                            cameraShutterSoundStatus = "Success: \(successCount)/\(paths.count) files processed"
                            Drops.show(Drop(title: "Disable Camera Shutter Sound", subtitle: cameraShutterSoundStatus, icon: UIImage(systemName: "camera.fill")))
                        }
                        .symbolRenderingMode(.hierarchical)
                        HStack {
                                Text("Camera Shutter Sound Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(cameraShutterSoundStatus.isEmpty ? Color(uiColor: .lightGray) : cameraShutterSoundStatus.contains("Success") ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.red)
                    
                    VStack(alignment: .leading) {
                        Picker("Select TelephonyUI", selection: $selectedTelephonyUIVersion) {
                            Text("TelephonyUI-7").tag("TelephonyUI-7")
                            Text("TelephonyUI-8").tag("TelephonyUI-8")
                            Text("TelephonyUI-9").tag("TelephonyUI-9")
                            Text("TelephonyUI-10").tag("TelephonyUI-10")
                            //Text("All Versions").tag("All")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .foregroundColor(.white)
                        .accentColor(.white)
                        
                        Button("Remove Passcode Theme (may not work)", systemImage: "lock.fill") {
                            let buttonSuffixes = [
                                "0---white.png",
                                "1---white.png",
                                "2-A B C--white.png",
                                "3-D E F--white.png",
                                "4-G H I--white.png",
                                "5-J K L--white.png",
                                "6-M N O--white.png",
                                "7-P Q R S--white.png",
                                "8-T U V--white.png",
                                "9-W X Y Z--white.png"
                            ]
                            
                            var allPaths: [String] = []
                            
                            if selectedTelephonyUIVersion == "All" {
                                let versions = ["TelephonyUI-7", "TelephonyUI-8", "TelephonyUI-9", "TelephonyUI-10"]
                                for version in versions {
                                    for suffix in buttonSuffixes {
                                        allPaths.append("/var/mobile/Library/Caches/\(version)/en-\(suffix)")
                                    }
                                }
                            } else {
                                for suffix in buttonSuffixes {
                                    allPaths.append("/var/mobile/Library/Caches/\(selectedTelephonyUIVersion)/en-\(suffix)")
                                }
                            }
                            
                            var successCount = 0
                            for filePath in allPaths {
                                let path = strdup(filePath)
                                let result = poc(path)
                                if result == 0 {
                                    successCount += 1
                                }
                                free(path)
                            }
                            
                            passcodeThemeStatus = "Success: \(successCount)/\(allPaths.count) files processed"
                            Drops.show(Drop(title: "Remove Passcode Theme", subtitle: passcodeThemeStatus, icon: UIImage(systemName: "lock.fill")))
                        }
                        .symbolRenderingMode(.hierarchical)
                        HStack {
                                Text("Passcode Theme Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(passcodeThemeStatus.isEmpty ? Color(uiColor: .lightGray) : passcodeThemeStatus.contains("Success") ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.pink)
                    
                    VStack(alignment: .leading) {
                        Text("Works on iOS 16.0 - 18.2, kill this app make it disappear")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        
                        Button(liquidDetectionStatus == "Enabled" ? "Disable Liquid Detection Icon" : "Enable Liquid Detection Icon", systemImage: liquidDetectionStatus == "Enabled" ? "drop" : "drop.fill") {
                            let newStatus = liquidDetectionStatus != "Enabled" ? "Enabled" : "Disabled"
                            liquidDetectionStatus = newStatus
                            
                            toggleLiquidDetectionIcon(isEnabled: newStatus == "Enabled")
                            
                            Drops.show(Drop(
                                title: "Liquid Detection", 
                                subtitle: newStatus == "Enabled" ? "Icon enabled" : "Icon disabled", 
                                icon: UIImage(systemName: newStatus == "Enabled" ? "drop.fill" : "drop")
                            ))
                        }
                        .symbolRenderingMode(.hierarchical)
                        
                        HStack {
                                Text("Liquid Detection Status")
                                .foregroundStyle(.white)
                                Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(liquidDetectionStatus.isEmpty ? Color(uiColor: .lightGray) : liquidDetectionStatus == "Enabled" ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.blue)
                    
                    VStack(alignment: .leading) {
                        Text("Works on iOS 16.0 - 18.2, kill this app to remove")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        
                        HStack {
                            Picker("Status Bar Override", selection: $selectedOverrideValue) {
                                Text("UNKNOWN GOD").tag(Int32(2147483647)) // INT_MAX
                                Text("Calling").tag(Int32(1))
                                Text("Microphone").tag(Int32(4))
                                Text("FaceTime").tag(Int32(16))
                                Text("Hotspot").tag(Int32(8))
                                Text("AirPlay").tag(Int32(32))
                                Text("Location").tag(Int32(64))
                                Text("Connect Cable").tag(Int32(512))
                                Text("Custom").tag(Int32(-1))
                            }
                            .pickerStyle(MenuPickerStyle())
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .frame(maxWidth: .infinity)
                            
                            if selectedOverrideValue == -1 {
                                TextField("Value", text: $customOverrideValue)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 80)
                            }
                        }
                        
                        HStack {
                            Button(statusBarOverrideStatus == "Enabled" ? "Disable Status Bar Override" : "Enable Status Bar Override", systemImage: statusBarOverrideStatus == "Enabled" ? "xmark.circle" : "checkmark.circle") {
                                let newStatus = statusBarOverrideStatus != "Enabled" ? "Enabled" : "Disabled"
                                statusBarOverrideStatus = newStatus
                                
                                let valueToUse = selectedOverrideValue == -1 ? (Int32(customOverrideValue) ?? 0) : selectedOverrideValue
                                
                                if newStatus == "Enabled" {
                                    applyStatusBarStyleOverride(value: valueToUse)
                                } else {
                                    removeStatusBarStyleOverride(value: valueToUse)
                                }
                                
                                Drops.show(Drop(
                                    title: "Status Bar Override", 
                                    subtitle: "\(newStatus) with value: \(valueToUse)", 
                                    icon: UIImage(systemName: newStatus == "Enabled" ? "checkmark.circle" : "xmark.circle")
                                ))
                            }
                            .symbolRenderingMode(.hierarchical)
                            .frame(maxWidth: .infinity)
                        }
                        
                        HStack {
                            Text("Status Bar Override Status")
                                .foregroundStyle(.white)
                            Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(statusBarOverrideStatus.isEmpty ? Color(uiColor: .lightGray) : statusBarOverrideStatus == "Enabled" ? Color.green : Color.red)
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 3)
                                }
                        }
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.green)
                }
                Section("Status") {
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
                    Text("Made by [34306](https://github.com/34306), UI by [timi2506](https://github.com/timi2506), using CVE-2025-24203 by Ian Beer and my old mdc/kfd stuff\nSupport iOS 15.0 - 18.3.2, you need to respring to take effect using [this app](https://github.com/34306/mdc0/releases/download/1.0/respringapp.ipa) thanks to Thea\nThanks to [DuyTran](https://x.com/TranKha50277352) for the Liquid status bar and fake status")
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
