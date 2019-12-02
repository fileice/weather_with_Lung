//
//  AppDelegate.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/9/27.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions第一次進入app時出現")
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

//    func applicationWillResignActive(_ application: UIApplication) {
//        print("applicationWillResignActive當app浮起來準備進入背景時出現")
//    }
//    
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        print("applicationWillEnterForeground當程式由背景狀態重新回到app前景時出現")
//    }
//    
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        print("applicationDidEnterBackground程式已經完全進入背景時出現")
//    }
//    
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        print("applicationDidBecomeActive剛開啟app時出現")
//    }
//    
//    func applicationWillTerminate(_ application: UIApplication) {
//        print("applicationWillTerminate將程式完全關閉結束時出現")
//    }
}
