//
//  AppDelegate.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 03.02.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = createRootNavigationController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func createRootNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "FeedNavigationController") as! UINavigationController
        setupServices(for: navigationController.viewControllers.first as! FeedListViewController)
        return navigationController
    }
    
    func setupServices(for fltvc: FeedListViewController) {
        fltvc.feedSourceStorage = FeedSourceStorageImpl(with: UserDefaults.standard)
        fltvc.feedService = FeedServiceImpl(with: fltvc.feedSourceStorage, feedParser: URLFeedParserImpl())
    }

}

