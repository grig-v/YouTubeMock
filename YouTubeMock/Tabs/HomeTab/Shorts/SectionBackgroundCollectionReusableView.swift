//
//  SectionBackgroundCollectionReusableView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 30.09.26.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
