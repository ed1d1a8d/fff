//
//  AppDelegate.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FacebookCore
import FBSDKCoreKit

// TODO
// global variable optional storing key to FFF backend
var fffKey:String?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		fffKey = nil
		
        GMSServices.provideAPIKey(APIKeys.GoogleMaps)
        GMSPlacesClient.provideAPIKey(APIKeys.GoogleMaps)
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)

		// self.window?.rootViewController = FBLoginViewController()
        if let currentToken = AccessToken.current {
			// login to the backend using the current access token
			// TODO unify this with the helper in FBLoginViewController
			var params = Dictionary<String, Any>()
			params["access_token"] = currentToken.tokenString
			
			// DEBUG
			print(params["access_token"])
			
            self.window?.rootViewController = SuccessfulAcceptViewController(eatRequestInfo: Fake.EatRequests.one[0])
            
			HTTPAPI.instance().call(url: endpoints.musicu.facebookAuth, params: params, method: .POST, success: { (data, response, error) in
				// DEBUG
				print("Facebook login into FFF backend success!")
				guard let unwrappedData = data else {
					return
				}
				do {
					let data = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! [String: Any]
					
					// DEBUG
					print(data)
					
					// we want to take the key from here
					fffKey = data["key"] as! String
				} catch {}
			}) { (data, response, error) in
				
				// DEBUG
				print("Facebook login into FFF backend failure :(")
				
				// TODO URGENT handle
			}
            UserData.shared.fbAuth = true
//            self.window?.rootViewController = SelectionViewController()
            self.window?.rootViewController = SuccessfulAcceptViewController(eatRequestInfo: Fake.EatRequests.one[0])

        } else {
            self.window?.rootViewController = FBLoginViewController()
        }
        self.window?.makeKeyAndVisible()
        
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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      return ApplicationDelegate.shared.application(app, open: url, options: options)
    }

}

