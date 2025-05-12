//
//  GitHubUpdater.swift
//  mdc0
//
//  Created by straight-tamago⭐️ on 2025/05/12.
//

import SwiftUI
import Combine

struct GitHubRelease: Codable {
    let tagName: String
    let htmlURL: String
    let assets: [GitHubAsset]

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
        case htmlURL = "html_url"
        case assets
    }
}

struct GitHubAsset: Codable {
    let browserDownloadURL: URL?

    enum CodingKeys: String, CodingKey {
        case browserDownloadURL = "browser_download_url"
    }
}

class GitHubUpdater: ObservableObject {
    @Published var showingUpdateAlert = false
    @Published var latestVersion: String?
    @Published var downloadURL: URL?

    func getCurrentAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }

    func checkVersion() {
        guard let url = URL(string: "https://api.github.com/repos/34306/mdc0/releases/latest") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching release info: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let releaseInfo = try? JSONDecoder().decode(GitHubRelease.self, from: data) {
                let latestVersionString = releaseInfo.tagName.replacingOccurrences(of: "v", with: "")
                let currentVersionString = self.getCurrentAppVersion()
                if latestVersionString.compare(currentVersionString, options: .numeric) == .orderedDescending {
                    DispatchQueue.main.async {
                        self.latestVersion = latestVersionString
                        self.downloadURL = URL(string: "https://github.com/34306/mdc0/releases")
                        self.showingUpdateAlert = true
                    }
                } else {
                    print("Current version is up to date.")
                }
            } else {
                print("Error decoding release info.")
            }
        }.resume()
    }
}
