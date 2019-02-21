//
//  FeedItemDetailsViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 10.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import Rswift

class FeedItemDetailsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var feedItem: FeedItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewWithFeedItem()
    }
    
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

extension FeedItemDetailsViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebPageSegue" {
            let viewController = segue.destination as! WebPageViewController
            viewController.pageUrl = URL(string: feedItem.link)
        }
    }
}

extension FeedItemDetailsViewController: StoryboardInitializable {}
