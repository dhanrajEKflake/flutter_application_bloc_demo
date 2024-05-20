import UIKit
import Flutter
import flutter_local_notifications
import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

  if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
  }
  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
      
  FirebaseApp.configure()
  requestPermission()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
  }
  func requestPermission() -> Void {
let notificationsCenter = UNUserNotificationCenter.current()
notificationsCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
if let error = error {
print("error while requesting permission: \(error.localizedDescription)")
}
if granted {
print("permission granted")
} else {
print("permission denied")
}
}
}
}
