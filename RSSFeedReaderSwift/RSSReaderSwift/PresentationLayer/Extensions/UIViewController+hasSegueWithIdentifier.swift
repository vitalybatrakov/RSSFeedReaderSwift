//
//  UIViewController+hasSegueWithIdentifier.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 01.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hasSegueWithIdentifier(id: String) -> Bool {
        let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        return !(filtered?.isEmpty ?? true)
    }
    
}
