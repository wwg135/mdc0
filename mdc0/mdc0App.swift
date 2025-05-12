//
//  mdc0App.swift
//  mdc0
//
//  Created by Huy Nguyen on 9/5/25.
//

import SwiftUI
import CoreLocation

@main
struct mdc0App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


extension UNNotificationCategory
{
    static let clipboardReaderIdentifier = "mdc0"
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UserDefaults.standard.bool(forKey: "enableLocationServices") {
            ApplicationMonitor.shared.start()
            self.registerForNotifications()
        }
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    private func registerForNotifications() {
        let category = UNNotificationCategory(identifier: UNNotificationCategory.clipboardReaderIdentifier, actions: [], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        guard response.notification.request.content.categoryIdentifier == UNNotificationCategory.clipboardReaderIdentifier else { return }
        guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else { return }
    }
}
