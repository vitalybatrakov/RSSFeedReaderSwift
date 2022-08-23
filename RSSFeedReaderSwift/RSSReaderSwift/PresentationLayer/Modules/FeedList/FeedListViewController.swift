//
//  FeedListViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 06.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import Kingfisher

final class FeedListViewController: UIViewController {
    
    // MARK: - Services
    
    private var feedService: FeedService!
    private var feedSourceStorage: FeedSourceStorage!
    
    // MARK: - IBOutlets
    
    @IBOutlet private(set) var tableView: UITableView!
    
    // MARK: - Properties
    
    private var feeds = [Feed]()
    private let placeholderImage = R.image.placeholder128()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchFeeds()
    }
    
    // MARK: - Services DI
    
    typealias Dependencies = (feedService: FeedService, feedSourceStorage: FeedSourceStorage)
    
    func setupServices(dependencies: Dependencies) {
        feedService = dependencies.feedService
        feedSourceStorage = dependencies.feedSourceStorage
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        tableView.dataSource = self
    }
    
    private func fetchFeeds() {
        Task {
            let results = await feedService.getFeeds()
            
            self.feeds = results.map {
                switch $0 {
                case .success(let feed):
                    return feed
                    
                case .failure(let error):
                    return Feed(title: error.localizedDescription, items: [])
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource
    
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

// MARK: - Navigation

extension FeedListViewController: SeguePerformerType {
    
    enum SegueIdentifier: String {
        case feedDetails
        case sourceList
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .feedDetails:
            let viewController = segue.destination as! FeedItemDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                viewController.feedItem = feeds[indexPath.section].items[indexPath.row]
            }
        case .sourceList:
            let viewController = segue.destination as! SourceListViewController
            viewController.feedSourceStorage = feedSourceStorage
            viewController.feedService = feedService
            viewController.onBackAction = { [weak self] in
                self?.fetchFeeds()
            }
        }
    }
}

// MARK: - StoryboardInitializable

extension FeedListViewController: StoryboardInitializable {}
