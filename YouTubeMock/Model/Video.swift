//
//  Video.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 21.09.26.
//

import Foundation

// Модель для видео (длинные и шортсы)
nonisolated struct Video: Hashable, Identifiable {
    let previewImageURL: URL
    let title: String
    var viewCount: Int
    var likesCount: Int
    var commentsCount: Int
    let date = Date()
    let author: User
    let category: [MediaCategory]
    let id = UUID()
}


 
