//
//  PasscodeTheme.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct PasscodeTheme: View {
    @State private var passcodeThemeStatus: String = ""
    @State private var selectedTelephonyUIVersion: String = "TelephonyUI-9"
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Select TelephonyUI", selection: $selectedTelephonyUIVersion) {
                ForEach(["TelephonyUI-7", "TelephonyUI-8", "TelephonyUI-9", "TelephonyUI-10"], id: \.self) {
                    Text($0).tag($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .foregroundColor(.white)
            .accentColor(.white)

            Button("Remove Passcode Theme (may not work)", systemImage: "lock.fill") {
                let buttonSuffixes = [
                    "0---white.png", "1---white.png", "2-A B C--white.png", "3-D E F--white.png",
                    "4-G H I--white.png", "5-J K L--white.png", "6-M N O--white.png",
                    "7-P Q R S--white.png", "8-T U V--white.png", "9-W X Y Z--white.png"
                ]
                
                let versions = selectedTelephonyUIVersion == "All"
                    ? ["TelephonyUI-7", "TelephonyUI-8", "TelephonyUI-9", "TelephonyUI-10"]
                    : [selectedTelephonyUIVersion]
                
                let allPaths = versions.flatMap { version in
                    buttonSuffixes.map { "/var/mobile/Library/Caches/\(version)/en-\($0)" }
                }

                let successCount = execFiles(allPaths)
                passcodeThemeStatus = "Success: \(successCount)/\(allPaths.count) files processed"
                Drops.show(Drop(title: "Remove Passcode Theme", subtitle: passcodeThemeStatus, icon: UIImage(systemName: "lock.fill")))
            }
            .symbolRenderingMode(.hierarchical)

            statusRow(label: "Passcode Theme Status", status: passcodeThemeStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.pink)
    }
}

#Preview {
    PasscodeTheme()
}
