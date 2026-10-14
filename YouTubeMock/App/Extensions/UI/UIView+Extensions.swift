//
//  UIView+Extensions.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

extension UIView { // for debug
    func addColoredBorder(_ color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
    }
    
    func fillSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}
