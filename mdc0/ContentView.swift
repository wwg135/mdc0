//
//  ContentView.swift
//  mdc0
//
//  Created by Huy Nguyen on 9/5/25.
//

import SwiftUI
import Drops
import notify

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section("Available Tweaks") {
                    HideDock()
                    Transparent()
                    HideHomeBar()
                    LockscreenIcon()
                    AppSwitcherBlur()
                    ShutterSound()
                    PasscodeTheme()
                    LiquidDetection()
                    StatusBar()
                }
                
                Status()
                Credit()
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
