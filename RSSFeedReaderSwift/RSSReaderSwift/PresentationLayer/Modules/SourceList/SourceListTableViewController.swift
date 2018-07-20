//
//  SourceListTableViewController.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 10.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

class SourceListTableViewController: UITableViewController {
    
     var feedSourceStorage: FeedSourceStorage!
     var feedService: FeedService!
     var onBackAction: (() -> Void)!
    
     var sources = [FeedSource]()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         updateSources()
     }

     private func updateSources() {
         sources = feedSourceStorage.getSources()
     }
     
     override func willMove(toParentViewController parent: UIViewController?) {
         super.willMove(toParentViewController: parent)
         if parent == nil {
             onBackAction()
         }
     }
     
     private func updateTable() {
          updateSources()
          tableView.reloadData()
     }

     @IBAction func editButtonPressed(_ sender: Any) {
         tableView.isEditing = !tableView.isEditing
     }
    
     // MARK: - Table view data source

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return sources.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceListTableViewCellId", for: indexPath)
        configure(cell: cell, with: sources[indexPath.row])
        return cell
     }

     private func configure(cell: UITableViewCell, with source: FeedSource) {
        cell.detailTextLabel?.text = source.url
        cell.textLabel?.text = source.title
     }

     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeSource(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
     }

     private func removeSource(at index: Int) {
        sources.remove(at: index)
        feedSourceStorage.save(sources: sources)
     }

     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let source = sources.remove(at: fromIndexPath.row)
        sources.insert(source, at: to.row)
        feedSourceStorage.save(sources: sources)
     }
}

extension SourceListTableViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSourceSegue" {
            let viewController = segue.destination as! AddSourceViewController
            viewController.feedSourceStorage = feedSourceStorage
            viewController.feedService = feedService
            viewController.onAddNewSource = {
               self.updateTable()
            }
        }
    }
    
}
