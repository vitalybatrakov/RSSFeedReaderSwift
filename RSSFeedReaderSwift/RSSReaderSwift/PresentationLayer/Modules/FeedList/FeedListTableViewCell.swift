//
//  FeedListTableViewCell.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 10.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit
import Kingfisher

class FeedListTableViewCell: UITableViewCell, ReusableView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    
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
        imgView.layer.roundCorners(corners: [.allCorners], radius: 10) //faster than cornerRadius
    }
    
}
