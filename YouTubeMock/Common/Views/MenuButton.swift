//
//  MenuButton.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 22.09.26.
//

import UIKit

class MenuButton: UIButton {
    convenience init() {
        self.init(primaryAction: nil)
        setImage(UIImage(named: "menuButton"), for: .normal)
        setupConstraints()
    }
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
}
