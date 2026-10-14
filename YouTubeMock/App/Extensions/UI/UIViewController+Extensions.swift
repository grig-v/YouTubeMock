//
//  UIViewController+Extensions.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

extension UIViewController {
    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
