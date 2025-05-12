//
//  Utils.swift
//  mdc0
//
//  Created by straight-tamago⭐️ on 2025/05/12.
//

import Foundation

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
