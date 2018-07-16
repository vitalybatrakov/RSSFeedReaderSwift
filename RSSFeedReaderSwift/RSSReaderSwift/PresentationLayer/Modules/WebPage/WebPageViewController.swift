//
//  WebPageViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 16.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    var pageUrl: URL!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupWebView()
    }

    private func setupWebView() {
        let webView = WKWebView(frame: view.frame)
        webView.load(URLRequest(url: pageUrl))
        view.addSubview(webView)
    }
}
