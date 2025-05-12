//
//  ShutterSound.swift
//  mdc0
//
//  Created by straight-tamago⭐️ on 2025/05/12.
//

import SwiftUI
import Drops

struct ShutterSoundView: View {
    @State private var cameraShutterSoundStatus: String = ""
    @State private var timer: Timer?
    @AppStorage("LocShutterSound") private var LocShutterSound = false

    private func applyChanges() {
        let paths = [
            "/System/Library/Audio/UISounds/photoShutter.caf",
            "/System/Library/Audio/UISounds/begin_record.caf",
            "/System/Library/Audio/UISounds/end_record.caf",
            "/System/Library/Audio/UISounds/Modern/camera_shutter_burst.caf",
            "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_begin.caf",
            "/System/Library/Audio/UISounds/Modern/camera_shutter_burst_end.caf"
        ]
        let successCount = execFiles(paths)
        cameraShutterSoundStatus = "Success: \(successCount)/\(paths.count) files processed"
        Drops.show(Drop(
            title: "Disable Camera Shutter Sound",
            subtitle: cameraShutterSoundStatus,
            icon: UIImage(systemName: "camera.fill")
        ))
        cameraShutterSoundStatus = successCount == paths.count ? "Success" : "Failed"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Killing the Camera app may turn back on the sound")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)

            HStack {
                Button("Apply") {
                    applyChanges()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
                ActionStatusCircle(status: cameraShutterSoundStatus)
            }

            Toggle("Background Keep (Interval 60s)", isOn: $LocShutterSound)
            .disabled(!UserDefaults.standard.bool(forKey: "enableLocationServices"))
        }
        .foregroundColor(.primary)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                if LocShutterSound && UserDefaults.standard.bool(forKey: "enableLocationServices") {
                    applyChanges()
                }
            }
            if !UserDefaults.standard.bool(forKey: "enableLocationServices") {
                LocShutterSound = false
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
}
