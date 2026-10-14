//
//  FeedHeaderDelegate.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

protocol FeedHeaderDelegate: AnyObject {
    func headerView(_ headerView: UIView, didSelect feedFilter: FeedFilter)
}
