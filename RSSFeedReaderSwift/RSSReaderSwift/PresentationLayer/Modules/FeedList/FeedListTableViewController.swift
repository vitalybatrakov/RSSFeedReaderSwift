//
//  FeedListTableViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 06.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import Kingfisher

class FeedListTableViewController: UITableViewController {
    
    var feedService: FeedService!
    var feedSourceStorage: FeedSourceStorage!
    
    private var feeds = [Feed]()
    private let placeholderImage = UIImage(named: "placeholder-128")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFeeds()
    }
    
    private func fetchFeeds() {
        feedService.getFeeds { (results) in
            self.feeds = results.map {
                switch $0 {
                case .success(let feed):
                    return feed
                case .error(let message):
                    return Feed(title: message, items: [])
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return feeds[section].title
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return feeds.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedListTableViewCellId", for: indexPath) as! FeedListTableViewCell
        let feedItem = feeds[indexPath.section].items[indexPath.row]
        configure(cell: cell, with: feedItem)
        return cell
    }
    
    private func configure(cell: FeedListTableViewCell, with feedItem: FeedItem) {
        cell.detailsLabel?.text = feedItem.body
        cell.titleLabel?.text = feedItem.title
        if let imageUrl = feedItem.imageUrl {
            cell.imgView?.kf.indicatorType = .activity
            cell.imgView?.kf.setImage(with: URL(string: imageUrl), placeholder: placeholderImage)
        } else {
            cell.imgView.image = placeholderImage
        }
    }
}

extension FeedListTableViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "FeedDetailsSegue":
            let viewController = segue.destination as! FeedItemDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                viewController.feedItem = feeds[indexPath.section].items[indexPath.row]
            }
        case "SourceListSegue":
            let viewController = segue.destination as! SourceListTableViewController
            viewController.feedSourceStorage = feedSourceStorage
            viewController.feedService = feedService
            viewController.onBackAction = {
                self.fetchFeeds()
            }
        default:
            break
        }
    }
}
