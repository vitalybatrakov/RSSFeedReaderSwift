//
//  FeedItemDetailsViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 10.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

final class FeedItemDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var feedItem: FeedItem!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewWithFeedItem()
    }
    
    // MARK: - Private methods
    
    private func setupViewWithFeedItem() {
        titleLabel.text = feedItem.title
        descriptionLabel.text = feedItem.body
        if let imageUrl = feedItem.imageUrl {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: imageUrl),
                                  placeholder: R.image.placeholder128())
        }
    }
}

// MARK: - Navigation

extension FeedItemDetailsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebPageSegue" {
            let viewController = segue.destination as! WebPageViewController
            viewController.pageUrl = URL(string: feedItem.link)
        }
    }
}

// MARK: - StoryboardInitializable

extension FeedItemDetailsViewController: StoryboardInitializable {}
