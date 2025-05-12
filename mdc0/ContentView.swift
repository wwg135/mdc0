//
//  ContentView.swift
//  mdc0
//
//  Created by Huy Nguyen❤️ on 9/5/25.
//

import SwiftUI
import Drops
import notify
import CoreLocation

struct ContentView: View {
    @State private var locationManager = CLLocationManager()
    @AppStorage("enableLocationServices") private var enableLocationServices = false
    @StateObject private var githubUpdater = GitHubUpdater()

    var body: some View {
        NavigationView {
            ScrollView {
                ModuleCard(title: "Hide Dock", icon: "dock.rectangle", backgroundColor: .blue) { HideDockView() }
                ModuleCard(title: "Transparent Noti & Media Player", icon: "square.stack.3d.forward.dottedline", backgroundColor: .purple) { TransparentView() }
                ModuleCard(title: "Hide Home Bar", icon: "arrow.down.to.line.compact", backgroundColor: .orange) { HideHomeBarView() }
                ModuleCard(title: "Hide LS Flash & Camera", icon: "lock.display", backgroundColor: .cyan) { LockscreenIconView() }
                ModuleCard(title: "Remove App Switcher Blur", icon: "square.stack.3d.up.fill", backgroundColor: .indigo) { RemoveAppSwitcherBlurView() }
                ModuleCard(title: "Disable Camera Shutter Sound", icon: "camera.badge.ellipsis", backgroundColor: .red) { ShutterSoundView() }
                ModuleCard(title: "Remove Passcode Theme", icon: "number.square", backgroundColor: .pink) { RemovePasscodeThemeView() }
                ModuleCard(title: "Liquid Detection Icon", icon: "drop.degreesign.fill", backgroundColor: .blue) { LiquidDetectionView() }
                ModuleCard(title: "Status Bar Override", icon: "menubar.rectangle", backgroundColor: .green) { StatusBarOverrideView() }
                ModuleCard(title: "Disable Call Record Notice Sound", icon: "phone.connection.fill", backgroundColor: .brown) { DisableCallRecordNoticeView() }
                ModuleCard(title: "Status Legend", icon: "list.star", backgroundColor: .teal) { StatusView() }
                ModuleCard(title: "Credits", icon: "info.bubble", backgroundColor: .gray) { CreditView() }
            }
            .navigationTitle("mdc0")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        enableLocationServices.toggle()
                        if enableLocationServices {
                            locationManager.requestWhenInUseAuthorization()
                            locationManager.requestAlwaysAuthorization()
                        }
                        terminateApp()
                    }) {
                        Image(systemName: enableLocationServices ? "location.fill" : "location")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if let url = URL(string: "respring://") {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                fetchAndOpenRespringAssetFromGitHub()
                            }
                        }
                    }) {
                        Label("Respring", systemImage: "arrow.clockwise.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UIApplication.shared.open(URL(string: "https://github.com/34306/mdc0")!)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    
                }
            }
        }
        .navigationViewStyle(.stack)
        .preferredColorScheme(.dark)
        .onAppear {
            githubUpdater.checkVersion()
        }
        .alert(isPresented: $githubUpdater.showingUpdateAlert) {
            Alert(
                title: Text("New Version Available"),
                message: Text("Version \(githubUpdater.latestVersion ?? "") is available. Do you want to download it?"),
                primaryButton: .default(Text("Download"), action: {
                    if let url = githubUpdater.downloadURL {
                        UIApplication.shared.open(url)
                    }
                }),
                secondaryButton: .cancel(Text("Later"))
            )
        }
    }
}

