//
//  AppDelegate.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/08.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()  //Firebaseを利用するコマンド
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in   //Userのログイン状況を取得する
            if user == nil {
                self.window = UIWindow(frame: UIScreen.main.bounds) //windowを生成
                let storyboard = UIStoryboard(name: "Login", bundle: nil)   //Storyboardを指定
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") //Viewcontrollerを指定
                self.window?.rootViewController = initialViewController //rootViewControllerに入れる
                self.window?.makeKeyAndVisible()    //表示
            }else{
                //ユーザーがいる場合Storyboardでチェックの入っているIs Initial View Controllerに遷移する
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

