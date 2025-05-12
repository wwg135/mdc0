//
//  StatusBar.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct StatusBarOverrideView: View {
    @State private var statusBarOverrideStatus: String = ""
    @State private var customOverrideValue: String = ""
    @State private var selectedOverrideValue: Int32 = 2147483647
    @State private var showingOverrideOptions: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(isIOS17OrLater() ? "Not supported on iOS 17+" : "Works on iOS 16.0 - 16.7.10, kill this app to remove")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)
            
            HStack {
                Picker("Status Bar Override", selection: $selectedOverrideValue) {
                    Text("UNKNOWN GOD").tag(Int32(2147483647))
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
                .foregroundColor(.primary)
                .accentColor(.primary)
                .frame(maxWidth: .infinity)
                
                if selectedOverrideValue == -1 {
                    TextField("Value", text: $customOverrideValue)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                }
            }
            
            HStack {
                Button(statusBarOverrideStatus == "Enabled" ? "Disable" : "Enable", systemImage: statusBarOverrideStatus == "Enabled" ? "xmark.circle" : "checkmark.circle") {
                    let newStatus = statusBarOverrideStatus != "Enabled" ? "Enabled" : "Disabled"
                    let valueToUse = selectedOverrideValue == -1 ? (Int32(customOverrideValue) ?? 0) : selectedOverrideValue
                    
                    let isSupported: Bool
                    if newStatus == "Enabled" {
                        isSupported = applyStatusBarStyleOverride(value: valueToUse)
                    } else {
                        isSupported = removeStatusBarStyleOverride(value: valueToUse)
                    }
                    
                    if isSupported {
                        statusBarOverrideStatus = newStatus
                        Drops.show(Drop(
                            title: "Status Bar Override",
                            subtitle: "\(newStatus) with value: \(valueToUse)",
                            icon: UIImage(systemName: newStatus == "Enabled" ? "checkmark.circle" : "xmark.circle")
                        ))
                    } else {
                        Drops.show(Drop(
                            title: "Status Bar Override",
                            subtitle: "Not supported on iOS 17+",
                            icon: UIImage(systemName: "exclamationmark.triangle")
                        ))
                    }
                }
                .buttonStyle(.borderedProminent)
                .symbolRenderingMode(.hierarchical)

                Spacer()

                ActionStatusCircle(status: statusBarOverrideStatus)
            }
        }
        .foregroundColor(.primary)
    }
}
