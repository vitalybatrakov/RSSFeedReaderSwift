//
//  SeguePerformerType.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 04/03/2019.
//  Copyright © 2019 vbat. All rights reserved.
//

import UIKit

protocol SeguePerformerType {
    
    associatedtype SegueIdentifier: RawRepresentable
}

extension SeguePerformerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegue(_ segue: SegueIdentifier, sender: Any? = nil) {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
    
    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
        else {
            fatalError("\(type(of: self)): undefined segue identifier \(segue.identifier!).")
        }
        return segueIdentifier
    }
}
