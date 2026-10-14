//
//  FeedFilter.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 07.10.26.
//

import Foundation
// TODO: подумать о переносе в новый Service
nonisolated enum FeedFilter: Hashable {
    case all
    case category(MediaCategory)
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case.category(let category):
            return category.rawValue
        }
    }
    
    func isMatches(_ video: Video) -> Bool {
        switch self {
        case .all:
            return true
        case .category(let category):
            return video.category.contains(category)
        }
    }
    
    func apply(to videos: [Video]) -> [Video] {
        return videos.filter { isMatches($0) }
    }
}
