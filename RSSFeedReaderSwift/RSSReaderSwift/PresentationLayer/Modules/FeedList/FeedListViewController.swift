//
//  FeedListViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 06.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import Kingfisher

class FeedListViewController: UIViewController {
    
    var feedService: FeedService!
    var feedSourceStorage: FeedSourceStorage!
    
    @IBOutlet var tableView: UITableView!
    private var feeds = [Feed]()
    private let placeholderImage = R.image.placeholder128()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchFeeds()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
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
    
}
    
extension FeedListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return feeds[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let feedItem = feeds[indexPath.section].items[indexPath.row]
        configure(cell: cell, with: feedItem)
        return cell
    }
    
    private func configure(cell: FeedListTableViewCell, with feedItem: FeedItem) {
        cell.setDetails(with: feedItem.body)
        cell.setTitle(with: feedItem.title)
        cell.setImageView(with: feedItem.imageUrl, placeholder: placeholderImage)
    }
}

extension FeedListViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "FeedDetailsSegue":
            let viewController = segue.destination as! FeedItemDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                viewController.feedItem = feeds[indexPath.section].items[indexPath.row]
            }
        case "SourceListSegue":
            let viewController = segue.destination as! SourceListViewController
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

extension FeedListViewController: StoryboardInitializable {}
