//
//  FeedListTableViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 06.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

class FeedListTableViewController: UITableViewController {
    
    var feedService: FeedService!
    
    var feeds = [Feed]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchFeeds()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchFeeds() {
        feedService.getFeeds { (feeds) in
            DispatchQueue.main.async {
                self.feeds = feeds
                self.tableView.reloadData()
            }
        }
    }

}

extension FeedListTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return feeds.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedListTableViewCellId", for: indexPath)
        let feedItem = feeds[indexPath.section].items[indexPath.row]
        cell.detailTextLabel?.text = feedItem.body
        cell.textLabel?.text = feedItem.title
        return cell
    }
    
}
