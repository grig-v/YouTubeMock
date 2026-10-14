//
//  SeparatorView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 08.10.26.
//

import UIKit

class SeparatorView: UIView {

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .separator
        translatesAutoresizingMaskIntoConstraints = false
    }

}
