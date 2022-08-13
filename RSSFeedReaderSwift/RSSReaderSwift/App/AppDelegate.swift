//
//  AppDelegate.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 03.02.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        let feedSourceStorage = FeedSourceStorageImpl(with: UserDefaults.standard)
        let feedService = FeedServiceImpl(with: feedSourceStorage, feedParser: URLFeedParser())
        fltvc.setupServices(dependencies: (feedService: feedService,
                                           feedSourceStorage: feedSourceStorage))
    }

}

