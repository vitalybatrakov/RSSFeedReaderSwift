//
//  AddSourceViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 17.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

class AddSourceViewController: UIViewController {
    
    var feedSourceStorage: FeedSourceStorage!
    var feedService: FeedService!
    
    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var progessIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sourceTextField.becomeFirstResponder()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        if validateUrl(urlString: sourceTextField.text) {
            showProgressIndicator()
            addSource()
        } else {
            showAlert(title: "Error", msg: "Invalid url")
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func validateUrl(urlString: String?) -> Bool {
        guard let string = urlString,
            let url = URL(string: string) else {
                return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    private func showProgressIndicator() {
        progessIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    private func hideProgressIndicator() {
        progessIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    private func addSource() {
        guard let text = sourceTextField.text, let url = URL(string: text) else { return }
        feedService.getFeed(with: url, complition: { feed in
            let source = FeedSource(title: feed.title, url: text)
            self.feedSourceStorage.add(source: source)
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
