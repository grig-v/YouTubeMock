//
//  UILabel+Extension.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont = .systemFont(ofSize: 10, weight: .medium), textColor: UIColor = UIColor.white) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
