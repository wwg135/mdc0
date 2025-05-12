//
//  Utils.swift
//  mdc0
//
//  Created by straight-tamago⭐️ on 2025/05/12.
//

import Foundation
import SwiftUI
import Drops

// Check if the device is running iOS 17 or later
func isIOS17OrLater() -> Bool {
    if #available(iOS 17.0, *) {
        return true
    }
    return false
}

// Function to toggle liquid detection icon (iOS 16 only)
func toggleLiquidDetectionIcon(isEnabled: Bool) -> Bool {
    // Liquid detection status bar item number
    let liquidDetectionItemNumber: Int32 = 40
    
    if isIOS17OrLater() {
        // Not supported on iOS 17+
        return false
    } else {
        // iOS 16 implementation using UIStatusBarServer
        if isEnabled {
            UIStatusBarServer.addStatusBarItem(liquidDetectionItemNumber)
        } else {
            UIStatusBarServer.removeStatusBarItem(liquidDetectionItemNumber)
        }
        return true // Feature supported on iOS 16
    }
}

// Function to apply style overrides (iOS 16 only)
func applyStatusBarStyleOverride(value: Int32) -> Bool {
    if isIOS17OrLater() {
        // Not supported on iOS 17+
        return false
    } else {
        // iOS 16 implementation using UIStatusBarServer
        UIStatusBarServer.addStyleOverrides(value)
        return true // Feature supported on iOS 16
    }
}

// Function to remove style overrides (iOS 16 only)
func removeStatusBarStyleOverride(value: Int32) -> Bool {
    if isIOS17OrLater() {
        // Not supported on iOS 17+
        return false
    } else {
        // iOS 16 implementation using UIStatusBarServer
        UIStatusBarServer.removeStyleOverrides(value)
        return true // Feature supported on iOS 16
    }
}

func execFiles(_ paths: [String]) -> Int {
    var successCount = 0
    for path in paths {
        if execFile(path) {
            successCount += 1
        }
    }
    return successCount
}

func execFile(_ path: String) -> Bool {
    let path = strdup(path)
    let result = poc(path)
    free(path)
    return result == 0
}

func isAllZero(path: String) -> Bool {
    guard let fh = FileHandle(forReadingAtPath: path) else { return false }
    defer { fh.closeFile() }

    while true {
        let chunk = fh.readData(ofLength: 4096)
        if chunk.isEmpty { break }
        if chunk.contains(where: { $0 != 0 }) { return false }
    }

    return true
}

func terminateApp() {
    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
        exit(0)
    }
}

func fetchAndOpenRespringAssetFromGitHub() {
    print("Fetching GitHub releases...")
    guard let url = URL(string: "https://api.github.com/repos/34306/mdc0/releases") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            DispatchQueue.main.async {
                Drops.show(Drop(title: "Error", subtitle: "Network error"))
            }
            return
        }

        do {
            if let releases = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                for release in releases {
                    if let assets = release["assets"] as? [[String: Any]] {
                        if let respringAsset = assets.first(where: {
                            ($0["name"] as? String)?.lowercased().contains("respring") == true
                        }) {
                            if let downloadUrlString = respringAsset["browser_download_url"] as? String,
                               let downloadUrl = URL(string: downloadUrlString) {
                                DispatchQueue.main.async {
                                    UIApplication.shared.open(downloadUrl)
                                }
                                return
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    Drops.show(Drop(title: "Error", subtitle: "Respring asset not found in any release."))
                }
            }
        } catch {
            DispatchQueue.main.async {
                Drops.show(Drop(title: "Error", subtitle: "Json parse error"))
            }
        }
    }

    task.resume()
}
