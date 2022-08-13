//
//  AddSourceViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 17.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

final class AddSourceViewController: UIViewController {
    
    // MARK: - Services
    
    private var feedSourceStorage: FeedSourceStorage!
    private var feedService: FeedService!
    
    // MARK: - Callback actions
    
    private var onAddNewSource: (() -> Void)!
    
    // MARK: - IBOutlets
    
    @IBOutlet private(set) var sourceTextField: UITextField!
    @IBOutlet private(set) var progessIndicator: UIActivityIndicatorView!
    
    // MARK: - Dependencies DI
    
    typealias Dependencies = (feedService: FeedService,
                              feedSourceStorage: FeedSourceStorage,
                              onAddNewSource: () -> Void)
    
    func setup(dependencies: Dependencies) {
        feedService = dependencies.feedService
        feedSourceStorage = dependencies.feedSourceStorage
        onAddNewSource = dependencies.onAddNewSource
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions

    @IBAction func addButtonTapped(_ sender: Any) {
        guard validateUrl(urlString: sourceTextField.text) else {
            showAlert(title: "Error", msg: "Invalid url")
            return
        }
        showProgressIndicator()
        addSource()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Private methods

extension AddSourceViewController {
    
    private func validateUrl(urlString: String?) -> Bool {
        guard
            let string = urlString,
            let url = URL(string: string)
        else {
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
        guard
            let text = sourceTextField.text,
            let url = URL(string: text)
        else {
            return
        }
        feedService.getFeed(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let feed):
                    let source = FeedSource(title: feed.title, url: text)
                    self.feedSourceStorage.add(source: source)
                    self.onAddNewSource()
                    self.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    self.showAlert(title: "Error", msg: error.localizedDescription)
                    self.hideProgressIndicator()
                }
            }
        }
    }
}

// MARK: - StoryboardInitializable

extension AddSourceViewController: StoryboardInitializable {}
