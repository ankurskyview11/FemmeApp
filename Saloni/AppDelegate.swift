//
//  AppDelegate.swift
//  Saloni
//
//  Created by Ankur Verma on 26/03/21.
//

import UIKit
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    var style = ToastStyle()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       print("AAPDEL")
        style.messageColor = .black
        style.backgroundColor = UIColor(named: ACCENT_COLOR) ?? UIColor.lightGray
        ToastManager.shared.style = style
        ToastManager.shared.position = .center
        GMSServices.provideAPIKey("AIzaSyCEkL2h56VGJ7FzBFTX09x2z0pC98eA0aI")
        
      //  let defs = UserDefaults.standard
      /*  if defs.string(forKey: "isFirstTime") == "YES" {
            defs.set("NO", forKey: "NotFirstTime")
            defs.synchronize()
            print("NO FIRST TIME")
            let testController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as! RootViewController

          
            let navigationController = UINavigationController.init(rootViewController: testController)
                   
            navigationController.setViewControllers([testController], animated: true)
          

        }
        else{
            print("FIRST TIME")
            defs.set("YES", forKey: "isFirstTime")
            defs.synchronize()
        }*/

      
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func clearAllData(){
        UserDefaults.standard.setValue("NO", forKey: IS_LOGGED_IN)
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "name")
        UserDefaults.standard.setValue("", forKey: "phone_no")
        UserDefaults.standard.setValue("", forKey: "token")
        UserDefaults.standard.setValue("", forKey: "verified")
        UserDefaults.standard.setValue("", forKey: "country_name")
    }
    func getHeaderRequest() -> String {
       
        let accessToken = UserDefaults.standard.object(forKey: "token")
        let headerReq = "Bearer \(accessToken ?? "")"
        print("From App Delegate = \(headerReq)")
        return headerReq
    }

}

