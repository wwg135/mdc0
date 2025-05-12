//
//  ShutterSound.swift
//  mdc0
//
//  Created by straight-tamago☆ on 2025/05/12.
//

import SwiftUI
import Drops

struct ShutterSound: View {
    @State private var cameraShutterSoundStatus: String = ""
    
    var body: some View {
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
                let successCount = execFiles(paths)
                cameraShutterSoundStatus = "Success: \(successCount)/\(paths.count) files processed"
                Drops.show(Drop(
                    title: "Disable Camera Shutter Sound",
                    subtitle: cameraShutterSoundStatus,
                    icon: UIImage(systemName: "camera.fill")
                ))
            }
            .symbolRenderingMode(.hierarchical)

            statusRow(label: "Camera Shutter Sound Status", status: cameraShutterSoundStatus)
        }
        .foregroundColor(.white)
        .listRowBackground(Color.red)
    }
}

#Preview {
    ShutterSound()
}
