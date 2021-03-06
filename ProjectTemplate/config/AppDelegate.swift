//
//  AppDelegate.swift
//  TestProject1
//
//  Created by Daniel Illescas Romero on 11/02/2019.
//  Copyright © 2019 Daniel Illescas Romero. All rights reserved.
//

import UIKit

//import Peek
@_exported import Async
@_exported import SwiftyUtils
@_exported import AppFolder
@_exported import FontAwesome
@_exported import Alamofire
@_exported import Haptica
@_exported import Promises

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		//self.setupPeek()
		Logger.saveToFile = true
		SideVolumeHUD.shared.setup(withOptions: [.animationStyle(.slideLeftRight)])
		//SideVolumeHUD.shared.setup(withOptions: [.animationStyle(.slideLeftRight), .theme(.light)])
		//SideVolumeHUD.shared.setup(withOptions: [.animationStyle(.enlarge), .theme(.light), .orientation(.horizontal)])
		/*NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeOrientation), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
		*/
		return true
	}

	/*@objc func didChangeOrientation() {
		let statusBarOrientation = UIApplication.shared.statusBarOrientation
		if statusBarOrientation.isPortrait {
			SideVolumeHUD.shared.setup(withStyle: .slideLeftRight, portraitStyle: true)
		} else if statusBarOrientation.isLandscape {
			SideVolumeHUD.shared.setup(withStyle: .slideLeftRight, portraitStyle: false)
		}
	}*/
	
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
	
	// MARK: - Convenience
	
	private func setupPeek() {
		//self.window?.peek.enabled = true
	}
}

