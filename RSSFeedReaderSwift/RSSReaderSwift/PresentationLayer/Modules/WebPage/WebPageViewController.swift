//
//  WebPageViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 16.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import WebKit

final class WebPageViewController: UIViewController {
    
    // MARK: - Properties
    
    var pageUrl: URL!
    
     // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupWebView()
    }
    
    // MARK: - Setup

    private func setupWebView() {
        let webView = WKWebView(frame: view.frame)
        webView.load(URLRequest(url: pageUrl))
        view.addSubview(webView)
    }
}
