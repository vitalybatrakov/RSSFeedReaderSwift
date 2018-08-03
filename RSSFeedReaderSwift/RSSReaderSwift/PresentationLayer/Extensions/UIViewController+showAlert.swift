//
//  UIViewController+ShowAlerts.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 19.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title : String?,
                   msg : String,
                   style: UIAlertControllerStyle = .alert) {
        let ac = UIAlertController.init(title: title,
                                        message: msg,
                                        preferredStyle: style)
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default,
                                        handler: nil))
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
    
}
