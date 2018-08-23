//
//  CALayer+roundCorners.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 23.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import UIKit

extension CALayer {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        mask = shape
    }
}
