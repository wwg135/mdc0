//
//  DisableCallRecordNoticeView.swift
//  mdc0
//
//  Created by Cascade on 2025/05/12.
//

import SwiftUI
import Drops

// Check if the device is running iOS 18 or later
func isIOS18OrLater() -> Bool {
    if #available(iOS 18.0, *) {
        return true
    }
    return false
}

struct DisableCallRecordNoticeView: View {
    @State private var callRecordNoticeSoundStatus: String = ""
    @State private var timer: Timer?
    @AppStorage("LocCallRecordSound") private var LocCallRecordSound = false
    
    private func applyChanges() {
        // Check if feature is supported on this iOS version
        if !isIOS18OrLater() {
            Drops.show(Drop(
                title: "Disable Call Record Notice Sound", 
                subtitle: "This feature is only available on iOS 18+", 
                icon: UIImage(systemName: "exclamationmark.triangle")
            ))
            return
        }
        
        let paths = [
            "/var/mobile/Library/CallServices/Greetings/default/StartDisclosure.caf",
            "/var/mobile/Library/CallServices/Greetings/default/StartDisclosureWithTone.m4a",
            "/var/mobile/Library/CallServices/Greetings/default/StopDisclosure.caf",
            "/System/Library/PrivateFrameworks/ConversationKit.framework/call_recording_countdown.caf"
        ]
        
        let successCount = execFiles(paths)
        
        Drops.show(Drop(
            title: "Disable Call Record Notice Sound", 
            subtitle: "Success: \(successCount)/\(paths.count) files processed", 
            icon: UIImage(systemName: "phone.connection.fill")
        ))
        
        callRecordNoticeSoundStatus = successCount == paths.count ? "Success" : "Failed"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(isIOS18OrLater() ? 
                "Disables the notification sounds played when enabled call recording" : 
                "This feature is only available on iOS 18+")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)
            
            HStack {
                Button("Apply") {
                    applyChanges()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isIOS18OrLater())
                Spacer()
                ActionStatusCircle(status: callRecordNoticeSoundStatus)
            }
            
            Toggle("Background Keep (Interval 60s)", isOn: $LocCallRecordSound)
                .disabled(!UserDefaults.standard.bool(forKey: "enableLocationServices") || !isIOS18OrLater())
        }
        .foregroundColor(.primary)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                if LocCallRecordSound && UserDefaults.standard.bool(forKey: "enableLocationServices") && isIOS18OrLater() {
                    applyChanges()
                }
            }
            if !UserDefaults.standard.bool(forKey: "enableLocationServices") || !isIOS18OrLater() {
                LocCallRecordSound = false
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
}
