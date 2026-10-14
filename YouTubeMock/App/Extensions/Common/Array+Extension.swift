//
//  Array+Extension.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 14.10.26.
//

import UIKit

extension Array {
    mutating func extractFirst(_ count: Int) -> [Element] {
        let safeCount = Swift.max(0, Swift.min(count, self.count))
        let extractedElements = Array(self.prefix(safeCount))
        self.removeFirst(safeCount)
        return extractedElements
    }
}

