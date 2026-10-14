//
//  HeaderRepresentable.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

protocol HeaderRepresentable: UIView {
    var delegate: FeedHeaderDelegate? { get set }
    func configure(with filters: [FeedFilter])
}
