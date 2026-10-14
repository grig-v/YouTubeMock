//
//  UIButton+Extensoin.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

extension UIButton {
    convenience init(imageName: String) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
    }
}
