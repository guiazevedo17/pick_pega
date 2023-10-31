import UIKit
import Flutter
import GoogleMaps
import Firebase
// import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // let key: String = FlutterConfigPlugin.env(for: "MAPS_APIKEY")
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDTN9yBqoVdrDor1gaBWxQkywlpCS9Wi_o")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
