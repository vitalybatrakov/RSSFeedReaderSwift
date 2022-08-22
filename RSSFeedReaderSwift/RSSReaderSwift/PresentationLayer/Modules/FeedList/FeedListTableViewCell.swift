//
//  FeedListTableViewCell.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 10.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import Kingfisher

final class FeedListTableViewCell: UITableViewCell, ReusableView {
    
    // MARK: - Properties
    
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var detailsLabel: UILabel!
    @IBOutlet private(set) var imgView: UIImageView!
    
    // MARK: - Layout constants
    
    private enum LayoutConstants {
        static let imageCornerRadius: CGFloat  = 10.0
    }
    
    // MARK: - Public methods
    
    func setTitle(with string: String) {
        titleLabel?.text = string
    }
    
    func setDetails(with string: String) {
        detailsLabel?.text = string
    }
    
    func setImageView(with imageUrl: String?, placeholder: UIImage?) {
        guard let url = imageUrl else {
            imgView.image = placeholder
            return
        }
        imgView?.kf.indicatorType = .activity
        imgView?.kf.setImage(with: URL(string: url), placeholder: placeholder)
        imgView.layer.roundCorners(corners: [.allCorners],
                                   radius: LayoutConstants.imageCornerRadius)
    }
    
}
