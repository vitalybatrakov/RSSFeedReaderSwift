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
    
    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var progessIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
