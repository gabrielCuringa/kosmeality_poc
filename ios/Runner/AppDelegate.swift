import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var controller : FlutterViewController?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    guard let flutterViewController  = window?.rootViewController as? FlutterViewController else {
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    let flutterChannel = FlutterMethodChannel.init(name: "viewcontroller", binaryMessenger: flutterViewController as! FlutterBinaryMessenger);
    flutterChannel.setMethodCallHandler { (flutterMethodCall, flutterResult) in
        if flutterMethodCall.method == "testLipstick" {
            UIView.animate(withDuration: 0.5, animations: {
                guard let args = flutterMethodCall.arguments as? [String:String] else{return}
                
                let lipstickObj = Lipstick(id: args["id"]!, color: args["color"]!, serie: args["serie"]!, name: args["name"]!)
                
                self.window?.rootViewController = nil
                
                let viewToPush = ViewController()
                viewToPush.lipstick = lipstickObj                
                
                let navigationController = UINavigationController(rootViewController: flutterViewController)
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.makeKeyAndVisible()
                self.window.rootViewController = navigationController
                navigationController.isNavigationBarHidden = true
                navigationController.present(viewToPush, animated: false, completion: nil)
//                navigationController.pushViewController(viewToPush, animated: false)
                
            })
        }
    }
        
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
